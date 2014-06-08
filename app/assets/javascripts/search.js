

function redirect_autocomplete_click(source){
    alert(source);
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
    if(source == "movies"){
        $('#movie_search').typeahead({
            name: "movie",
            remote: "/movies/autocomplete?query=%QUERY",
            valueKey: "name",
            minLength: "1",
            template: function(data) {
                var img_src = data.img;
                if(img_src == "Missing")
                    img_src = "/images/missing.jpg";
                return '<div class="suggestion_box"><img class="suggest_img" src="' +img_src+ '" /><div class="suggest_name">' +data.name+ '</div><div class="suggest_year">(' + data.year +')</div></div>';
            },
            engine: Hogan
        }).on("typeahead:selected", function($e){
            redirect_autocomplete_click(source);
            return false;
        });
    }
    else{
        $('#movie_search').typeahead({
            name: "location",
            remote: "/locations/autocomplete?query=%QUERY",
            valueKey: "name",
            minLength: "1",
            template: function(data) {
                return '<div class="suggestion_box"><div class="suggest_name">' +data.name+ '</div></div>';
            },
            engine: Hogan
        }).on("typeahead:selected", function($e){
            redirect_autocomplete_click(source);
            return false;
        });
    }
};
