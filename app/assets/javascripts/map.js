function initialize() {
    var mapOptions = {
        zoom: 3,
        center: new google.maps.LatLng(48.143889, 17.109722),
        mapTypeId: google.maps.MapTypeId.HYBRID
    };

    var map = new google.maps.Map(document.getElementById('map_home'),
        mapOptions);
}

function loadScript() {
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' +
        'callback=initialize';
    document.body.appendChild(script);
}

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