class SessionsController < ApplicationController
    def index
        @states = us_states
    end
    def create
        user = User.find_by_email(login_params[:email])

        if user && user.authenticate(login_params[:password])
            session[:user_id] = user.id
            flash[:success] = ["Login Successful"]
            redirect_to "/events"
        else
            flash[:errors] = ["Invalid combination"]
            redirect_to root_path
        end
    end
    def logout
        reset_session
        redirect_to root_path
    end

    private
        def login_params
            params.require(:user).permit(:email, :password)
        end
end
