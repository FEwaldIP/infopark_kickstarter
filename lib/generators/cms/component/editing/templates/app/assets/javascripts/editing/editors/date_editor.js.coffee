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
      content = new Date(inputField.val())
      editor = getEditor(inputField)
      cmsField = editor.data('cmsField')

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
      content = new Date(cmsField.html()).toString()

      template()
        .data('cmsField', cmsField)
        .insertAfter(cmsField)
        .find('input')
        .val(content)
        .focusout(save)
        .focus()

      cmsField.hide()
