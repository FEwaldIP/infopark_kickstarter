class VideoWidget < Widget
  cms_attribute :source, type: :reference
  cms_attribute :width, type: :string
  cms_attribute :height, type: :string
  cms_attribute :autoplay, type: :enum
  cms_attribute :poster, type: :reference

  # Determines the mime type of the video.
  def mime_type
    if source.present?
      source.mime_type
    end
  end
end
