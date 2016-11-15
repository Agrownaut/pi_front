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
get '/reading' do
@reading = Tempreading.all().order("readingtime desc").limit(10).reverse

return_string = "date	Apples	Bananas
"

for item in @reading
	return_string += "#{item.ReadingTime}\t#{item.Temperature}\t#{item.Humidity}\n"
end
return_string
end
get '/calendarview' do
@reading = Tempreading.find_by_sql("select *, avg(temperature) as average, min(humidity) as minimumh, max(humidity) as maximumh from tempreadings group by date(readingtime)")
#Tempreading.all().group("date(ReadingTime)").avg("Temperature")

return_string = "Date,Open,High,Low,Close,Volume,Adj Close
"

for item in @reading
	return_string += "#{item.ReadingTime.strftime("%F")},#{item.Temperature},#{item.Humidity},#{item.average},#{item.minimumh},#{item.maximumh},#{item.Humidity}\n"
end
return_string
end



get '/calendar' do
	erb :calendar
end

