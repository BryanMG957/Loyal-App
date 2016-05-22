class CalendarsController < ApplicationController
  include CalendarsHelper
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_using_omniauth?
  skip_before_action :logged_in_using_omniauth?, only: [:pull_calendars]
  skip_before_filter :verify_authenticity_token, only: [:pull_calendars]
  layout(false, only: [:pull_calendars])
  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    p calendar_params
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save

        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pull_calendars
    @icloudcalendarlist = icloud_get_calendars(params[:username], params[:password])
    if (@icloudcalendarlist.class == Symbol)
      render plain: @icloudcalendarlist.to_s
    else
      render '_validcalendars'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:name, :apitype, :server_incoming, :server_outgoing, :username, :password, :uid, :url)
    end
end
