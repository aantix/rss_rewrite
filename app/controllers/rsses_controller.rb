class RssesController < ApplicationController
  before_action :set_rss, only: [:show, :edit, :update, :destroy]

  # GET /rsses
  # GET /rsses.json
  def index
    @rsses = Rss.all
  end

  # GET /rsses/1
  # GET /rsses/1.json
  def show
    @posts = @rss.rss_type.constantize.new(@rss.url).feed
  end

  # GET /rsses/new
  def new
    @rss = Rss.new
  end

  # GET /rsses/1/edit
  def edit
  end

  # POST /rsses
  # POST /rsses.json
  def create
    @rss = Rss.new(rss_params)

    respond_to do |format|
      if @rss.save
        format.html { redirect_to @rss, notice: 'Rss was successfully created.' }
        format.json { render :show, status: :created, location: @rss }
      else
        format.html { render :new }
        format.json { render json: @rss.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rsses/1
  # PATCH/PUT /rsses/1.json
  def update
    respond_to do |format|
      if @rss.update(rss_params)
        format.html { redirect_to @rss, notice: 'Rss was successfully updated.' }
        format.json { render :show, status: :ok, location: @rss }
      else
        format.html { render :edit }
        format.json { render json: @rss.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsses/1
  # DELETE /rsses/1.json
  def destroy
    @rss.destroy
    respond_to do |format|
      format.html { redirect_to rsses_url, notice: 'Rss was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rss
      @rss = Rss.find_by(uid: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rss_params
      params.require(:rss).permit(:name, :uid, :url)
    end
end
