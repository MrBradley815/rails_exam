class EventsController < ApplicationController
    before_action :require_login
    def index
        @user = User.find(current_user.id)
        @state_events = Event.where(state:current_user.state)
        @other_events = Event.where.not(state:current_user.state)
    end
    def create
        event = Event.new(name:event_params[:name], city:event_params[:city], date:event_params[:date], state:event_params[:state], user:current_user)
        if event.save
            Attend.create(user: current_user, event: event)
            redirect_to '/events'
        else
            flash[:errors] = event.errors.full_messages
            redirect_to '/events'
        end
    end
    def show
        @event = Event.find(params[:id])
        @comments = Comment.where(event:params[:id])
    end
    def destroy
        event = Event.find(params[:id])
        event.destroy if event.user == current_user
        redirect_to :back
    end

    private
        def event_params
            params.require(:event).permit(:name, :date, :city, :state)
        end
end
