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

  def main
    @calendar = make_calender(@@date.year, @@date.month)
    @date = @@date
  end

end
