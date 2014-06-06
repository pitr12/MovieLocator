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

function showmap(hash, id) {
    $(document).ready(function(){
        var raw_markers   = hash;
        var gmaps_markers;

        function createSidebarLi(json) {
            return ("<li><a>" + json.name + "<\/a></li>");
            };

        function bindLiToMarker($li, marker, json){
            $li.click(function(){
                handler.getMap().setZoom(14);
                marker.setMap(handler.getMap()); //because clusterer removes map property from marker
                marker.panTo();
                google.maps.event.trigger(marker.getServiceObject(), 'click');
                $('html, body').animate({
                    scrollTop: $("#map").offset().top
                }, 500);
                displayImages(json.name,1);
        });
        };

        function createSidebar(){
            for (var i=0;i<raw_markers.length;i++){
            var $li = $( createSidebarLi(raw_markers[i]) );
            $li.appendTo($('#markers_list'));
            bindLiToMarker($li, gmaps_markers[i],raw_markers[i]);
            }
            if(id == 2){
                handler.getMap().setZoom(12);
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

function showhide(){
    $('#toggle').click(function(){
        $('.movie_head').toggle();
    });

    $('#totop').click(function(){
        $("html, body").animate({ scrollTop: 0 }, "slow");
        return false;
    });
}

function displayImages(name, id){
    if(id ==1){
    document.getElementById('images_footer').innerHTML = '<iframe src="http://www.panoramio.com/wapi/template/list.html?tag='+ name +'&amp;width='+ $(document).width() +'&amp;height=200&amp;rows=1&amp;columns=8&amp;orientation=horizontal&amp;bgcolor=transparent" frameborder="0" width="'+ $(document).width() +'" height="200" scrolling="no" marginwidth="0" marginheight="0"> </iframe>'
    }
    else{
    document.getElementById('location_images').innerHTML = '<iframe src="http://www.panoramio.com/wapi/template/list.html?tag='+ name.name +'&amp;width='+ Math.ceil(($(document).width())*0.65) +'&amp;height=200&amp;rows=1&amp;columns=8&amp;orientation=horizontal&amp;bgcolor=transparent" frameborder="0" width="'+ Math.ceil(($(document).width())*0.65) +'" height="200" scrolling="no" marginwidth="0" marginheight="0"> </iframe>'
    }
}