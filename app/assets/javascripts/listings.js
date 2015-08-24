$(function(){
  $(".delete_attachment").on("click", function(e) {
    console.log("delete attachment");
    e.preventDefault();
    console.log(e.currentTarget.href);
    $.ajax({
      url : e.currentTarget.href,
      method : "DELETE"
    }).done(function(response) {
      try {
        $("#attachment_"+response.id).remove();
      } catch(e){
        console.log("error removing");
      }
    })
  })
})
