class UsersController < ApplicationController
  def sign_in

  end

  def reset_password
    @user_type = session[:user_type]
    puts @user_type
    if(@user_type == "realtor")
      @table_name = Realtor
    elsif (@user_type == "househunter")
      @table_name = HouseHunter
    elsif(@user_type =="admin")
      @table_name = Admin
    end
    respond_to do |format|
      @params = reset_password_params
      puts @params
      if @params["new_password"] == @params["confirm_new_password"]
        @user = @table_name.find(session[:id][0])
        if(@user["password"] == @params["old_password"])
           if @user.update_attributes(password: @params["new_password"])
                format.html { redirect_to "/homepage", notice: 'Your password is successfully reset' }
           else
             redirect_to "/users/reset_password_form",notice: "Unable to process the change ! Contact system admin"
             end
        else
          format.html { redirect_to "/users/reset_password_form", notice: "Old password doesn't match our records" }
        end

      else
        format.html { redirect_to "/users/reset_password_form", notice: "New password and confirm new password doesn't match" }
      end
    end
  end

  def reset_password_form
  end
  def homepage
    @realtor = Realtor.find(session[:id][0])
    if(@realtor.real_estate_company_id.nil?)
      @real_estate_company_id = -1
    else
      @real_estate_company_id = RealEstateCompany.find(@realtor.real_estate_company_id)
    end

  end

  def logout
    reset_session
    redirect_to '/users/sign_in' , notice: 'You have been successfully logged out !'
  end

  def show_all
    @realtor = Realtor.all
    @househunter = HouseHunter.all

  end

  def show_realtor
    @realtor = Realtor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @realtor }
    end
  end

  def check_credentials
    puts "entered"
    @email = params[:email]
    @password = params[:password]
    @user_type = params[:usertype]
    session[:email] = @email
    session[:user_type] = @user_type
    puts @user_type
    if request.post? and params[:email]

      if(@user_type == "realtor")
        @table_name = Realtor
      elsif (@user_type == "househunter")
        @table_name = HouseHunter
      elsif(@user_type =="admin")
        @table_name = Admin
      end
      puts @table_name.exists?(email: @email)

      if(@table_name.exists?(email: @email))
        @passwordInDB =  @table_name.where(email: @email).pluck(:password)
        puts "email present"
        if (@passwordInDB[0] == @password)
            redirect_to action: "homepage"
        else
          redirect_to root_url , notice: 'Wrong user credentials'
          end
          session[:id] = @table_name.where(email: @email).pluck(:id)
          session[:name] = @table_name.where(email: @email).pluck(:name)
        else
          redirect_to root_url , notice: 'Wrong user credentials'
        end
      end
  end

  private
  def reset_password_params
    params.require(:user).permit(:old_password, :confirm_new_password , :new_password)
  end
  end

