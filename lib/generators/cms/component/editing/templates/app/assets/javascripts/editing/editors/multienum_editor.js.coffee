$ ->
  # Define editor behavior for multienum attributes.

  infopark.on 'editing', () ->
    cmsEditEnums = $('[data-ip-field-type=multienum]')

    for cmsEditEnum in cmsEditEnums
      $(cmsEditEnum).on 'focusout', ->
        element = $(@)

        element.infopark('save', element.val())
