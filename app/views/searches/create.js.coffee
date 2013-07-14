jQuery ->

  $("#box2 div.inner").html( """<%= escape_javascript(render "google_search_results") %>""")
  $("#box3 div.inner").html( """<%= escape_javascript(render "twitter_search_results") %>""")
