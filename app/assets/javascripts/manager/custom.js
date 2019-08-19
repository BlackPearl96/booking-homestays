function readURL(f, previewId) {
  if (f.files && f.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(previewId)
        .attr('src', e.target.result);
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

$(document).ready(function(){
  $('#room_table').DataTable({
    scrollY: 500,
    "pageLength": 25,
  });

  $('#admin_table').DataTable({
    scrollY: 500,
    "pageLength": 25,
    "aaSorting": [],
    "columnDefs": [
      { "orderable": false, "targets": [5] },
    ]
  });

  $("#micropost_picture").bind("change", function(){
    var size_in_megabytes = this.files(0).size/1024/1024;
      if (size_in_megabytes > 5) {
        alert("Maximum file size is 5MB. Please choose an other file!");
      }
  });

  $('#member_table').DataTable({
    scrollY: 500,
    "pageLength": 25,
    "aaSorting": [],
    "columnDefs": [
      { "orderable": false, "targets": [5] },
    ]
  });

  $(".preview_member").change(function() {
    readURL(this, '#img_member_prev');
  });

  $(".dropdown-btn").click( function(e) {
    $(this).toggleClass('active');
    var dropdownContent = $(this).next();
    if (dropdownContent.css('display') === 'block') {
      dropdownContent.css('display', 'none');
    } else {
      dropdownContent.css('display', 'block');
    }
  });

  $('#admin-prices').DataTable({
    scrollY: 500,
    "pageLength": 25,
    "columnDefs": [
      { "orderable": false, "targets": [4] },
    ]
  });

  $(".account").click(function() {
    var getID=$(this).attr('id');
    if(getID==1) {
      $(".custom-submenu").hide();
      $(this).attr('id', '0');
    }
    else {
      $(".custom-submenu").show();
      $(this).attr('id', '1');
    }
  });

  $(".custom-submenu").mouseup(function() {
    return false
  });

  $(".account").mouseup(function() {
    return false
  });

  $(document).mouseup(function() {
    $(".custom-submenu").hide();
    $(".account").attr('id', '');
  });

  $('[data-toggle="tooltip"]').tooltip();

  $('.preview-image').on("change", previewImages);
});

