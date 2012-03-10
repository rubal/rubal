#encoding: utf-8
module NewsHelper
  def get_news_trends
    trends = NewsTrend.all
    ret_arr = Array.new
    trends.each{|tr| ret_arr += [[tr.name, tr.key]] }
    return ret_arr
    return [["Новости", "news"], ["Этапы строительства", "stage"]]
  end

  def get_news_trend_name trend
    get_news_trends.each{|p|
      return p[0] if p[1] == trend
    }
    return '?'
  end
end
