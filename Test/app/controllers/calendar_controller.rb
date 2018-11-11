require "date"

class CalendarController < ApplicationController
  WEEKLY = 6 #週
  WEEKDAY = 7 #曜日
  WEEKEND = 7
  SUNDAY = 0

  @@date = Date.today

  def make_calender(year, month)
    # ２次元配列を作る
    calendar = Array.new(WEEKLY).map{Array.new(WEEKDAY){0}}

    # 週、曜日、月末日を設定
    week = 0
    weekday = Date.new(year, month, 1).wday
    lastday = Date.new(year, month, -1).day

    # 日付を代入
    for day_number in 1..lastday
      calendar[week][weekday] = day_number
      weekday = weekday + 1
      if weekday == WEEKEND
        week = week + 1
        weekday = SUNDAY
      end
    end
    return calendar
  end

  def update_date(year, month, day)
    @@date = Date.new(year, month, day)
    redirect_to("/main/#{@@date.year}/#{@@date.month}/#{@@date.day}")
  end

  def back_month
    if @@date.month != 1
      update_date(params[:year].to_i, params[:month].to_i - 1, 1)
    else
      update_date(params[:year].to_i - 1, 12, 1)
    end
  end

  def next_month
    if @@date.month != 12
      update_date(params[:year].to_i, params[:month].to_i + 1, 1)
    else
      update_date(params[:year].to_i + 1, 1, 1)
    end
  end

  def today
    @@date = Date.today
    redirect_to("/main/#{@@date.year}/#{@@date.month}/#{@@date.day}")
  end

  def day_schedule
    update_date(params[:year].to_i, params[:month].to_i, params[:day].to_i)
  end

  def get_calendar_icons
    icons = []

    @user_schedules.each do |schedule|
      sdate = schedule.start_date
      if sdate.year == @date.year && sdate.month == @date.month
        icons << schedule.icon_id
      end
    end

    return Icon.where(id: icons)
  end

  def get_schedule_icons
    icons = []

    @user_schedules.each do |schedule|
      sdate = schedule.start_date
      if sdate.year == @date.year && sdate.month == @date.month && sdate.mday == @date.mday
        icons << schedule.icon_id
      end
    end

    return Icon.where(id: icons)
  end

  def main
    @calendar = make_calender(@@date.year, @@date.month)
    @date = @@date

    # ログインしたユーザのアイコン・スケジュールをDBからとってくる
    @user_icons = Icon.where(user_id: session[:user_id])
    @user_schedules = Schedule.where(user_id: session[:user_id])
    # カレンダーに表示するアイコン達
    @calendar_icons = get_calendar_icons
    # スケジュールに表示するアイコン達
    @schedule_icons = get_schedule_icons

# データベーステスト###########################################
    @user_table = User.all
    @icon_table = Icon.all
    @schedule_table = Schedule.all
  end

# データベーステスト###########################################
  @@user_table
  @@icon_table
  @@schedule_table

  def rondom_str
    str = ''
    t = rand(1..10)
    t.times do
      str = str + ('A'..'Z').to_a[rand(26)]
    end
    return str
  end

  def add_user
    # ユーザ追加
    @@user_table = User.new(
      name: rondom_str,
      pass: rondom_str
    )
    @@user_table.save
    redirect_to("/")
  end

  def add_icon
    user_now = User.last
    @@icon_table = Icon.new(
      name: rondom_str,
      image_path: rondom_str,
      color: rondom_str,
      user_id: user_now.id
    )
    @@icon_table.save
    redirect_to("/")
  end

  def add_schedule
    user_now = User.last
    icon_selected = Icon.last
    # sd = DateTime.new(rand(1..2000), rand(1..12), rand(1..28), 00, 00, 00)
    sd = DateTime.new(2018, 11, rand(1..28), 00, 00, 00)
    fd = DateTime.new(sd.year, sd.month, sd.mday, 01, 00, 00)
    @@schedule_table = Schedule.new(
      start_date:sd,
      finish_date:fd,
      user_id:user_now.id,
      icon_id:icon_selected.id
    )
    @@schedule_table.save
    redirect_to("/")
  end

  def delete_table_all
    User.delete_all
    Icon.delete_all
    Schedule.delete_all
    redirect_to("/")
  end

end
