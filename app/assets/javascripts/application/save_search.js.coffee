jQuery ->
  $(window).load ->

    $("#save-search").click ->
      draggables = undefined
      draggables = {}
      jQuery.each jQuery(".ui-draggable"), (index, draggable) ->
        child = undefined
        classes = undefined
        left = undefined
        offset = undefined
        top = undefined
        value = undefined
        draggable = jQuery(this)
        child = draggable.children()
        value = child.val()
        classes = draggable.attr("class").replace(/ui-draggable|down|cloner|\s/g, "")
        key = classes + index
        offset = draggable.offset()
        left = offset.left
        top = offset.top
        draggables[key] =
          value: value
          left: left
          top: top

      $.ajax
        type: "POST"
        url: "/searches/save_search"
        data:
          draggables: JSON.stringify(draggables)

        dataType: "json"
        success: (msg) ->
          alert "Data Saved: " + msg

        false
