class FooterCell < Cell::Rails
  include Authentication

  # Cell actions:

  def show(page)
    @page = page

    render
  end
end
