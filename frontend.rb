require 'rubygems'
require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'firstTest.db',
  :pool => 5
)

after do
  ActiveRecord::Base.clear_active_connections!
end

class Tempreading < ActiveRecord::Base
end

get '/' do
  @reading = Tempreading.all().order("readingtime desc").limit(10)
  @avg = Tempreading.where("date(ReadingTime) = date('now')").average("Temperature")

  erb :index
end


