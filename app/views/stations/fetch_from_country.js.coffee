$("#q_city_eq").empty()
  .append("<%= escape_javascript(render(:partial => @cities)) %>")
$("#q_district_eq").empty()
  .append("<%= escape_javascript(render(:partial => @districts)) %>")