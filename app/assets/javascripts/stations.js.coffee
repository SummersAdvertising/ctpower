$ ->
  #fetch_from_country
  $(document).on 'change', '#q_country_eq', (evt) ->
    $.ajax 'fetch_from_country',
      type: 'GET'
      dataType: 'script'
      data: {
        country_id: $("#q_country_eq option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        #console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        #console.log("Dynamic country select OK!")

  #fetch_from_city
  $(document).on 'change', '#q_city_eq', (evt) ->
    $.ajax 'fetch_from_city',
      type: 'GET'
      dataType: 'script'
      data: {
        city_id: $("#q_city_eq option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        #console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        #console.log("Dynamic country select OK!")

 