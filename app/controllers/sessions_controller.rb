class SessionsController < ApplicationController
  def create
    client = Databasedotcom::Client.new :client_id => ENV["SALESFORCE_KEY"], :client_secret => ENV["SALESFORCE_SECRET"], :host => "test.salesforce.com" 
    session['access_token'] = client.authenticate :username => ENV["SALESFORCE_USERNAME"], :password => ENV["SALESFORCE_PASSWORD"]
    
    #auth = env["omniauth.auth"]
    #session[:auth] = auth
    redirect_to root_url
  end

  def destroy
    session[:auth] = nil
    redirect_to root_url
  end
end