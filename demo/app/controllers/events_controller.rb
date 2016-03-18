class EventsController < ApplicationController
	before_action :set_event, :only => [ :show, :edit, :update, :destroy]
	def index
		#@events = Event.all
		@events = Event.page(params[:page]).per(5)
	end

	def new
	    @event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to :action => :index		
		else
			render :action => :new
		end
	end

	def show
		@page_title = @event.name
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		if @event.update(event_params)
			flash[:notice] = "event was successfully created"
			redirect_to :action => :show, :id => @event
		else
			render :action => :edit
		end
		
	end

	def destroy
		@event.destroy
		flash[:alert] = "event was successfully deleted"
		redirect_to :action => :index
	end
private

	def event_params
		params.require(:event).permit(:name, :description)
	end

	def set_event
		@event = Event.find(params[:id])
	end
end
