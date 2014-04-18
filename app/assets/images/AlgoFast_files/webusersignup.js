function tab(tab) 
{
  console.log("clicked tab " + tab)

    // set all tab class attribute to ""
    var tabs_def = document.getElementById("tabs-def");
    var tabs_def_items = tabs_def.getElementsByTagName("li");
    console.log("Total items found " + tabs_def_items.length);

    for (index = 0; index < tabs_def_items.length; ++index)
    {
      console.log(tabs_def_items[index])
      tabs_def_items[index].setAttribute("class", "");

        //set icon eletement to none
        icon_tag = tabs_def_items[index].getElementsByTagName("i");
        icon_tag[0].style.display = "none";
      }

    // set all tab display type to none
    var tabs_content = document.getElementById("tabs-content");
    var tabs_display = tabs_content.getElementsByTagName("li");                
    console.log("Total items found " + tabs_display.length);

    for (index = 0; index < tabs_display.length; ++index)
    {
      console.log(tabs_display[index])
      tabs_display[index].style.display = "none";                                    
    }

    // make current tab active and remove style attribute from icon
    // tag so arrow icon gets displayed
    document.getElementById(tab).style.display = "block";
    tab_def_ele = document.getElementById("li_"+tab);
    tab_def_ele.setAttribute("class", "tabNav_active");
    icon_tag = tab_def_ele.getElementsByTagName("i");
    icon_tag[0].removeAttribute("style");
  }

  $(document).ready(function() {
    $(".editbtn").click(function() {
      var edit_field = $(this).attr("edit_class_name");
      $("." + edit_field).show();
    });

    $(".cnBtn").click(function() {
      var edit_field = $(this).attr("edit_class_name");
      $("." + edit_field).hide();
    });
  });
