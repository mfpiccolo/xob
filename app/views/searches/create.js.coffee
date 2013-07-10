jQuery ->

  $("#box2 div.inner").html( """<%= escape_javascript(render "search_results") %>""")
