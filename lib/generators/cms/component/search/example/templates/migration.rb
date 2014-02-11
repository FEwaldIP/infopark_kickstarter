class SearchExample < ::RailsConnector::Migration
  def up
    search_page = Obj.create(
      _path: '/en/_configuration/search',
      _obj_class: 'SearchPage',
      headline: 'Search'
    )

    add_attribute_to('Homepage', {
      name: 'search_page',
      type: :reference,
      title: 'Search Page',
    })

    obj = Obj.find_by_path('/en')
    obj.update(
      search_page: search_page['id']
    )
  end
end
