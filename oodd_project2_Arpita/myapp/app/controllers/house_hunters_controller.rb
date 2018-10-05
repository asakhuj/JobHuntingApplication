class HouseHuntersController < ApplicationController
  def new
    @house_hunters = HouseHunter.new
  end


  def create
    #@company = {params[:company_name] }
    @house_hunters = HouseHunter.new(signup_params)
    if @house_hunters.save
      if (session[:user_type] == "admin")
        redirect_to '/homepage' , notice: 'House hunter was successfully created .'
      else
         redirect_to root_path
      end

    else
      render 'new'
    end

  end



  private
  def signup_params
    params.require(:house_hunter).permit(:email,  :password,  :name , :phone , :contact_method)
  end
end
