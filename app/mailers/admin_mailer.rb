class AdminMailer < ApplicationMailer

  def no_update
    mail(to: "leemc@hey.com", subject: "Covid615.com has not yet updated today")
  end

  def update_posted
    mail(to: "leemc@hey.com", subject: "Today's Update has posted successfully to Covid615.com")
  end

end
