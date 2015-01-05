module NotificationHelper

  ## This function will set a flash message depending up on the request type (ajax - xml http or direct http)
  ## example : store_flash_message("The message has been sent successfully", :success)
  def store_flash_message(message, type)
    if request.xhr?
      flash.now[type] = message
    else
      flash[type] = message
    end
  end

  def set_notification_messages(heading, alert, not_type)
    @heading = heading
    @alert = alert
    store_flash_message("#{@heading}: #{@alert}", not_type) if defined?(flash) && flash
  end

end
