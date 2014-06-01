function redirect_search() {
    $(document).ready(function() {
        $('#srchbtn').click(function() {
            $.get("/can_redirect?query=" + $('#movie_search').val(), function(data) {
                var obj = jQuery.parseJSON(data);
                if (obj.response) window.location = obj.url
                else window.location = "/movies?utf8=✓&query=" + $('#movie_search').val() + "&commit=Search"
            });
            return false;
        });
    });
}

function autocomplete(){
    $('#movie_search').typeahead({
        name: "movie",
        remote: "/movies/autocomplete?query=%QUERY",
        valueKey: "name",
        minLength: "2",
        template: "<p><strong>{{name}}</strong> - {{year}}</p>",
        engine: Hogan
    });
};