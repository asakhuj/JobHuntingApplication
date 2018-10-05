class AdminsController < ApplicationController

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update_attributes(update_profile_params)
        session[:name] = Admin.find(params[:id])["name"]
        puts session[:name]
        format.html { redirect_to "/homepage", notice: 'Your profile is successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def update_profile_params
    params.require(:admin).permit( :name )
  end
end
