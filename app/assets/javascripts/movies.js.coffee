# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#movie_search').typeahead
    name: "movie"
    remote: "/movies/autocomplete?query=%QUERY"