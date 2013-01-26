class FillupsController < ApplicationController
require 'csv'


  # GET /fillups
  # GET /fillups.json
  def index
    @fillups = Fillup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fillups }
    end
  end

  # GET /fillups/1
  # GET /fillups/1.json
  def show
    @fillup = Fillup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fillup }
    end
  end

  # GET /fillups/new
  # GET /fillups/new.json
  def new
    @fillup = Fillup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fillup }
    end
  end

  def upload_history
  end

  def upload
    uploaded_io = params[:history_file]
    user_id = current_user.id
    puts "current user id: " + user_id.to_s
    CSV.parse(params[:history_file].read) do |r|
      unless(r[0][/[A-Za-z]/])
        date = r[0] && r[0][/^[01]?\d\/[0123]?\d\/[12][019]\d{2}/] ? Date.strptime(r[0], "%m/%d/%Y") : r[0]
        miles = r[3].blank? ? "" :  r[3].gsub(/,/,'').to_i if r[3]
        f = Fillup.create(:date => date, :price_per_gallon => r[1], :gallons => r[2], :miles => miles, :note => r[4], :user_id => user_id)
        if(!f.errors.empty?)
          UploadError.create(:user_id => user_id, :record => r, :reason => f.errors.first.join(" "))
        end
      end
    end
    redirect_to root_path, :notice => "File was uploaded successfully."
  end

  # GET /fillups/1/edit
  def edit
    @fillup = Fillup.find(params[:id])
  end

  # POST /fillups
  # POST /fillups.json
  def create
    params["fillup"][:user_id] = current_user.id if current_user
    @fillup = Fillup.new(params[:fillup])

    respond_to do |format|
      if @fillup.save
        format.html { redirect_to root_path, notice: 'Fillup was successfully created.' }
        format.json { render json: @fillup, status: :created, location: @fillup }
      else
        format.html { render action: "new" }
        format.json { render json: @fillup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fillups/1
  # PUT /fillups/1.json
  def update
    @fillup = Fillup.find(params[:id])

    respond_to do |format|
      if @fillup.update_attributes(params[:fillup])
        format.html { redirect_to @fillup, notice: 'Fillup was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fillup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fillups/1
  # DELETE /fillups/1.json
  def destroy
    @fillup = Fillup.find(params[:id])
    @fillup.destroy

    respond_to do |format|
      format.html { redirect_to fillups_url }
      format.json { head :ok }
    end
  end
end
