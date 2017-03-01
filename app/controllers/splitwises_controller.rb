class SplitwisesController < ApplicationController
  before_action :set_splitwise, only: [:show, :edit, :update, :destroy]

  # GET /splitwises
  # GET /splitwises.json
  def index
    @date_time = date_time
    @splitwises = Splitwise.analysis(@date_time)
  end

  # GET /splitwises/1
  # GET /splitwises/1.json
  def show
  end

  # GET /splitwises/new
  def new
    @splitwise = Splitwise.new
  end

  # GET /splitwises/1/edit
  def edit
  end

  # POST /splitwises
  # POST /splitwises.json
  def create
    @splitwise = Splitwise.new(splitwise_params)

    respond_to do |format|
      if @splitwise.save
        format.html { redirect_to @splitwise, notice: 'Splitwise was successfully created.' }
        format.json { render :show, status: :created, location: @splitwise }
      else
        format.html { render :new }
        format.json { render json: @splitwise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /splitwises/1
  # PATCH/PUT /splitwises/1.json
  def update
    respond_to do |format|
      if @splitwise.update(splitwise_params)
        format.html { redirect_to @splitwise, notice: 'Splitwise was successfully updated.' }
        format.json { render :show, status: :ok, location: @splitwise }
      else
        format.html { render :edit }
        format.json { render json: @splitwise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /splitwises/1
  # DELETE /splitwises/1.json
  def destroy
    @splitwise.destroy
    respond_to do |format|
      format.html { redirect_to splitwises_url, notice: 'Splitwise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def analysis
    @date_time = date_time
    @monthly_purchase = Splitwise.analysis(@date_time)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_splitwise
      @splitwise = Splitwise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def splitwise_params
      params[:splitwise][:created_by] = current_user.id
      params[:splitwise][:purchased_by] ||= current_user.id
      params.require(:splitwise).permit(:quantity, :price, :remaining_quantity,
       :purchased_at, :created_by, :item_name, :description, :purchased_by)
    end

    def month
      params[:date] ? (params[:date][:month] || Date.today.month) : Date.today.month
    end

    def year
      params[:date] ? (params[:date][:year] || Date.today.year) : Date.today.year
    end

    def date_time
      Time.new(year, month, '1', 0, 0 , 0)
    end
end
