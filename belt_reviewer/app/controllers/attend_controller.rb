class AttendController < ApplicationController
    def create
        event = Event.find(params[:id])
        attend = Attend.new(user: current_user, event: event)
        if attend.save
            flash[:success] = ["Joined the party! Whoop Whoop"]
            redirect_to "/events"
        else
            flash[:errors] = attend.errors.full_messages
            redirect_to '/events'
        end
    end
    def destroy
        event = Event.find(params[:id])
        Attend.where(user:current_user, event: event).destroy_all
        redirect_to :back
    end

    private
end
