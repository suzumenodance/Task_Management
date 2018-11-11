Rails.application.routes.draw do
  # calnedar_main
  get '/' => 'calendar#main'
  get '/today' => 'calendar#today'
  get '/main/:year/:month/:day' => 'calendar#main'
  get '/back_month/:year/:month/:day' => 'calendar#back_month'
  get '/next_month/:year/:month/:day' => 'calendar#next_month'
  get '/day_schedule/:year/:month/:day' => 'calendar#day_schedule'

  # DB
  post '/add_user' => 'calendar#add_user'
  post '/add_icon' => 'calendar#add_icon'
  post '/add_schedule' => 'calendar#add_schedule'
  post '/delete_table_all' => 'calendar#delete_table_all'

  # login
  get '/input_form' => 'login#input_form'
  post '/login' => 'login#login'
  post '/sign_up' => 'login#sine_up'
end
