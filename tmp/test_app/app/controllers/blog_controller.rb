class BlogController < CmsController
  def index
    @page = params[:page].to_i
    @posts = @obj.latest_posts(10, @page)

    respond_to do |format|
      format.html { @posts }
      format.rss { @posts }
    end
  end
end
