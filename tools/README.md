
# yplayer/tools

## 【内容】

- [【簡易 radiko.jp プレミアム対応 Radiko 録音スクリプト rec_radiko2.sh】](#【簡易-radiko.jp-プレミアム対応-Radiko-録音スクリプト-rec_radiko2.sh】)

- [【HLS 対応 Radiko 録音スクリプト rec_radiko_live.sh】](#【HLS-対応-Radiko-録音スクリプト-rec_radiko_live.sh】)

- [【ラジコタイムフリー録音スクリプト rec_radiko_ts.sh】](#【ラジコタイムフリー録音スクリプト-rec_radiko_ts.sh】)

- [【Raspberry Pi に Ruby on Rails をインストールする方法】](#【Raspberry-Pi-に-Ruby-on-Rails-をインストールする方法】)

- [【systemd を使って yplayer を自動起動する。】](#【systemd-を使って-yplayer-を自動起動する。】)

- [【crontab で設定されたスクリプトの時刻を曜日別に表示するプログラム print_crontab.rb】](#【crontab-で設定されたスクリプトの時刻を曜日別に表示するプログラム-print_crontab.rb】)

## 【簡易 radiko.jp プレミアム対応 Radiko 録音スクリプト rec_radiko2.sh】

**<注意>**

Flash 版の RTMP を利用した rec_radiko2.sh ではなく、HLS配信データを保存する rec_radiko_live.sh を使用してください。

2019/01/13(Sun) 15:19:43 時点では rec_radiko2.sh を使用して MP3 形式 (拡張子 .mp3) の音声ファイルを録音できますが、いつ停止されるかわかりません。rec_radiko_live.sh で保存された AAC 形式 (拡張子 .m4a) の音声ファイルの方が MP3 形式の約半分のサイズで済むので、断然 rec_radiko_live.sh を使うべきです。

rec_radiko2.sh の詳細は、[ReadMe.txt](ReadMe.txt)、rec_radiko_live.sh は [【HLS 対応 Radiko 録音スクリプト rec_radiko_live.sh】](#【HLS-対応-Radiko-録音スクリプト-rec_radiko_live.sh】) を参照してください。


## 【HLS 対応 Radiko 録音スクリプト rec_radiko_live.sh】

**<実行例>**

```
~ $ ./rec_radiko_live.sh -s TBS -d 160 -m name@example.com -p password -o "/home/pi/radio/tama/daikichi_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
```

ターミナルで上記スクリプト rec_radiko_live.sh を実行すると radiko.jp ラジコプレミアムにメールアドレス name@example.com、パスワード password でログインしてスクリプトを実行します。date コマンドより実行した時刻 2018 年 12 月 12 日 12 時 55分 からファイル名 daikichi_2018-12-12-12_55.m4a を作成し、TBS ラジオを 160 分録音してディレクトリ /home/pi/radio/tama に保存します。

HLS 対応 Radiko 録音スクリプト rec_radiko_live.sh のダウンロードや詳細は下記 URL を参照してください。

[GitHub - uru2/rec_radiko_live: Radiko Live program recorder](https://github.com/uru2/rec_radiko_live)  
[https://github.com/uru2/rec_radiko_live](https://github.com/uru2/rec_radiko_live)


## 【ラジコタイムフリー録音スクリプト rec_radiko_ts.sh】

rec_radiko_live.sh を使ったラジコのライブ録音に失敗した場合、過去１週間以内なら、ラジコのタイムフリーを録音するスクリプト rec_radiko_ts.sh を使ってダウンロードできます。

**<実行例>**

```
~ $ ./rec_radiko_ts.sh -s TBS -f 201812121255 -t 201812121535 -o "daikichi_2018-12-12-12_55_ts.m4a" -m "name@example.com" -p "password"
```

ターミナルで上記スクリプト rec_radiko_ts.sh を実行すると radiko.jp ラジコプレミアムにメールアドレス name@example.com、パスワード password でログインしてスクリプト実行します。録音開始日時が -f 201812121255 より 2018 年 12 月 12 日 12 時 55分、終了日時が -t 201812121535 より 2018 年 12 月 12 日 15 時 35 分になります。ファイル名は daikichi_2018-12-12-12_55_ts.m4a です。

ラジコタイムフリー録音スクリプト rec_radiko_ts.sh のダウンロードや詳細は下記 URL を参照してください。

[GitHub - uru2/rec_radiko_ts: Radiko timefree program recorder](https://github.com/uru2/rec_radiko_ts)  
[https://github.com/uru2/rec_radiko_ts](https://github.com/uru2/rec_radiko_ts)


## 【Raspberry Pi に Ruby on Rails をインストールする方法】

[Install Ruby On Rails on Ubuntu 18.04 Bionic Beaver | GoRails](https://gorails.com/setup/ubuntu/18.04)  
[https://gorails.com/setup/ubuntu/18.04](https://gorails.com/setup/ubuntu/18.04)  

上記 URL、Ubuntu 18.04 に Ruby on Rails をインストールする手順を Raspberry Pi 用に置き換えたものが下記の説明です。これが正しいのか自信がないので、あくまでも参考程度にしてください。


1. apt-get コマンドを使って必要なパッケージをインストールする。必要のないものは省かれるので Y を入力して実行する。ただし、software-properties-common だけは、あらかじめ削除した。

```
pi@raspberrypi:~ $ sudo apt-get update
pi@raspberrypi:~ $ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev nodejs yarn

パッケージリストを読み込んでいます... 完了
依存関係ツリーを作成しています                
状態情報を読み取っています... 完了
注意、'yarn' の代わりに 'cmdtest' を選択します
build-essential はすでに最新バージョン (12.3) です。
curl はすでに最新バージョン (7.52.1-5+deb9u8) です。
zlib1g-dev はすでに最新バージョン (1:1.2.8.dfsg-5) です。
zlib1g-dev は手動でインストールしたと設定されました。
nodejs はすでに最新バージョン (8.11.1~dfsg-2~bpo9+1) です。
nodejs は手動でインストールしたと設定されました。
以下の追加パッケージがインストールされます:
  icu-devtools libicu-dev libssl-doc libtinfo-dev python-cliapp
  python-markdown python-pygments python-ttystatus python-yaml
提案パッケージ:
  libcurl4-doc libcurl3-dbg libidn11-dev libkrb5-dev libldap2-dev librtmp-dev
  libssh2-1-dev libssl1.0-dev | libssl-dev icu-doc readline-doc sqlite3-doc
  libyaml-doc python-markdown-doc ttf-bitstream-vera
以下のパッケージが新たにインストールされます:
  cmdtest git-core icu-devtools libcurl4-openssl-dev libffi-dev libicu-dev
  libreadline-dev libsqlite3-dev libssl-dev libssl-doc libtinfo-dev
  libxml2-dev libxslt1-dev libyaml-dev python-cliapp python-markdown
  python-pygments python-ttystatus python-yaml sqlite3
アップグレード: 0 個、新規インストール: 20 個、削除: 0 個、保留: 4 個。
22.8 MB のアーカイブを取得する必要があります。
この操作後に追加で 96.3 MB のディスク容量が消費されます。
続行しますか? [Y/n]
```

2. rbenv をインストールして環境を設定する。

```
pi@raspberrypi:~ $ cd
pi@raspberrypi:~ $ pwd
/home/pi
pi@raspberrypi:~ $ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
pi@raspberrypi:~ $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
pi@raspberrypi:~ $ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
pi@raspberrypi:~ $ exec $SHELL
```

3. ruby をビルドするために必要な ruby-build をインストールして設定する。

```
pi@raspberrypi:~ $ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
pi@raspberrypi:~ $ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
pi@raspberrypi:~ $ exec $SHELL
```

4. rbenv install -l コマンドでインストールできる ruby のバージョンを確認し、ruby バージョン 2.6.1p33 をインストールする。ビルドには数時間かかるので注意してください。

```
pi@raspberrypi:~ $ rbenv install -l
Available versions:
  1.8.5-p52
  .
  .
  省略
  .
  .
  2.5.0-dev
  2.5.0-preview1
  2.5.0-rc1
  2.5.0
  2.5.1
  2.5.2
  2.5.3
  2.6.0-dev
  2.6.0-preview1
  2.6.0-preview2
  2.6.0-preview3
  2.6.0-rc1
  2.6.0-rc2
  2.6.0
  2.6.1
  2.7.0-dev
  jruby-1.5.6
  .
  .
  省略
  .
  .
pi@raspberrypi:~ $ rbenv install 2.6.1
pi@raspberrypi:~ $ ruby -v
ruby 2.6.1p33 (2019-01-30 revision 66950) [armv6l-linux-eabihf]
```

5. bundler をインストールする。
```
pi@raspberrypi:~ $ gem install bundler
```

6. gem search ^rails$ -a でインストールできる Ruby on Rails のバージョンを確認する。コマンド gem install rails -v 5.2.2 で、Ruby on Rails の最新バージョン 5.2.2 をインストールする。i18n-1.5.3 パッケージをインストールしている時に下記メッセージが出るがインストールには成功する。

```
pi@raspberrypi:~ $ gem search ^rails$ -a

*** REMOTE GEMS ***

rails (5.2.2, 5.2.1.1, 5.2.1, 5.2.0, 5.1.6.1, 5.1.6, 5.1.5, 5.1.4, 5.1.3, 5.1.2, 5.1.1, 5.1.0, 5.0.7.1, 5.0.7, 5.0.6, 5.0.5, 5.0.4, 5.0.3, 5.0.2, 5.0.1, 5.0.0.1, 5.0.0, 4.2.11, 4.2.10, 4.2.9, 4.2.8, 4.2.7.1, 4.2.7, 4.2.6, 4.2.5.2, 4.2.5.1, 
.
.
省略
.
.
0.9.0, 0.8.5, 0.8.0)

pi@raspberrypi:~ $ gem install rails -v 5.2.2

Fetching tzinfo-1.2.5.gem
Fetching rack-test-1.1.0.gem
.
.
省略
.
.
Fetching activestorage-5.2.2.gem
Fetching sprockets-rails-3.2.1.gem
Successfully installed concurrent-ruby-1.1.4

HEADS UP! i18n 1.1 changed fallbacks to exclude default locale.
But that may break your application.

Please check your Rails app for 'config.i18n.fallbacks = true'.
If you're using I18n (>= 1.1.0) and Rails (< 5.2.2), this should be
'config.i18n.fallbacks = [I18n.default_locale]'.
If not, fallbacks will be broken in your app by I18n 1.1.x.

For more info see:
https://github.com/svenfuchs/i18n/releases/tag/v1.1.0

Successfully installed i18n-1.5.3
Successfully installed thread_safe-0.3.6
  .
  .
  省略
  .
  .
Parsing documentation for sprockets-3.7.2
Installing ri documentation for sprockets-3.7.2
Parsing documentation for sprockets-rails-3.2.1
Installing ri documentation for sprockets-rails-3.2.1
Parsing documentation for rails-5.2.2
Installing ri documentation for rails-5.2.2
Done installing documentation for concurrent-ruby, i18n, thread_safe, tzinfo, activesupport, rack, rack-test, mini_portile2, nokogiri, crass, loofah, rails-html-sanitizer, rails-dom-testing, builder, erubi, actionview, actionpack, activemodel, arel, activerecord, globalid, activejob, mini_mime, mail, actionmailer, nio4r, websocket-extensions, websocket-driver, actioncable, mimemagic, marcel, activestorage, thor, method_source, railties, sprockets, sprockets-rails, rails after 1982 seconds
38 gems installed

pi@raspberrypi:~ $ 
```

7. Rails を実行する前に gem からインストールしたコマンドが shims に反映されるように、コマンド rbenv rehash を実行する。

```
pi@raspberrypi:~ $ rbenv rehash
pi@raspberrypi:~ $ 
```

8. 下記に 8 GB の SD カードに Raspbian と Ruby on Rails をインストールした直後のディスク容量をコマンド df -h で表示しています。

```
pi@raspberrypi:~ $ df -h

ファイルシス           サイズ      使用      残り       使用%     マウント位置
/dev/root            7.1G      5.6G      1.3G       83%      /
devtmpfs             213M         0      213M        0%      /dev
tmpfs                217M         0      217M        0%      /dev/shm
tmpfs                217M       23M      195M       11%      /run
tmpfs                5.0M      4.0K      5.0M        1%      /run/lock
tmpfs                217M         0      217M        0%      /sys/fs/cgroup
/dev/mmcblk0p1        44M       23M       22M       51%      /boot
tmpfs                 44M         0       44M        0%      /run/user/1000
pi@raspberrypi:~ $
```

## 【systemd を使って yplayer を自動起動する。】

```
 $ bin/rails secret
760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb
```

上記のように [../README.md](../README.md) の 'インストールと yplayer の起動'、'6. 秘密鍵の表示' で表示した秘密鍵を [yplayer-web.service.txt](yplayer-web.service.txt) の "SECRET_KEY_BASE=" に設定する。ダブルクォーテーションで囲む範囲をを間違えないようにしてください。

```
yplayer-web.service.txt

11行目:
Environment="SECRET_KEY_BASE=760a21dfc61f8d3d376b2854db951c99c1e248b76c9ec346152017431ab3a9babf1e958709b7827b9f4a67e261e5ce1721b4da3af9db3b6324f924f2809c6fdb"
```

yplayer-web.service.txt の編集には nano を使用してください。macOS などのターミナルで ssh を使ってログインしている場合、macOS 側で秘密鍵をコピーし、ターミナル上でファイル yplayer-web.service.txt を nano で開き、挿入したい位置にカーソルを移動した後、ターミナルのメニュー > 編集 > ペースト を使うと簡単に入力できます。

```
pi@raspberrypi:~ $ cd rails/yplayer/tools
pi@raspberrypi:~/rails/yplayer/tools $ ls
KOYAMA Yoshiaki のブログ.webloc  radiko_curl_area.sh
README.md                            radiko_wget_area.sh
ReadMe.txt                           rec_radiko2.sh
delete.py                            yplayer-web.service.txt
print_crontab.rb
pi@raspberrypi:~/rails/yplayer/tools $ nano yplayer-web.service.txt 
```

yplayer のディレクトリが /home/pi/rails/yplayer でない場合は WorkingDirectory= に設定してください。
ただし、yplayer-web.service.txt では実行時のユーザーが pi になってます。違う場合は、User、ExecStart の値をそれぞれ変更してください。

```
yplayer-web.service.txt

7行目:
User=pi
WorkingDirectory=/home/pi/rails/yplayer

12行目
ExecStart=/home/pi/.rbenv/shims/bundle exec puma -C config/puma.rb
```

最後に yplayer-web.service.txt を yplayer-web.service という名前で /etc/systemd/system/ にコピーし、sudo systemctl enable yplayer-web.service、sudo systemctl start yplayer-web.service でサービスを起動します。

```
i@raspberrypi:~/rails/yplayer/tools $ sudo cp yplayer-web.service.txt /etc/systemd/system/yplayer-web.service
pi@raspberrypi:~/rails/yplayer/tools $ sudo systemctl enable yplayer-web.service
Created symlink /etc/systemd/system/multi-user.target.wants/yplayer-web.service → /etc/systemd/system/yplayer-web.service.
pi@raspberrypi:~/rails/yplayer/tools $ sudo systemctl start yplayer-web.service
pi@raspberrypi:~/rails/yplayer/tools $
```

systemctl コマンド一覧

```
sudo systemctl enable yplayer-web.service
sudo systemctl start yplayer-web.service
sudo systemctl restart yplayer-web.service
sudo systemctl stop yplayer-web.service
sudo systemctl is-enabled yplayer-web.service
sudo systemctl is-active yplayer-web.service
```

電源を入れると yplayer-web.service が自動で起動するので、yplayer を起動する必要はありません。

**<参考文献>**

[Software Design 2018年2月号 | Gihyo Digital Publishing](https://gihyo.jp/dp/ebook/2018/978-4-7741-9210-9)  
[https://gihyo.jp/dp/ebook/2018/978-4-7741-9210-9](https://gihyo.jp/dp/ebook/2018/978-4-7741-9210-9)  
第2特集  
さまざまなLinuxディストリでスタンダードに  
systemd実践入門  

[documentation/Production-guide.md at master · tootsuite/documentation · GitHub](
https://github.com/tootsuite/documentation/blob/master/Running-Mastodon/Production-guide.md)  [https://github.com/tootsuite/documentation/blob/master/Running-Mastodon/Production-guide.md](https://github.com/tootsuite/documentation/blob/master/Running-Mastodon/Production-guide.md)  
Mastodon systemd Service Files

## 【crontab で設定されたスクリプトの時刻を曜日別に表示するプログラム print_crontab.rb】

Radiko.jp プレミアムは、1つのID/パスワードで、同時にログイン可能な機器が3つまでです。１つのIDで同じ時間帯に３つまでスクリプトを実行できます。(注意、[【HLS 対応 Radiko 録音スクリプト rec_radiko_live.sh】](#【HLS-対応-Radiko-録音スクリプト-rec_radiko_live.sh】) は、同じクッキーを利用するので、同じ時間帯に実行できるスクリプトに制限はありません。)

録音している時間帯に幾つのスクリプトが起動しているか判断するのに利用したり、曜日別に予約している時刻を表示するプログラム print_crontab.rb を作成してみました。

```
pi@raspberrypi:~ $ crontab -l
0 13 * * 0 /home/pi/rec_radiko2.sh TBS 240 name@example.com passsword /home/pi/radio/bakusyo
0 7 * * 1-5 /home/pi/rec_nhk.sh NHK2 15 /home/pi/radio/nhk2 germany
55 12 * * 3 /home/pi/rec_radiko_live.sh -s TBS -d 160 -m name@example.com -p passsword -o "/home/pi/radio/tama/daikichi_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
.
.
省略
.
.
```
crontab -l コマンドで表示した設定ファイルから録音スクリプトのコマンドを変数、RADIKO_EXEC、NHK_EXEC、RADIKO_LIVE_EXEC に設定してください。

```
print_crontab.rb

40行目
RADIKO_EXEC = 'rec_radiko2.sh のフルパス'.freeze
NHK_EXEC = 'rec_nhk.sh のフルパス'.freeze
RADIKO_LIVE_EXEC = 'rec_radiko_live.sh のフルパス'.freeze
```

自分が使っている録音スクリプトの変数だけ設定してください。crontab に設定されていないコマンドの変数は無視されるので実行には影響はありません。初期値は下記の通りです。

```
print_crontab.rb

40行目
RADIKO_EXEC = '/home/pi/rec_radiko2.sh'.freeze
NHK_EXEC = '/home/pi/rec_nhk.sh'.freeze
RADIKO_LIVE_EXEC = '/home/pi/rec_radiko_live.sh'.freeze
```

RADIKO_EXEC は、[【簡易 radiko.jp プレミアム対応 Radiko 録音スクリプト rec_radiko2.sh】](#【簡易-radiko.jp-プレミアム対応-Radiko-録音スクリプト-rec_radiko2.sh】) 実行ファイルのパス。

NHK_EXEC は、[ 簡易らじるらじる(NHK)録音スクリプト rec_nhk.sh (2017/09 以降版) · GitHub ](https://gist.github.com/matchy2/9515cecbea40918add594203dc61406c) 実行ファイルのパス。

RADIKO_LIVE_EXEC は、[【HLS 対応 Radiko 録音スクリプト rec_radiko_live.sh】](#【HLS-対応-Radiko-録音スクリプト-rec_radiko_live.sh】) 実行ファイルのパス。

後は、ターミナルで下記のように ./print_crontab.rb を実行してください。

```
pi@raspberrypi:~ $ ./print_crontab.rb 
[Sun:日:0]
01:00 ( 125 minutes)   LFR "/home/pi/radio/night/odori_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
10:00 ( 120 minutes)   TBS "/home/pi/radio/azumi/TBS_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
13:00 ( 125 minutes)   TBS "/home/pi/radio/bakusyo/part1_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
15:00 ( 125 minutes)   TBS "/home/pi/radio/bakusyo/part2_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"

[Mon:月:1]
06:00 (  48 minutes)   LFR "/home/pi/radio/iida/part1_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
06:50 (  55 minutes)   LFR "/home/pi/radio/iida/part2_suda_`date +\%Y-\%m-\%d-\%H_\%M`.m4a"
.
.
省略
.
.
```
上記のように曜日別に時刻、録音時間、放送局の station id、保存ファイルのパスを表示します。

print_crontab.rb プログラムの内部で crontab -l を実行しています。 crontab -l で表示された内容をファイルに保存し、ファイル名を引数としてを渡して動作させることもできます。

crontab の設定を正しく反映させているわけではないので、おかしな表示をするかもしれません。厳密な動作チェックをしていないのでうまく動作しない可能性もあります。
