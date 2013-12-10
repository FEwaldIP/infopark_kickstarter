# This base class provides behavior that all CMS pages have in common. It is
# similar to a +Widget+, as it allows to add behavior by inheritance.
class Page < Obj
  # By default, objects can be displayed in navigation sections. Either add a
  # boolean cms attribute +show_in_navigation+ or override the method directly
  # in your model.
  def show_in_navigation?
    true
  end

  def menu_title
    self[:headline] || '[no headline]'
  end

  # Overriden method +toclist+ from +RailsConnector::BasicObj+.
  #
  # Filter the toclist to only include objects, that should show up in the
  # navigation.
  def toclist
    super.select { |obj| obj.respond_to?(:show_in_navigation?) && obj.show_in_navigation? }
  end
end
