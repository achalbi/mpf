class MpfController < ApplicationController
  def index
  end
  
  def getCountry
    param = params['continent']
    puts param
    @country = Mp.where(continent: param  ).collect(&:country).uniq.sort
    render json: @country
  end
  
  def getCity
    param = params['country']
    @city = Mp.where(country: param  ).collect(&:city).uniq.sort
    render json: @city
  end
  
  def getMap
    param = params['city']
    @mps = Mp.where(city: param  ) #.pluck(:geoX, :geoY)
    puts @mps.to_json
    render json: @mps
  end
end