class ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Show applications that matter to the current user:
    # - applications they submitted
    # - applications submitted to listings they own
    matching_applications = Application
      .left_outer_joins(:listing)
      .where("applications.user_id = ? OR listings.owner_id = ?", current_user.id, current_user.id)

    @list_of_applications = matching_applications.order({ :created_at => :desc })

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
