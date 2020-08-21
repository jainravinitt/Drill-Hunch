/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
<script type="text/javascript">
    $(document).ready(function () {
  
          
      var popup = $("#popup"),
      doc = $(document),
      popClass = "popped",
      showPopup = function (event) {
        popup.fadeIn(200);
        event.preventDefault();
      },
      hidePopup = function (event) {
        popup.hide();
        event.preventDefault();
      };
  
  doc.on("click", "#open-popup", showPopup);
  doc.on("click", ".popup__close", hidePopup);
  
  doc.keypress(function (event) {
    if (event.keyCode === 27) { // esc key
      hidePopup();
    }
  });
  
});
</script>

