init = ->
  drag_start = (event) ->
    style = window.getComputedStyle(event.target, null)
    event.dataTransfer.setData "text/plain", (parseInt(style.getPropertyValue("left"), 10) - event.clientX) + "," + (parseInt(style.getPropertyValue("top"), 10) - event.clientY)
  drag_over = (event) ->
    event.preventDefault()
    false
  drop = (event) ->
    offset = event.dataTransfer.getData("text/plain").split(",")
    dm = document.getElementById("drag")
    dm.style.left = (event.clientX + parseInt(offset[0], 10)) + "px"
    dm.style.top = (event.clientY + parseInt(offset[1], 10)) + "px"
    event.preventDefault()
    false
  dm = document.getElementById("drag")
  dm.addEventListener "dragstart", drag_start, false
  document.body.addEventListener "dragover", drag_over, false
  document.body.addEventListener "drop", drop, false
window.onload = init

