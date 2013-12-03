$ ->
  # Define editor behavior for enum attributes.

  infopark.on 'editing', () ->
    cmsEditEnums = $('[data-ip-field-type=enum]')

    for cmsEditEnum in cmsEditEnums
      $(cmsEditEnum).on 'focusout', ->
        element = $(@)

        element.infopark('save', element.val())
