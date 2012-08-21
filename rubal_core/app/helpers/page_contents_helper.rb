# encoding: utf-8

module PageContentsHelper
  def get_pages_for_select
    res = [['(нет привязки)','']]
    Page.all.each do |p|
      res.push [p.name, p.id]
    end
    res
  end
end
