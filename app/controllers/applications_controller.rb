class ApplicationsController < ApplicationController
  def index
    matching_applications = Application.all

    @list_of_applications = matching_applications.order({ :created_at => :desc })

    render({ :template => "application_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_applications = Application.where({ :id => the_id })

    @the_application = matching_applications.at(0)

    render({ :template => "application_templates/show" })
  end

  def create
    the_application = Application.new
    the_application.listing_id = params.fetch("query_listing_id")
    the_application.user_id = params.fetch("query_user_id")
    the_application.message_to_owner = params.fetch("query_message_to_owner")
    the_application.priority_rank = params.fetch("query_priority_rank")
    the_application.status = params.fetch("query_status")
    the_application.decision_notes = params.fetch("query_decision_notes")

    if the_application.valid?
      the_application.save
      redirect_to("/applications", { :notice => "Application created successfully." })
    else
      redirect_to("/applications", { :alert => the_application.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_application = Application.where({ :id => the_id }).at(0)

    the_application.listing_id = params.fetch("query_listing_id")
    the_application.user_id = params.fetch("query_user_id")
    the_application.message_to_owner = params.fetch("query_message_to_owner")
    the_application.priority_rank = params.fetch("query_priority_rank")
    the_application.status = params.fetch("query_status")
    the_application.decision_notes = params.fetch("query_decision_notes")

    if the_application.valid?
      the_application.save
      redirect_to("/applications/#{the_application.id}", { :notice => "Application updated successfully." } )
    else
      redirect_to("/applications/#{the_application.id}", { :alert => the_application.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_application = Application.where({ :id => the_id }).at(0)

    the_application.destroy

    redirect_to("/applications", { :notice => "Application deleted successfully." } )
  end
end
