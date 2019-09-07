$(document).ready(function() {
  $(".preview-signup").change(function() {
    readURL(this, '#img-prev-signup');
  });

  $(".preview-edit-profile").change(function() {
    readURL(this, '.img-circle');
  });

  $(".hide-form-password").css('display', 'none');
  $(".show-form").on('click', function(){
    $(".hide-form-password").toggle();
    $(this).text( $(this).text() == 'More' ? "Hide" : "More");
  });

  $('#search-rooms').autocomplete({
    source:  "/autocomplete.json",
    select: function(event, ui){
      $("input#search-rooms").val(ui.item.value);
      $(this).closest('form').trigger('submit');
    }
  });

  if ($('#exampleSlider').length == 1) {
    $(this).multislider({
      interval: 5000,
      slideAll: false
    });
  }

});

function readURL(f, previewId) {
  if (f.files && f.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(previewId).attr('src', e.target.result);
    };
    reader.readAsDataURL(f.files[0]);
  }
}


function previewImages() {

  var $preview = $('#preview').empty();
  if (this.files) $.each(this.files, readAndPreview);

  function readAndPreview(i, file) {
    var reader = new FileReader();
    $(reader).on("load", function() {
      $preview.append($("<img/>", {src:this.result, height:150, width:150}));
    });
    reader.readAsDataURL(file);
  }
}

$(document).ready(function() {
  $('.preview-image').on("change", previewImages);
});
