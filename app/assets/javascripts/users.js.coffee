jQuery ->
  $(document).ready ->
    $(".photo-preview").click ->
      $("#upload-avatar").trigger "click"
      return

    $("#upload-avatar").change ->
      readURL this
      return

  readURL = (input) ->
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        img = new Image
        img.src = e.target.result
        $(".photo-preview").html "<img src=\"" + img.src +
          "\" height=\"100\" width=\"100\"/>"
        return

      reader.readAsDataURL input.files[0]
    return
