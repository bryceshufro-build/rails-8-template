class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    application_id = params.fetch("query_application_id")
    the_application = Application.where({ :id => application_id }).at(0)

    # Safety: ensure application exists
    if the_application.nil?
      redirect_to("/applications", { :alert => "Application not found." })
      return
    end

    # Authorization: only applicant or listing owner can message
    allowed = (the_application.user_id == current_user.id) ||
              (the_application.listing.owner_id == current_user.id)

    if allowed == false
      redirect_to("/applications", { :alert => "Not authorized." })
      return
    end

    the_message = Message.new
    the_message.application_id = the_application.id
    the_message.sender_id = current_user.id
    the_message.body = params.fetch("query_body")

    if the_message.valid?
      the_message.save
      redirect_to("/applications/#{the_application.id}", { :notice => "Message sent." })
    else
      redirect_to("/applications/#{the_application.id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  # Optional (keep simple): allow sender to delete their own message
  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    if the_message.nil?
      redirect_to("/applications", { :alert => "Message not found." })
      return
    end

    the_application = the_message.application
    allowed = (the_application.user_id == current_user.id) ||
              (the_application.listing.owner_id == current_user.id)

    if allowed == false
      redirect_to("/applications", { :alert => "Not authorized." })
      return
    end

    if the_message.sender_id != current_user.id
      redirect_to("/applications/#{the_application.id}", { :alert => "Only the sender can delete this message." })
      return
    end

    the_message.destroy
    redirect_to("/applications/#{the_application.id}", { :notice => "Message deleted." })
  end
end
