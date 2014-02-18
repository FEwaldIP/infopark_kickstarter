require 'uri'

class FlickrWidget < Widget
  def flickr_uri
    FlickrUri.new.tap do |uri|
      uri.display = self[:display]
      uri.count = self[:count]
      uri.size = self[:size]
      uri.source = self[:source]
      uri.user = self[:user]
      uri.tags = self[:tags]
    end
  end
end

class FlickrUri
  attr_writer :display
  attr_writer :count
  attr_writer :size
  attr_writer :source
  attr_writer :user
  attr_writer :tags

  def to_s
    uri = URI('https://www.flickr.com/badge_code_v2.gne')
    uri.query = "#{display}&#{count}&#{size}&#{source}&#{layout}"
    uri.to_s
  end

  private

  # Image ordering. Allows +latest+ and +random+.
  def display
    "display=#{@display}"
  end

  # Number of images to pull.
  def count
    "count=#{@count}"
  end

  # Size of images.
  def size
    value =
    case @size
    when 'thumbnail'
      't'
    when 'medium'
      'm'
    else
      's'
    end

    "size=#{value}"
  end

  # Source of images. Allows +all+, +user+, +user_tag+ and +all_tag+.
  def source
    options = self.send(@source)

    query = "source=#{@source}"

    if options
      query += "&#{options}"
    end

    query
  end

  # Used when +source+ is set to +all+.
  def all
    nil
  end

  # User ID. Used when +source+ is set to +user+.
  def user
    "user=#{@user}"
  end

  # Comma separated list of tags. Used when +source+ is set to +user_tag+.
  def user_tag
    "user=#{@user}&tag=#{@tags}"
  end

  # Comma separated list of tags. Used when +source+ is set to +all_tag+.
  def all_tag
    "tag=#{@tags}"
  end

  # Layout of the images. Allows +v+ for vertical, +h+ for horizontal and +x+ for custom layout.
  def layout
    'layout=x'
  end
end
