xml.instruct! :xml, version: '1.0'

xml.rss version: '2.0' do
  xml.channel do
    xml.title @obj.headline
    xml.description @obj.description
    xml.link cms_url(@obj)

    xml << render(partial: 'post', collection: @posts)
  end
end
