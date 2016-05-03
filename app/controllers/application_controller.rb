class ApplicationController < ActionController::Base
  def hello
    render text: "hello,world!"
  end
  def goodbye
    render text: "goodbye, world!"
  end
  
  def cool(text)
    render text: "I am so cool!"
  end
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
