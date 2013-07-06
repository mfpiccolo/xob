jQuery ->

  $("#add-div").click ->
    $("<div id='draggable' class='ui-draggable' style='left: 215px; position: absolute;'><input id='search_terms' name='search[terms]' placeholder='Type * Drag' size='10' type='text'></div>").draggable().appendTo( "#whole-page" );

  $ ->
    $("#draggable").draggable ->
      start: (event, ui) ->
        ui.helper.removeMe = true

      stop: (event, ui) ->
        ui.helper.remove()  if ui.helper.removeMe
      revert: "valid"
      helper:"clone"

  $("#whole-page").droppable(
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    accept: ":not(.ui-sortable-helper)"

    drop: (event, ui) ->
      $(ui.draggable).appendTo($("#whole-page"))
      $("#new_search").has(".ui-draggable").length
      if $("#new_search").has(".ui-draggable").length == 0
        $("#box").animate
          backgroundColor: "rgb( 224, 255, 255  )"
        $("#box").find("p").html "Drop stuff in here!"
  )

  $("#box").droppable(
    greedy: true
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    accept: ":not(.ui-sortable-helper)"
    drop: (event, ui) ->
      # alert "eh"
      $(this).find("p").html "Ready to Search!"
      $(this).animate
        backgroundColor: "rgb( 0, 191, 255 )"
      $(ui.draggable).appendTo($("#new_search"))
  )

  $(document).on "click", "input", ($e) ->
    $(this).on "keyup", ->
      oneLetterWidth = 6
      minCharacters = 10
      dragbox = $(this).parent()
      len = $(this).val().length
      if len > minCharacters

        # increase width
        dragbox.width len * oneLetterWidth
        $(this).width len * oneLetterWidth
      else

        # restore minimal width;
        dragbox.width 70
        $(this).width 70
