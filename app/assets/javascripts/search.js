function redirect_autocomplete_click(source){
    $.get("/can_redirect?query=" + $('#movie_search').val(), function(data) {
        var obj = jQuery.parseJSON(data);
        if (obj.response) window.location = obj.url
        else{
            if(source == "movies")
                window.location = "/movies?utf8=✓&query=" + $('#movie_search').val() + "&commit=Search";
            else
                window.location = "/locations?utf8=✓&query=" + $('#movie_search').val() + "&commit=Search";
        }
    });
}

function autocomplete(source){
    $('#movie_search').typeahead({
        name: source,
        remote: "/" + source + "/autocomplete?query=%QUERY",
        valueKey: "name",
        minLength: "1",
        template: function(data) {
            if (source == "movies"){
                var img_src = data.img;
                if(img_src == "Missing")
                    img_src = "/images/missing.jpg";
                return '<div class="suggestion_box"><img class="suggest_img" src="' +img_src+ '" /><div class="suggest_name">' +data.name+ '</div><div class="suggest_year">(' + data.year +')</div></div>';
            }
            else{
                return '<div class="suggestion_box"><div class="suggest_name">' +data.name+ '</div></div>';
            }
        },
        engine: Hogan
    }).on("typeahead:selected", function($e){
        redirect_autocomplete_click(source);
        return false;
    });
};

function searchInitialize(){
    $(document).ready(function() {
        $("#category_movies").prop('checked', true);
        $("#category_locations").prop('checked', false);
        autocomplete("movies");
    });
};

function chooseAutocompleteSource(){
    $("#category_movies").click(function() {
        radioClick("movies");
    });
    $("#category_locations").click(function() {
        radioClick("locations");
    });
};

function radioClick(target){
    $('#movie_search').typeahead('destroy');
    window.redirect_autocomplete_click = function() {
        $.get("/can_redirect?query=" + $('#movie_search').val(), function(data) {
            var obj = jQuery.parseJSON(data);
            if (obj.response) window.location = obj.url
            else{
                window.location = "/"+ target +"?utf8=✓&query=" + $('#movie_search').val() + "&commit=Search";
            }
        });
    };
    autocomplete(target);
    document.getElementById('form_tag').setAttribute("action","/"+target);
};