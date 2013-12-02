class SearchPageController < CmsController
  def index
    @query = params[:q]
    limit = params[:limit] || 100
    offset = params[:offset] || 0

    results = Obj.all.offset(offset)

    if @query.present?
      results.and(:*, :contains_prefix, @query)
    end

    @hits = results.take(limit)
    @total = results.count
  end
end
