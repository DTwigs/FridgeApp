class Message
  def initialize(body, phone_number)
    @body = body
    @phone_number = phone_number
  end

  def send_text_message
    twilio_phone_number = ENV["TWILIO_NUMBER"]

    @twilio_client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]

    @twilio_client.account.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => phone_number,
      :body => @body
    )
  end
end