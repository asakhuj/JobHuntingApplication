class HousesController < ApplicationController


  def show
    @house = House.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @house }
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    respond_to do |format|
      format.html { redirect_to '/houses/houses_posted_by_me' , notice: 'House was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def new
    @house = House.new
    puts session[:id]
  end

  def houses_posted_by_me
    @houses = House.where(realtor_id: session[:id][0] ).order(created_at: :desc)
  end

  def show_houses_with_filters
    @houses = House.all
  end
  def add_to_interest_list
    @house_hunter_id = session[:id]
    details = {house_hunter_id: @house_hunter_id[0], house_id: params[:id] }
    puts details
    @interest_list = InterestList.new(details)
    if  @interest_list.save
      puts "Successssssssssss"
      redirect_back fallback_location: houses_url

    else
      puts "Unsuccessful"
      redirect_back fallback_location: houses_url,notice: 'Already present in list'
    end
  end
  def index
    puts "entered"
    @houses = House.all
    puts @houses
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @houses }
    end
  end
  def create
    @house = House.new(house_params)
    @realtor = Realtor.find_by(id: session[:id] )
    @house["real_estate_company_id"]  = @realtor["real_estate_company_id"]
    @house["realtor_id"]  = @realtor["id"]
    puts @house["real_estate_company_id"]
    puts @house["realtor_id"]
    if @house.save
      redirect_to  '/homepage'
    else
      render 'new'
    end
  end

  def show_potential_buyers
    sql = "select * from house_hunters where id in ( select house_hunter_id from interest_lists where house_id = "+(params[:id].to_s) +" )"
    puts sql
    #Model.connection.select_all('sql').to_hash
    @house_hunters = HouseHunter.connection.select_all(sql).to_hash
    puts "data"
    puts @house_hunters

  end

  def houses_posted_by_company
    @realtor = Realtor.find_by(id: session[:id] )
    @houses = House.where(real_estate_company_id: @realtor["real_estate_company_id"] ).order(created_at: :desc)
  end


  def update
    @house = House.find(params[:id])
    respond_to do |format|
      if @house.update_attributes(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def house_params
    params.require(:house).permit(:location,  :square_footage,  :year_built , :style , :price , :number_of_floors, :basement, :current_house_owner, :contact_info_of_realtor)
  end
end
