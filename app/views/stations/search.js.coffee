$("#result").empty()
  .append("<%= escape_javascript(render 'stations/search_result', stations: @stations) %>")