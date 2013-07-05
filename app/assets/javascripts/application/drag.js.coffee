jQuery ->
  $("#add-div").click ->
    $("<div id='draggable' class='ui-draggable' style='left: 215px; top: 64px;'><input id='search_terms' name='search[terms]' placeholder='Type * Drag' size='10' type='text'></div>").draggable().appendTo( "body" );



$ ->
  # $("#draggable").draggable()
  $("#draggable").draggable ->
    start: (event, ui) ->

      # flag to indicate that we want to remove element on drag stop
      ui.helper.removeMe = true

    stop: (event, ui) ->

      # remove draggable if flag is still true
      # which means it wasn't unset on drop into parent
      # so dragging stopped outside of parent
      ui.helper.remove()  if ui.helper.removeMe

    # move back if dropped into a droppable
    revert: "valid"
  $("#droppable").droppable(
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      accept: ":not(.ui-sortable-helper)"
      drop: (event, ui) ->
        $(this).find("p").html "Dropped!"
        $(this).animate
          color: "green"
          backgroundColor: "rgb( 20, 20, 20 )"
        $("<li></li>").text(ui.draggable.text()).addClass("cart-item").appendTo this
    )


init = ->
  # I'm assuming that 1 letter will expand the input by 6 pixels
  oneLetterWidth = 6

  # I'm also assuming that input will resize when at least 10 live characters
  # are typed
  minCharacters = 10

  dragbox = $("#draggable")
  $("input").keyup ->
    len = $(this).val().length
    if len > minCharacters

      # increase width
      dragbox.width len * oneLetterWidth
      $(this).width len * oneLetterWidth
    else

      # restore minimal width;
      dragbox.width 70
      $(this).width 70

window.onload = init

