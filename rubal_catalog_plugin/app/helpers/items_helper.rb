module ItemsHelper
  def get_sections_for_select
    res = []
    CatalogSection.all.each do |cs|
      res.push [cs.name, cs.id]
    end
    res
  end
end
