class ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      my_listing_ids = Listing.where({ :owner_id => current_user.id }).pluck(:id)

      @applications_to_my_listings = Application.where({ :listing_id => my_listing_ids }).order({ :created_at => :desc })

      @my_applications = Application.where({ :user_id => current_user.id }).order({ :created_at => :desc })
    else
      @applications_to_my_listings = []
      @my_applications = []
    end

    render({ :template => "application_templates/index" })
  end
  
  def show
  the_id = params.fetch("path_id")
  @the_application = Application.where({ :id => the_id }).at(0)

  # Only applicant OR listing owner can view
  allowed = (@the_application.user_id == current_user.id) || (@the_application.listing.owner_id == current_user.id)

  if allowed == false
    redirect_to("/listings", { :alert => "Not authorized." })
    return
  end

  @list_of_messages = Message.where({ :application_id => @the_application.id }).order({ :created_at => :asc })

  render({ :template => "application_templates/show" })
  end

  def create
    the_application = Application.new

    the_application.listing_id = params.fetch("query_listing_id")
    the_application.user_id = current_user.id
    the_application.message_to_owner = params.fetch("query_message_to_owner")

    # Defaults (owner can update later)
    the_application.status = "submitted"
    the_application.priority_rank = nil
    the_application.decision_notes = nil

    if the_application.valid?
      the_application.save
      redirect_to("/applications/#{the_application.id}", { :notice => "Application submitted successfully." })
    else
      redirect_to("/listings/#{the_application.listing_id}", { :alert => the_application.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_application = Application.where({ :id => the_id }).at(0)

    # Only listing owner can update decision fields
    if the_application.listing.owner_id != current_user.id
      redirect_to("/applications/#{the_application.id}", { :alert => "Not authorized." })
      return
    end

    the_application.priority_rank = params.fetch("query_priority_rank")
    the_application.status = params.fetch("query_status")
    the_application.decision_notes = params.fetch("query_decision_notes")

    # Don't allow these to be changed via update:
    # the_application.listing_id = ...
    # the_application.user_id = ...

    if the_application.valid?
      the_application.save
      redirect_to("/applications/#{the_application.id}", { :notice => "Application updated successfully." })
    else
      redirect_to("/applications/#{the_application.id}", { :alert => the_application.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_application = Application.where({ :id => the_id }).at(0)

    # Only applicant can withdraw/delete
    if the_application.user_id != current_user.id
      redirect_to("/applications/#{the_application.id}", { :alert => "Not authorized." })
      return
    end

    the_application.destroy
    redirect_to("/applications", { :notice => "Application withdrawn successfully." })
  end
end
