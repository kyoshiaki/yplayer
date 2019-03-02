class SoundsController < ApplicationController
  before_action :logged_in_user, only: %i[update destroy]
  before_action :correct_user, only: :destroy

  def update
    @sound = current_user_sounds(params[:id])

    time = I18n.l Time.zone.now, format: '%Y/%m/%d(%a), %H:%M:%S'
    playhead = playhead_params

    if @sound.update(sound_params)
      # time = I18n.l @sound.updated_at, format: '%Y/%m/%d(%a), %H:%M:%S'
      flash_update_success(playhead, time)
      # flash_update_failure(playhead, time)
    else
      # time = I18n.l Time.zone.now, format: '%Y/%m/%d(%a), %H:%M:%S'
      flash_update_failure(playhead, time)
    end

    update_response
  end

  def destroy
    @sound = current_user_sounds(params[:id])

    Sound.find(params[:id]).destroy

    flash[:success] = I18n.t 'sounds.deleted', name: @sound.name
    redirect_to request.referer || root_url
  end

  private

  def playhead_params
    params[:sound][:playhead]
  end

  def update_response
    respond_to do |f|
      f.html { redirect_to root_url }
      f.js
    end
  end

  def flash_update_success(playhead, time)
    head = "#{string_from_second(playhead.to_i)} (#{playhead})"
    message = I18n.t('sounds.update.success', playhead: head)
    @flash = { key: :success, value: message, time: time }
  end

  def flash_update_failure(playhead, time)
    head = "#{string_from_second(playhead.to_i)} (#{playhead})"
    message = I18n.t('sounds.update.failure', playhead: head)
    @flash = { key: :danger, value: message, time: time }
  end

  def current_user_sounds(user_id)
    current_user.sounds.find_by(id: user_id)
  end

  def sound_params
    sound_para = params.require(:sound)
    sound_para.permit(:path, :name, :listened, :marked, :playhead, :user_id)
  end

  def correct_user
    @sound = current_user.sounds.find_by(id: params[:id])
    redirect_to root_url if @sound.nil?
  end
end
