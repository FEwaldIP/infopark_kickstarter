class DiagramWidget < Widget
  def data
    @data ||= begin
      entries = self[:data] || []

      entries.split('|').map do |entry|
        entry.split(',').map(&:strip)
      end
    end
  end
end
