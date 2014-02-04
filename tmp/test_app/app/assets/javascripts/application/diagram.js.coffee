$ ->
  class window.DiagramSerializer
    parse: (source) ->
      bars = []

      for bar in source.split('|')
        [title, value] = bar.split(/\s*,\s*/)

        if title? and value?
          bars.push
            title: title
            value: value

      bars

  diagramTemplate = (barsData) ->
    diagramElement = $('<div></div>')
      .addClass('diagram')

    for barData in barsData
      labelElement = labelTemplate(barData['title'])
      progressbarElement = progressbarTemplate(barData['value'])

      diagramElement
        .append(labelElement)
        .append(progressbarElement)

    diagramElement

  labelTemplate = (title) ->
    $('<h3></h3>')
      .text(title)

  progressbarTemplate = (percent) ->
    wrapper = $('<div></div>')
      .addClass('progress')

    bar = $('<div></div>')
      .addClass('progress-bar')
      .addClass('progress-bar-success')
      .attr('role', 'progressbar')
      .attr('aria-valuemin', '0')
      .attr('aria-valuemax', '100')
      .attr('aria-valuenow', percent)
      .css('width', "#{percent}%")
      .appendTo(wrapper)

    wrapper

  init = (element) ->
    serializer = new DiagramSerializer
    sourceData = element.text()
    barsData = serializer.parse(sourceData)
    diagramElement = diagramTemplate(barsData)

    element.replaceWith(diagramElement)

  init($('.diagram-source'))
