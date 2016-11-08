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
@reading = Tempreading.all().order("readingtime desc").limit(10).reverse

test = "Date,Open,High,Low,Close,Volume,Adj Close
2010-10-01,10789.72,10907.41,10759.14,10829.68,4298910000,10829.68
2010-09-30,10835.96,10960.99,10732.27,10788.05,4284160000,10788.05
2010-09-29,10857.98,10901.96,10759.75,10835.28,3990280000,10835.28
2010-09-28,10809.85,10905.44,10714.03,10858.14,4025840000,10858.14
2010-09-27,10860.03,10902.52,10776.44,10812.04,3587860000,10812.04
2010-09-24,10664.39,10897.83,10664.39,10860.26,4123950000,10860.26
2010-09-23,10738.48,10779.65,10610.12,10662.42,3847850000,10662.42
2010-09-22,10761.11,10829.75,10682.40,10739.31,3911070000,10739.31
2010-09-21,10753.39,10844.89,10674.83,10761.03,4175660000,10761.03
2010-09-20,10608.08,10783.51,10594.38,10753.62,3364080000,10753.62
2010-09-17,10595.44,10689.29,10529.67,10607.85,4086140000,10607.85
2010-09-16,10571.75,10624.58,10499.43,10594.83,3364080000,10594.83
2010-09-15,10526.42,10609.21,10453.15,10572.73,3369840000,10572.73
2010-09-14,10544.81,10622.69,10460.34,10526.49,4521050000,10526.49
2010-09-13,10458.60,10605.73,10458.45,10544.13,4521050000,10544.13"
return_string = "date	Apples	Bananas
"

for item in @reading
	return_string += "#{item.ReadingTime}\t#{item.Temperature}\t#{item.Humidity}\n"
end
test
end

