require 'rest-client'

class MpfController < ApplicationController
  def index
     client = Databasedotcom::Client.new :client_id => ENV["SALESFORCE_KEY"], :client_secret => ENV["SALESFORCE_SECRET"], :host => "test.salesforce.com" 
     session[:access_token] = client.authenticate :username => ENV["SALESFORCE_USERNAME"], :password => ENV["SALESFORCE_PASSWORD"] + ENV['SALESFORCE_SECURITY_TOKEN']
     session[:client]  = client
     session[:instance_URL] = client.instance_url
=begin     
     client = Restforce.new :host => 'test.salesforce.com',
      :username => ENV["SALESFORCE_USERNAME"],
      :password       => ENV["SALESFORCE_PASSWORD"],
      :security_token => ENV['SALESFORCE_SECURITY_TOKEN'],
      :client_id      => ENV["SALESFORCE_KEY"],
      :client_secret  => ENV["SALESFORCE_SECRET"]
=end  

  end
  
  def getCountry
    
    # client = Databasedotcom::Client.new :client_id => ENV["SALESFORCE_KEY"], :client_secret => ENV["SALESFORCE_SECRET"], :host => "test.salesforce.com" 
    # auth = client.authenticate :username => ENV["SALESFORCE_USERNAME"], :password => ENV["SALESFORCE_PASSWORD"] + ENV['SALESFORCE_SECURITY_TOKEN']

     @countries = RestClient.get session[:instance_URL]+"/services/apexrest/countries",{ Authorization: "Bearer "+session[:access_token],:accept => :json }
   # param = params['continent']
   # p @countries
    #@country = Mp.where(continent: param  ).collect(&:country).uniq.sort
    #render json: @country
    render json: @countries
  end
  
  def getCity
    param = params['country']
    session[:country] = param
     @cities = RestClient.get session[:instance_URL]+"/services/apexrest/region?country="+param,{ Authorization: "Bearer "+session[:access_token],:accept => :json }
   # @city = Mp.where(country: param  ).collect(&:city).uniq.sort
    render json: @cities
  end
  
  def getMap
    param = params['city']
   # @mps = Mp.where(city: param  ) #.pluck(:geoX, :geoY)
    @mps = RestClient.get session[:instance_URL]+"/services/apexrest/medicalproviderdetails?country="+session[:country]+"&city="+param,{ Authorization: "Bearer "+session[:access_token],:accept => :json }
    puts @mps.to_json
    render json: @mps
  end
end