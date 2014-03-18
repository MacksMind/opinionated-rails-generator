class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :sanitize_params, :only => [:create, :update]
  before_filter :load_user, only: :create
  load_and_authorize_resource

  # GET /users
  # GET /users.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html { render "shared/user" }
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.xml
  def create
    @user.roles = @roles

    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.'
        format.html { redirect_to([:admin,@user]) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user.roles = @roles
    params[:user].delete(:password) if user_params[:password].blank?
    params[:user].delete(:password_confirmation) if user_params[:password_confirmation].blank?

    respond_to do |format|
      if @user.update_attributes(user_params)
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to([:admin,@user]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end

  def masquerade
    sign_in @user
    redirect_to signed_in_root_path
  end

  private

  def load_user
    @user = User.new(user_params)
  end

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :first_name,
                                 :last_name,
                                 :time_zone,
                                 :phone_number,
                                 :company_name,
                                 :title,
                                 :address_line_1,
                                 :address_line_2,
                                 :city,
                                 :state_id,
                                 :state_code,
                                 :postal_code,
                                 :country_id,
                                 :country_code,
                                 :roles => [])
  end

  def sanitize_params
    @roles = params[:user].delete(:roles)
  end
end
