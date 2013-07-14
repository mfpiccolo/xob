jQuery ->

  opts =
    lines: 17 # The number of lines to draw
    length: 0 # The length of each line
    width: 6 # The line thickness
    radius: 21 # The radius of the inner circle
    corners: 1 # Corner roundness (0..1)
    rotate: 46 # The rotation offset
    direction: 1 # 1: clockwise, -1: counterclockwise
    color: "#000" # #rgb or #rrggbb
    speed: 1.6 # Rounds per second
    trail: 63 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: false # Whether to use hardware acceleration
    className: "spinner" # The CSS class to assign to the spinner
    zIndex: 2e9 # The z-index (defaults to 2000000000)
    top: "auto" # Top position relative to parent in px
    left: "auto" # Left position relative to parent in px

  target = document.getElementById("inner-box-2, inner-box-3")
  spinner = new Spinner(opts)


  $(document).ajaxStart ->
    spinner.spin(target)

    # Handle the beforeSend event
    ajaxStop: ->
      spinner.stop()
