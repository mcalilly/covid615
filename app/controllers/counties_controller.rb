class CountiesController < ApplicationController
  before_action :set_county, only: [:show, :edit, :update, :destroy]

  # GET /counties
  # GET /counties.json
  def index
    @counties = County.all
  end

  # GET /counties/1
  # GET /counties/1.json
  def show
    @most_recent_update = @county.updates.last
  end

  # GET /counties/new
  def new
    @county = County.new
  end

  # GET /counties/1/edit
  def edit
  end

  # POST /counties
  # POST /counties.json
  def create
    @county = County.new(county_params)

    respond_to do |format|
      if @county.save
        format.html { redirect_to @county, notice: 'County was successfully created.' }
        format.json { render :show, status: :created, location: @county }
      else
        format.html { render :new }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counties/1
  # PATCH/PUT /counties/1.json
  def update
    respond_to do |format|
      if @county.update(county_params)
        format.html { redirect_to @county, notice: 'County was successfully updated.' }
        format.json { render :show, status: :ok, location: @county }
      else
        format.html { render :edit }
        format.json { render json: @county.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counties/1
  # DELETE /counties/1.json
  def destroy
    @county.destroy
    respond_to do |format|
      format.html { redirect_to counties_url, notice: 'County was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_county
      @county = County.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def county_params
      params.require(:county).permit(:name, :fips, :state_id)
    end
end
