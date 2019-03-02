#!/usr/bin/ruby

#
# crontab
#
# 0 13 *  * 0 /home/pi/rec_radiko2.sh TBS 240 name@example.com passsword /home/pi/radio/bakusyo
# 何分(0-59) 何時(0-23) 何日(1-31) 何月(1-12) 何曜日(0-6) コマンド
#
# 曜日は
#
# 0: 日曜日
# 1: 月曜日
# 2: 火曜日
# 3: 水曜日
# 4: 木曜日
# 5: 金曜日
# 6: 土曜日
#
# rec_radiko2.sh
#
# 0 13 * * 0 /home/pi/rec_radiko2.sh TBS 240 name@example.com passsword /home/pi/radio/bakusyo
# 30 1 * * 2 /home/pi/rec_radiko2.sh FMT 25 name@example.com passsword /home/pi/radio/nakagawa
# 0 1 * * 2 /home/pi/rec_radiko2.sh TBS 120 name@example.com passsword /home/pi/radio/junk ijyuin
#
#
# 簡易らじるらじる(NHK)録音スクリプト (2017/09 以降版) · GitHub
# https://gist.github.com/matchy2/9515cecbea40918add594203dc61406c
#
# 0 7 * * 1-5 /home/pi/rec_nhk.sh NHK2 15 /home/pi/radio/nhk2 germany
#
#
# GitHub - uru2/rec_radiko_live: Radiko Live program recorder
# https://github.com/uru2/rec_radiko_live
#
# 55 12 * * 3 /home/pi/rec_radiko_live.sh -s TBS -d 160 -m name@example.com -p passsword -o "/home/pi/radio/tama/daikichi_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
#

require 'optparse'

RADIKO_EXEC = '/home/pi/rec_radiko2.sh'.freeze
NHK_EXEC = '/home/pi/rec_nhk.sh'.freeze
RADIKO_LIVE_EXEC = '/home/pi/rec_radiko_live.sh'.freeze

$week = ['[Sun:日:0]', '[Mon:月:1]', '[Tue:火:2]', '[Wed:水:3]', '[Thr:木:4]', '[Fri:金:5]', '[Sat:土:6]'].freeze
$database = {}

$week.each do |str|
  $database[str] = []
end

if ARGV.length.positive?
  log = ''
  Kernel.open(ARGV[0]) do |f|
    log = f.read
  end
else
  log = `crontab -l`
end

# "*" => [0,1,2,3,4,5,6]
# "1-5" => [1,2,3,4,5]
# "1" => [1]
# "0,4" => [0,4]
# "5,4,3" => [5,4,3]
def weekday_to_a(weekday)
  days = /(\d)\-(\d)/.match(weekday)

  array = if !days.nil?
            (days[1].to_i..days[2].to_i).to_a
          elsif weekday == '*'
            (0..6).to_a
          else
            weekday_comma_to_a(weekday)
          end
  array
end

# "1" => [1]
# "0,4" => [0,4]
# "5,4,3" => [5,4,3]
def weekday_comma_to_a(weekday)
  array = []
  days = /(\d\,)+(\d)/.match(weekday)

  if !days.nil?
    weekday.split(',').each do |i|
      array.push(i.to_i)
    end
  else
    array.push(weekday.to_i)
  end
  array
end

#
# -s TBS -d 155 -m name@example.com -p password -o "/home/pi/radio/tama/takeyama_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
# =>
# ["-s", "TBS", "-d", "155", "-m", "name@example.com", "-p", "password", "-o", "\"/home/pi/radio/tama/takeyama_`date +%Y-%m-%d-%H_%M`.m4a\""]
#
def split(str)
  array = []
  semi = false
  word = ''

  str.chars.each do |chr|
    semi, word, array = split_chr(semi, chr, word, array)
  end
  array
end

def split_chr(semi, chr, word, array)
  case chr
  when ' ' then
    word, array = split_space(semi, chr, word, array)
  when '"' then
    semi, word, array = split_semi(semi, chr, word, array)
  else
    word += chr
  end
  [semi, word, array]
end

def split_space(semi, chr, word, array)
  if semi
    word += chr
  elsif word != ''
    array.push(word)
    word = ''
  end
  [word, array]
end

def split_semi(semi, chr, word, array)
  word += chr
  if semi
    array.push(word)
    semi = false
    word = ''
  else
    semi = true
  end
  [semi, word, array]
end

def radiko_fstring_time(mat)
  minutes = mat[1].length == 1 ? '0' + mat[1] : mat[1]
  hour = mat[2].length == 1 ? '0' + mat[2] : mat[2]
  hour + ':' + minutes
end

def radiko_fstring(mat)
  time = radiko_fstring_time(mat)
  weekday = mat[5]

  station = format('%<station>5s', station: mat[7])
  len = format('%<len>4d', len: mat[8].to_i)

  [time, weekday, station, len]
end

def radiko_exec(mat)
  time, weekday, station, len = radiko_fstring(mat)

  dir = mat[11]
  name = mat[12]

  fstring = if name.nil?
              format('%<time>s (%<len>s minutes) %<station>s %<dir>s', time: time, len: len, station: station, dir: dir)
            else
              format('%<time>s (%<len>s minutes) %<station>s %<dir>s %<name>s', time: time, len: len, station: station, dir: dir, name: name)
            end

  push_database(weekday, fstring)
end

def push_database(weekday, fstring)
  weekday_to_a(weekday).each do |item|
    $database[$week[item]].push(fstring)
    $database[$week[item]].sort!
  end
end

def radiko_nhk(mat)
  time, weekday, station, len = radiko_fstring(mat)

  dir = mat[9]
  name = mat[10]

  fstring = if name.nil?
              format('%<time>s (%<len>s minutes) %<station>s %<dir>s', time: time, len: len, station: station, dir: dir)
            else
              format('%<time>s (%<len>s minutes) %<station>s %<dir>s %<name>s', time: time, len: len, station: station, dir: dir, name: name)
            end

  push_database(weekday, fstring)
end

def radiko_nhk_exec_mat(line)
  # 0 1 * * 2 /home/pi/rec_radiko2.sh TBS 120 name@example.com passsword /home/pi/radio/junk ijyuin
  mat = /(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s(.+)\s(.+)\s(.+)/.match(line)

  # 0 1 * * 2 /home/pi/rec_radiko2.sh TBS 120 name@example.com passsword /home/pi/radio/junk
  mat = /(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s(.+)\s(.+)/.match(line) if mat.nil?

  # 0 7 * * 1-5 /home/pi/rec_nhk.sh NHK2 15 /home/pi/radio/nhk2 germany
  mat = /(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)/.match(line) if mat.nil?

  # 0 7 * * 1-5 /home/pi/rec_nhk.sh NHK2 15 /home/pi/radio/nhk2
  mat = /(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)\s+(.+)/.match(line) if mat.nil?

  mat
end

def radiko_nhk_exec(line)
  mat = radiko_nhk_exec_mat(line)
  return if mat.nil?

  case mat[6]
  when RADIKO_EXEC then
    radiko_exec(mat)
  when NHK_EXEC then
    radiko_nhk(mat)
  end
end

def radiko_live_fstring_params(params)
  station = format('%<station>5s', station: params['s'])
  len = format('%<len>4d', len: params['d'].to_i)
  dir = params['o']

  [station, len, dir]
end

# 55 12 * * 1 /home/pi/rec_radiko_live.sh -s TBS -d 155 -m name@example.com -p password -o "/home/pi/radio/tama/takeyama_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
def radiko_live_exec(line)
  mat = /(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+)$/.match(line)

  params = OptionParser.getopts(split(mat[7]), 's:d:m:p:o:')

  time = radiko_fstring_time(mat)
  weekday = mat[5]
  station, len, dir = radiko_live_fstring_params(params)

  fstring = format('%<time>s (%<len>s minutes) %<station>s %<dir>s', time: time, len: len, station: station, dir: dir)

  push_database(weekday, fstring)
end

log.each_line do |line|
  mat = /(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.+?)\s+(.*)/.match(line)
  next if mat.nil?

  # 0 1 * * 2 /home/pi/rec_radiko2.sh
  # 0 7 * * 1-5 /home/pi/rec_nhk.sh
  # 55 12 * * 1 /home/pi/rec_radiko_live.sh
  case mat[6]
  when RADIKO_EXEC, NHK_EXEC then
    radiko_nhk_exec(line)
  when RADIKO_LIVE_EXEC then
    radiko_live_exec(line)
  end
end

$database.each do |k, v|
  puts k
  v.each do |i|
    puts i
  end
  puts ''
end
