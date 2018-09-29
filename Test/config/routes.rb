Rails.application.routes.draw do
  get '/' => 'calendar#main'
  get '/today' => 'calendar#today'
  get '/main/:year/:month/:day' => 'calendar#main'
  get '/back_month/:year/:month/:day' => 'calendar#back_month'
  get '/next_month/:year/:month/:day' => 'calendar#next_month'
  get '/day_schedule/:year/:month/:day' => 'calendar#day_schedule'
end
