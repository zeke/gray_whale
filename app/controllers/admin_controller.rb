class AdminController < ApplicationController
  
  def login
    authenticate
  end
  
  def logout
    session[:admin] = nil
  end
  
end