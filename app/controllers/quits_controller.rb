class QuitsController < ApplicationController
  before_action :set_quit, only: [:show, :edit, :update, :destroy]

  # GET /quits
  # GET /quits.json
  def index
    @quits = Quit.all
  end

  # GET /quits/1
  # GET /quits/1.json
  def show
  end

  # GET /quits/new
  def new
    @quit = Quit.new()
  end

  # GET /quits/1/edit
  def edit
    @page_title = @quit.pending_activation? ? "Start Your Quit" : "Update Your Quit"
    @last_four = current_user.retrieve_last_four
  end

  # POST /quits
  # POST /quits.json
  def create
    @quit = Quit.new(quit_params)

    respond_to do |format|
      if @quit.save
        format.html { redirect_to @quit, notice: 'Quit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quit }
      else
        format.html { render action: 'new' }
        format.json { render json: @quit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quits/1
  # PATCH/PUT /quits/1.json
  def update
    token = params[:stripeToken]
    current_user.new_card(token: token) if token.present?
    @quit.activate! if @quit.pending_activation?
    respond_to do |format|
      if @quit.update(quit_params)
        format.html { redirect_to edit_quit_path(@quit), notice: 'Your quit was successfully updated.' }
        format.json { head :no_content }
      else
        @quit.retract!
        format.html { render action: 'edit' }
        format.json { render json: @quit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quits/1
  # DELETE /quits/1.json
  def destroy
    @quit.destroy
    respond_to do |format|
      format.html { redirect_to quits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quit
      @quit = Quit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quit_params
      params.require(:quit).permit(:user_id, :length, :start_date, :substance, :investment, :partner_email)
    end
end
