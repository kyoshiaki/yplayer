module ApplicationHelper
  #
  # symbolic link
  #
  def root_home_name
    'radio'
  end

  #
  # yplayer/public/radio
  #
  def root_home_path
    Rails.root.join('public', root_home_name)
  end

  #
  # Returns the full title on a per-page basis.
  #
  def full_title(page_title = '')
    base_title = 'yplayer'
    if page_title.empty?
      base_title
    else
      # page_title + " | " + base_title
      page_title
    end
  end

  #
  # radio_dir("/home/pi/rails/yplayer/public/radio/tama/taki_2018-11-22-12_55.m4a")
  # =>
  # "Home/tama/taki_2018-11-22-12_55.m4a"
  #
  def radio_dir(path)
    radio_basedir(path, false)
  end

  #
  # radio_dirname("/home/pi/rails/yplayer/public/radio/tama/taki_2018-11-22-12_55.m4a")
  # =>
  # "Home/tama"
  #
  def radio_dirname(path)
    radio_basedir(path, true)
  end

  #
  # radio_basedir("/home/pi/rails/yplayer/public/radio/tama/taki_2018-11-22-12_55.m4a", true)
  # =>
  # "Home/tama"
  #
  # radio_basedir("/home/pi/rails/yplayer/public/radio/tama/taki_2018-11-22-12_55.m4a", false)
  # =>
  # "Home/tama/taki_2018-11-22-12_55.m4a"
  #
  def radio_basedir(abs_path, dirname_flag = true)
    path = if abs_path.is_a?(String)
             abs_path
           else
             abs_path.to_s
           end

    if File.basename(path) == root_home_name
      'Home'
    else
      radio_basedir_regex(path, dirname_flag)
    end
  end

  #
  # absolute path
  # or
  # "Home/tama/taki_2018-11-22-12_55.m4a"
  #
  def radio_basedir_regex(path, dirname_flag)
    regex = Regexp.new("^.*\/public\/#{root_home_name}\/(.*)$")
    match_dir = regex.match(path)

    dir = match_dir.nil? ? path : 'Home/' + match_dir[1]

    if dirname_flag
      File.dirname(dir)
    else
      dir
    end
  end
end
