jQuery ->

  draggables = jQuery.parseJSON("""<%=raw @draggables %>""")

  currentDraggables = $("div.ui-draggable")
  currentDraggables.animate
    top: "-=1000px", 320
  setTimeout (->
    currentDraggables.remove()
  ), 321

  setTimeout (->
    $.each draggables, (key, value) ->
      console.log key

      if key.match(/required/)
        requiredDiv = $("""<div class="ui-draggable required_terms down"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" id="required_terms" name="search[required_terms]" placeholder="Terms" size="10" type="text">""").val(value.value)
        input.appendTo requiredDiv
        requiredDiv.appendTo $("#" + value.parent_id)
        requiredDiv.draggable()
      else if key.match(/domain/)
        domainDiv = $("""<div class="ui-draggable domain down cloner"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name="search[domain]" placeholder="Domain" size="10" type="text">""").val(value.value)
        input.appendTo domainDiv
        domainDiv.appendTo $("#" + value.parent_id)
        domainDiv.draggable()
      else if key.match(/image/)
        imageDiv = $("""<div class="ui-draggable image down"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name="search[image]" Value="image" size="10" type="text" READONLY>""").val(value.value)
        input.appendTo imageDiv
        imageDiv.appendTo $("#" + value.parent_id)
        imageDiv.draggable()
      else if key.match(/file_type/)
        file_typeDiv = $("""<div class="ui-draggable file_type down"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<select class="expandable" id="search_file_type" name="search[file_type]"><option value="" disabled selected>File Type</option><option value="pdf">pdf</option><option value="doc">doc</option><option value="xls">xls</option><option value="txt">txt</option><option value="rtf">rtf</option></select>""").val(value.value)
        input.appendTo file_typeDiv
        file_typeDiv.appendTo $("#" + value.parent_id)
        file_typeDiv.draggable()
      else if key.match(/result_type/)
        result_typeDiv = $("""<div class="ui-draggable result_type down"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<select class="expandable" id="search_result_type" name="search[result_type]"><option value="" disabled selected>Result Tpye</option><option value="popular">Popular</option><option value="recent">Recent</option><option value="mixed">Mixed</option></select>""").val(value.value)
        input.appendTo result_typeDiv
        result_typeDiv.appendTo $("#" + value.parent_id)
        result_typeDiv.draggable()
      else if key.match(/must/)
        mustDiv = $("""<div class="ui-draggable must_have down"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name="search[must_have]" placeholder="Must Have"  size="10" type="text">""").val(value.value)
        input.appendTo mustDiv
        mustDiv.appendTo $("#" + value.parent_id)
        mustDiv.draggable()
      else if key.match(/excluded_terms/)
        excludedDiv = $("""<div class="ui-draggable excluded_terms down"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name='search[excluded_terms]' placeholder="Shouldnt Have"  size='10' type='text'>""").val(value.value)
        input.appendTo excludedDiv
        excludedDiv.appendTo $("#" + value.parent_id)
        excludedDiv.draggable()
      else if key.match(/exact_terms/)
        exactDiv = $("""<div class='ui-draggable exact_terms down'></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name='search[exact_terms]' placeholder="Exact"  size='10' type='text'>""").val(value.value)
        input.appendTo exactDiv
        exactDiv.appendTo $("#" + value.parent_id)
        exactDiv.draggable()
      else if key.match(/google/)
        googleDiv = $("""<div class="ui-draggable google down" id="google"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name="search[google]" Value="google" size="10" type="hidden" READONLY>""").val(value.value)
        input.appendTo googleDiv
        googleDiv.appendTo $("#" + value.parent_id)
        googleDiv.draggable()
      else if key.match(/twitter/)
        twitterDiv = $("""<div class="ui-draggable twitter down" id="twitter"></div>""").css
          top: value.top - 1000
          left: value.left
        input = $("""<input class="expandable" name="search[twitter]" Value="twitter" size="10" type="hidden" READONLY>""").val(value.value)
        input.appendTo twitterDiv
        twitterDiv.appendTo $("#" + value.parent_id)
        twitterDiv.draggable()
      else
        alert "Wrong key: #{key}"
      # console.log key
  ), 330

  setTimeout (->
    $("div.ui-draggable").animate
      top: "+=1000px", 320
    if $("#new_search").has(".ui-draggable").length > 0
      $("#box").animate
        backgroundColor: "rgba( 0, 191, 255, 0.3 )"
      $("#box").find("p").html "Ready to Search!"
  ), 500
