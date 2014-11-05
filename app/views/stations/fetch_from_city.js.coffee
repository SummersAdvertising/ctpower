$("#q_district_eq").empty()
  .append("<option value=''>-- 請選擇 --</option>")
  .append("<%= escape_javascript(render(:partial => @districts)) %>")