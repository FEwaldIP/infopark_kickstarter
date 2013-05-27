class SitemapController < ActionController::Base
  def index
    respond_to do |format|
      format.xml do
        @objects = RailsConnector::Workspace.default.as_current do
          now = Time.now

          Obj.where(:_path, :starts_with, homepage.path)
             .and_not(:_obj_class, :equals, excluded_obj_classes)
             .and(:_valid_from, :is_less_than, now.to_iso)
             .and_not(:_valid_until, :is_less_than, now.to_iso)
             .batch_size(100)
             .to_a
        end
      end
    end
  end

  private

  def homepage
    Homepage.for_hostname(request.host)
  end

  def excluded_obj_classes
    %w(
      Image
      Video
      Container
      Website
      Root
      ErrorPage
    )
  end
end