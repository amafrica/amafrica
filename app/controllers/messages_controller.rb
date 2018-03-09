class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  # def create
  #   @message = Message.new message_params
  #
  #   if @message.valid?
  #     redirect_to new_message_url, notice: "Message received, thanks!"
  #   else
  #     render :new
  #   end
  # end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.contact_me(@message).deliver_now
      redirect_to new_message_url, notice: = "Message received, thanks!"
    else
      notice: = "There was an error sending your message. Please try again."
      render :new
    end
  end

  def receive(email)
    page = Page.find_by(address: email.to.first)
    page.emails.create(
      subject: email.subject,
      body: email.body
    )

    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({
          file: attachment,
          description: email.subject
        })
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

end
