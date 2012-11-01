function hideRateForm() {
  $("form.edit_project").hide();
  $(".edit_project_rate").show();
  return false;
}

function showRateForm() {
  $("form.edit_project").show();
  $(".edit_project_rate").hide();
  return false;
}

function setupCheckboxes() {
  // XXX - refactor with a a function.
  $("#all-entries").live('click', function(event) {
    $(".commit-entry").attr("checked", true);
  });

  $("#new-entries").live('click', function(event) {
    $(".commit-entry").attr("checked", false);
    $(".commit-entry[data-invoiced=false]").attr("checked", true);
  });

  $("#old-entries").live('click', function(event) {
    $(".commit-entry").attr("checked", false);
    $(".commit-entry[data-invoiced=true]").attr("checked", true);
  });

  $("#mine-entries").live('click', function(event) {
    $(".commit-entry").attr("checked", false);
    $(".commit-entry[data-mine=true]").attr("checked", true);
  });

  $("#none-entries").live('click', function(event) {
    $(".commit-entry").attr("checked", false);
  });
}

jQuery(function($) {
  $(".edit_project_rate").live('click', function(event) { showRateForm(); return false; });
  $("#hide_project_rate").live('click', function(event) { hideRateForm(); return false; });

  $(".project").filter(":even").addClass("even");
  $(".project").filter(":odd").addClass("odd");

  setupCheckboxes();

  var qs = $('input.projects_quicksearch').quicksearch("#projects .project:visible",
                                                        { noResults : ".no_results" });

  $(".search #filters .filter a").live('click', function(){
    var $this = $(this);
    var selector = $this.data("show");
    $(".search #filters .filter .filtered").removeClass("filtered");
    $this.addClass("filtered");
    $(".project").not(selector).hide();
    $(selector).show();
    qs.cache();
    return false;
  });
  
  
});
