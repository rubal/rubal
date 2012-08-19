module NewsHelper
  def get_trends_for_select
    res = []
    NewsTrend.all.each do |nt|
      res.push [nt.name, nt.id]
    end
    res
  end
end
