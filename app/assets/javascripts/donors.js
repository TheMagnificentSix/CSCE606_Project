var donorInfo = {
  setup: function(){
    $('#donorInfo').on('ajax:success',function(event,data,status,xhr){
      event.preventDefault();
      $('#summary-table tbody').html(data);
      $("#basic-submit").notify("Successfully saved", {className: "success", position:"left middle"});
    });
    $('#donorInfo').on('ajax:error',function(event,xhr,status,error){
      event.preventDefault();
      $("#basic-submit").notify("Error occurred, please try later...", {className: "error", position:"middle middle"});
    });
  }
};

$(donorInfo.setup);

var SearchScope = {
  select_scope : function() {
   $('#individual').toggle();
   $('#organization').toggle();
   SearchScope.reset_field();
  },
  reset_field : function() {
   $('#donor_first_name').val('');
   $('#donor_last_name').val('');
   $('#org_name').val('');
   $('#donor_company').val('');
  },
  setup: function() {
    $('#scope_link').change(SearchScope.select_scope);
    $('#reset_btn').click(SearchScope.reset_field);
  }
}
$(document).ready(SearchScope.setup);

var SearchResult = {
  setup : function() {
    $('#search_box').submit(SearchResult.getResult);
  },
  getResult : function() {
    $(document).on('ajax:success',function(event,data,status,xhrObj){
      $('#search_result').html(data);
    });
  }
};
$(document).ready(SearchResult.setup);

var viewResult = {
  setup : function() {
    $('#search_result th a, #search_result .pagination a').click(viewResult.render);
  },
  render : function(){
    $(document).on('ajax:success',function(event,data,status,xhrObj){
      $('#search_result').html(data);
    });
  }
};
$(document).ready(viewResult.setup);