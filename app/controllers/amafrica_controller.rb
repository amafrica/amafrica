class AmafricaController < ApplicationController

  def index
    @message = Message.new
  end

  def show

  end

  def send_email
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.contact_me(@message).deliver_now
      redirect_to new_message_url, notice: "Message received, thanks!"
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :body)
  end

  # def email_params
  #   params.require("email").permit(:first_name, :last_name, :message, :email_address)
  # end

end
