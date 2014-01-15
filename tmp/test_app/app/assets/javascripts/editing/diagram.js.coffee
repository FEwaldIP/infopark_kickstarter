$ ->
  template = (attributes) ->
    attributes ||= {}

    name = attributes['name'] || ''
    value = attributes['value'] || ''

    $("<input type=\"text\" name=\"name\" value=\"#{name}\" placeholder=\"Title\" />
       <input type=\"text\" name=\"value\" value=\"#{value}\" placeholder=\"Value\" class=\"editing-value\" />
       <div class=\"actions\">
         <a href=\"#\" class=\"editing-button add-value editing-green\">
           <i class=\"editing-icon editing-icon-add\" />
         </a>
         <a href=\"#\" class=\"editing-button editing-red delete\">
           <i class=\"editing-icon editing-icon-trash\" />
         </a>
       </div>")

  decodeDatas = (datas) ->
    model = []

    for data in datas.split("|")
      console.log(data)
      model.push({
        name: data.split(',')[0],
        value: data.split(',')[1]
      })

    model

  endcodeData = () ->
    model = []
    $('.editing.diagramm_widget ul li').each ->
      console.log($(this).find('input[name="name"]'))
      model.push({
        name: $(this).find('[name="name"]').val(),
        value: $(this).find('[name="value"]').val()
      })

    string = ""
    for entry in model
      string += "#{entry['name']},#{entry['value']}|"

    string

  # Returns the closest linklist DOM element.
  getCmsField = (element) ->
    element.closest('.editing.diagramm_widget')

  # Adds a new field to the list.
  addField = (event) ->
    event.preventDefault()

    cmsField = $(event.currentTarget).closest('ul')
    content = $('<li>').html(template())

    cmsField.append(content)

    content.on 'click', '.add-value', addField
    content.on 'click', '.delete', removeField

    content

  # Removes a field from the list.
  removeField = (event) ->
    event.preventDefault()

    target = $(event.currentTarget).closest('li')

    target.remove()

  addDefault = ->
    cmsField = getCmsField($('.editing.diagramm_widget'))
    content = $('<li>').html(template())

    cmsField.find('ul').append(content)

  fillFields = (datas) ->
    for data in datas
      console.log('fill field')
      cmsField = $('.editing.diagramm_widget').find('ul')
      content = $('<li>').html(template())

      cmsField.append(content)

      content.find('[name="name"]').attr('value', data['name'])
      content.find('[name="value"]').attr('value', data['value'])

      content.on 'click', '.add-value', addField
      content.on 'click', '.delete', removeField
      content.on 'focusout', 'input', save

  save = ->
    console.log('save' + endcodeData())
    $('.editing.diagramm_widget [data-ip-field-name="data"]').infopark('save', endcodeData())

  # Initialize linklist editor and setup event callbacks.
  infopark.on 'new_content', (root) ->
    listElements = $('.editing.diagramm_widget li')
    datas = decodeDatas($('.editing .diagram_data').val())

    if datas.length == 0
      addDefault()
    else
      fillFields(datas)

    listElements.on 'click', '.add-value', addField
    listElements.on 'click', '.delete', removeField


