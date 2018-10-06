class HousesController < ApplicationController


  def show
    @house = House.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @house }
    end
  end

  def add_image_to_house
    @house = House.find(params[:id])
  end

  def upload_image
    @house = House.find(params[:id])
    puts @house
    puts image_params
    respond_to do |format|
      if @house.update_attributes(image_params)
        format.html {redirect_to '/homepage' , notice: 'Image is successfully uploaded.'}
      else
        puts "error"
        render :edit
      end
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

  def my_interest_list
    @house_hunter_id = (session[:id][0] ).to_s
    sql = "select * from houses where id in ( select house_id from interest_lists where house_hunter_id = "+@house_hunter_id +" )"
    puts sql
    @houses = House.connection.select_all(sql)

  end

  def remove_from_interest_list
    @house_id = params[:id].to_s
    @house_hunter_id = (session[:id][0] ).to_s
    sql = "delete from interest_lists where house_hunter_id ="+@house_hunter_id+" and house_id = "+@house_id+" ;"
    @connection = ActiveRecord::Base.connection
    @result = @connection.exec_query(sql)
    if(@result)
      redirect_to '/houses/my_interest_list' , notice: 'House was successfully removed from interest list.'
    else
      redirect_to '/houses/my_interest_list' , notice: 'Error in removing from interest list.'
    end
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
      redirect_to show_houses_with_filters_url , notice: 'House was successfully added to interest list.'
    else
      redirect_to show_houses_with_filters_url , notice: 'Already present in interest list.'
    end
  end

  def index
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

  def image_params
    params.require(:house).permit(:file_name)
  end
end
