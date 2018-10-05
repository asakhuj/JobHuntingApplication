class RealEstateCompaniesController < ApplicationController

  def create
    @company = RealEstateCompany.new(company_params)
    if @company.save
      if(session[:user_type] == "realtor")
        @realtor = Realtor.find_by(id: session[:id])
        @realtor["real_estate_company_id"] = @company.id
        @realtor.save
        redirect_to '/homepage' , notice: 'Company was successfully created and added to your profile .'
      else
        redirect_to '/homepage'
      end


    end
  end

  def index
    @companies = RealEstateCompany.all
    puts @companies
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def edit
    @company = RealEstateCompany.find(params[:id])
  end

  def update
    @company = RealEstateCompany.find(params[:id])
    respond_to do |format|
      if @company.update_attributes(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = RealEstateCompany.find(params[:id])
    @company.destroy
    respond_to do |format|
      format.html { redirect_to real_estate_companies_url , notice: 'Company was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  def show
    @company = RealEstateCompany.find(params[:id])
    puts @company.company_name
    puts @company.website
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end



  private
  def company_params
    params.require(:company).permit(:company_name,  :website,  :address,  :size_of_company,  :founded_year, :revenue,  :synopsis)
  end
end
