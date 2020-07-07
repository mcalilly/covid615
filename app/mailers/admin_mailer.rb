class AdminMailer < ApplicationMailer

  def no_update
    mail(to: "leemc@hey.com", subject: 'Covid615.com has not yet updated today')
  end

end
