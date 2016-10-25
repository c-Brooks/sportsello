$(document).ready(function() {

  var games = new Vue({
    el: '#games',
    data: {
      games: []
    },
    created: function() {
      var that;
      that = this;
      $.ajax({
        url: '/games.json',
        success: function(res) {
          that.games = res.games;
        }
      });
    }
  });
});
