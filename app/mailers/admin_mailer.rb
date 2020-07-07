class AdminMailer < ApplicationMailer

  def no_update
    mail(to: "leemcalilly@gmail.com", subject: 'Covid615.com has not yet updated today')
  end

end
