class DirectoriesController < ApplicationController
  # before_action :verify_user, except: [:fire, :time, :print_time]
  before_action :logged_in_user, only: [:show]

  #
  # 1ページに表示するファイルの数
  #
  PER_PAGE = 25

  #
  # start_time
  #
  def fire
    @start_time = Time.zone.now
  end

  #
  # time
  #
  def time
    @time = Time.zone.now
  end

  #
  # print_time
  #
  def print_time(message)
    diff = Time.zone.now - @time
    logger.debug "==== #{message} #{diff} (sec) =====\n"
  end

  #
  # show
  #
  def show
    # fire
    # time

    store_location

    # @user = User.first
    @user = current_user

    @sound = @user.sounds.build

    @dirname = params[:dirname] || root_home_path

    items = hash_files
    sorted_items = sort_time(@dirname, items)

    kaminari_paginate_items(sorted_items)

    # print_time("show")
  end

  private

  def hash_files
    items = []

    Dir.glob("#{@dirname}/*", File::FNM_DOTMATCH) do |filename|
      name = File.basename(filename)
      is_directory = File.directory?(filename)

      extname = File.extname(filename).downcase
      is_sound = sound?(extname)

      item = { name: name, isDirectory: is_directory, isSound: is_sound }
      items.push(item)
    end

    items
  end

  def sound?(extname)
    case extname
    when '.mp3', '.ogg', '.wav', '.m4a', '.aiff' then true
    else false
    end
  end

  def sort_time(dirname, items)
    # time
    sorted_items = items.sort do |a, b|
      if a[:isDirectory] == true
        a_directory(a, b)
      else
        a_not_directory(dirname, a, b)
      end
    end
    sorted_items
  end

  def kaminari_paginate_items(sorted_items)
    paginate = Kaminari.paginate_array(sorted_items)
    @paginatable_items = paginate.page(params[:page]).per(PER_PAGE)
  end

  def a_directory(item1, item2)
    if item2[:isDirectory] == true
      item1[:name] <=> item2[:name]
    else
      0 <=> 1
    end
  end

  def a_not_directory(dirname, item1, item2)
    if item2[:isDirectory] == true
      1 <=> 0
    else
      compare_time(dirname, item1, item2)
    end
  end

  #
  # item1、item2 の両方がファイルの場合、更新日でソートする。
  #
  def compare_time(dirname, item1, item2)
    a_time = test('M', File.join(dirname, item1[:name]))
    b_time = test('M', File.join(dirname, item2[:name]))
    b_time <=> a_time
  end
end
