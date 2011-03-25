class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          ::Baseline::EmailSender 
    recipients    user.email
    sent_on       Time.now
    @edit_account_password_reset_url = edit_account_password_reset_url(user.confirmation_token)
  end
  
  def account_confirmation_instructions(user)
    subject       "Account Confirmation Instructions"
    from          ::Baseline::EmailSender 
    recipients    user.email
    sent_on       Time.now
    @edit_account_confirmation_url = edit_account_confirmation_url(user.confirmation_token)
  end
end
