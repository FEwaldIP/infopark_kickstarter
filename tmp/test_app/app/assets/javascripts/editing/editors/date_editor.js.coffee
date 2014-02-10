$ ->
  # Define editor behavior for date attributes.

  infopark.on 'editing', ->
    template = ->
      editor = $('<div></div>')
        .addClass('date-editor')

      input = $('<input />')
        .attr('type', 'text')
        .appendTo(editor)

      editor

    getEditor = (element) ->
      element.closest('.date-editor')

    save = (event) ->
      inputField = $(event.currentTarget)
      editor = getEditor(inputField)
      cmsField = editor.data('cmsField')
      content = inputField.val()

      if content? && content.length > 0
        content = new Date(content)

      editor.addClass('saving')

      cmsField.infopark('save', content)
        .done ->
          cmsField
            .html(content)
            .show()

          editor.remove()
        .fail ->
          editor.removeClass('saving')

    $('body').on 'click', '[data-ip-field-type=date]', (event) ->
      event.preventDefault()

      cmsField = $(this)
      content = cmsField.html()

      if content? && content.length > 0
        new Date(content).toString()

      template()
        .data('cmsField', cmsField)
        .insertAfter(cmsField)
        .find('input')
        .val(content)
        .focusout(save)
        .focus()

      cmsField.hide()
