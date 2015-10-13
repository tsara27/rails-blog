class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def to_slug(title)
    #strip the string
    ret = title.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
     ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'

     #convert double underscores to single
     ret.gsub! /_+/,"-"

     #strip off leading/trailing underscore
     ret.gsub! /\A[_\.]+|[_\.]+\z/,""

     ret
  end

  def randomString(far)
    (0..far.to_i).map { ("a".."z").to_a[rand(26)] }.join
  end
  
end
