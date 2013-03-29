$(document).ready(function(){
  
  $('a.login').on('click', function(e){
    e.preventDefault();

    if ($('form.form-signin').css("visibility") == "hidden")
      {
        $('form.form-signin').css("visibility", "visible");
      }
    else
      {
        $('form.form-signin').css("visibility", "hidden")
      }
  });


  $('a.signup').on('click', function(e){
    e.preventDefault();

    if ($('form.form-signup').css("visibility") == "hidden")
      {
        $('form.form-signup').css("visibility", "visible");
      }
    else
      {
        $('form.form-signup').css("visibility", "hidden")
      }
  });


});
