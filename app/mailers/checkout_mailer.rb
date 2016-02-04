class CheckoutMailer < ApplicationMailer
  def checkout(user)
    @user = user
    mail(to: @user.email, subject: 'Your purchased ticket(s)')
  end
end
