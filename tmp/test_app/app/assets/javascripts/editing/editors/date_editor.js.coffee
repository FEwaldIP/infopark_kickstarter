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

    keyUp = (event) ->
      event.stopPropagation()
      key = event.keyCode || event.which

      switch key
        when 13 # Enter
          save(event)
        when 27 # Esc
          cancel(event)

    cancel = (event) ->
      element = $(event.currentTarget)
      editor = getEditor(element)
      disableEditMode(editor)

    disableEditMode = (editor) ->
      cmsField = editor.data('cmsField')
      cmsField.show()
      editor.remove()

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
          cmsField.html(content)
          disableEditMode(editor)
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
        .keyup(keyUp)
        .focus()

      cmsField.hide()
