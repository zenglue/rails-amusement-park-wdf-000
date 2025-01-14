class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update]
  before_action :current_user, only: [:index, :show]

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def show
  end

  def edit
  end

  def update
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def ride
    @user = User.find_by(id: session[:user_id])
    @attraction = Attraction.find_by(id: params[:id])
    ride = Ride.create(attraction_id: @attraction.id, user_id: @user.id)
    flash[:alert] = ride.take_ride
    redirect_to user_path(@user)
  end


  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end
