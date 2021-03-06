class UsersController < ApplicationController
  before_filter :authenticate_user!
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # add_fav
  # adds a school as a favorite
  # GET /add_fav/:school_id
  def add_fav
    logger.debug('***** add_fav')
    school = School.find(params[:school_id])
    logger.debug("School found: #{school.name}")
    current_user.schools << school
    current_user.save
    redirect_to schools_path
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @joined_on = @user.created_at.to_formatted_s(:short)
    if @user.current_sign_in_at
      @last_login = @user.current_sign_in_at.to_formatted_s(:short)
    else
      @last_login = "never"
    end
  end

  # GET /users/new
  def new
    # @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    # @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
                               @user.update(user_params)
                           else
                               @user.update_without_password(user_params)
                           end

    respond_to do |format|
      if successfully_updated
          
      # if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def friends
    @friends = current_user.friends
  end

  def invite
  end

  def send_invitations
    # Send an invitation to each of the listed emails
    UserMailer.invitation(params[:email1], params[:message], current_user.name).deliver if params[:email1].present?
    UserMailer.invitation(params[:email2], params[:message], current_user.name).deliver if params[:email2].present?
    UserMailer.invitation(params[:email3], params[:message], current_user.name).deliver if params[:email3].present?
    UserMailer.invitation(params[:email4], params[:message], current_user.name).deliver if params[:email4].present?
    UserMailer.invitation(params[:email5], params[:message], current_user.name).deliver if params[:email5].present?
    redirect_to root_path, notice: 'Thank you! Your invitations have been sent.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_user
    #  @user = User.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fname, :lname, :email, :phone, :zip, :role_id, :password, :password_confirmation, :city, :state)
    end

    def needs_password?(user, params)
      params[:password].present?
    end

end
