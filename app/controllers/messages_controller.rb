class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Only show messages in application threads the current user is part of
    matching_messages = Message
      .left_outer_joins(application: :listing)
      .where("applications.user_id = ? OR listings.owner_id = ?", current_user.id, current_user.id)

    @list_of_messages = matching_messages.order({ :created_at => :desc })

    render({ :template => "message_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_message = Message.where({ :id => the_id }).at(0)

    # Authorization: only applicant OR listing owner can view
    the_application = @the_message.application
    allowed = (the_application.user_id == current_user.id) || (the_application.listing.owner_id == current_user.id)

    if allowed == false
      redirect_to("/listings", { :alert => "Not authorized." })
      return
    end

    render({ :template => "message_templates/show" })
  end

  def create
    the_message = Message.new

    the_message.application_id = params.fetch("query_application_id")
    the_message.sender_id = current_user.id
    the_message.body = params.fetch("query_body")

    # Authorization: must be a participant in the thread
    the_application = Application.where({ :id => the_message.application_id }).at(0)
    allowed = (the_application.user_id == current_user.id) || (the_application.listing.owner_id == current_user.id)

    if allowed == false
      redirect_to("/listings", { :alert => "Not authorized." })
      return
    end

    if the_message.valid?
      the_message.save
      redirect_to("/applications/#{the_message.application_id}", { :notice => "Message sent." })
    else
      redirect_to("/applications/#{the_message.application_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    # Only the original sender can edit their message
    if the_message.sender_id != current_user.id
      redirect_to("/applications/#{the_message.application_id}", { :alert => "Not authorized." })
      return
    end

    the_message.body = params.fetch("query_body")

    if the_message.valid?
      the_message.save
      redirect_to("/applications/#{the_message.application_id}", { :notice => "Message updated." })
    else
      redirect_to("/applications/#{the_message.application_id}", { :alert => the_message.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_message = Message.where({ :id => the_id }).at(0)

    # Only the original sender can delete their message
    if the_message.sender_id != current_user.id
      redirect_to("/applications/#{the_message.application_id}", { :alert => "Not authorized." })
      return
    end

    the_message.destroy
    redirect_to("/applications/#{the_message.application_id}", { :notice => "Message deleted." })
  end
end
