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

function showmap(hash) {
    $(document).ready(function(){
        var raw_markers   = hash;
        var gmaps_markers;

        function createSidebarLi(json) {
            return ("<li><a>" + json.name + "<\/a></li>");
            };

        function bindLiToMarker($li, marker){
            $li.click(function(){
                handler.getMap().setZoom(14);
                marker.setMap(handler.getMap()); //because clusterer removes map property from marker
                marker.panTo();
                google.maps.event.trigger(marker.getServiceObject(), 'click');
                $('html, body').animate({
                    scrollTop: $("#map").offset().top
                }, 500);
        });
        };

        function createSidebar(){
            for (var i=0;i<raw_markers.length;i++){
            var $li = $( createSidebarLi(raw_markers[i]) );
            $li.appendTo($('#markers_list'));
            bindLiToMarker($li, gmaps_markers[i]);
            }
        };

        handler = Gmaps.build('Google');
              handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
                  gmaps_markers = handler.addMarkers(raw_markers);
                  handler.bounds.extendWith(gmaps_markers);
                  handler.fitMapToBounds();
                  handler.getMap().setMapTypeId(google.maps.MapTypeId.HYBRID);
                  createSidebar();
              });
          })
}