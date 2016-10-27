
$(document).ready(function() {

  var games = new Vue({
    el: '#games',
    data: {
      games: []
    },
    created: function() {
      console.log('Loading');
      var that = this;
      var lastDateTimeString = getLastDateTime(this.games)
      var lock = true;

          $.ajax({
            url: `/games.json?game_datetime=${lastDateTimeString}`,
            success: function(res) {
              console.log('Scroll loading');
              that.games = res.games;
              lock = false;
            }
          });

    },
    methods: {
      viewGame: function(event) {
        var target = event.currentTarget;
        $(target).addClass('game-click');

        setTimeout(function() {
          $(target).removeClass('game-click');
        }, 400);
      }
    }
  });

  function getDateTime() {
    var today = new Date();
      var yr = today.getFullYear();
      var month = today.getMonth() + 1;
      var day = today.getDate();
      return yr + '-' + month + '-' + day + ' 00:00:00';
  }

  function getLastDateTime(games_array) {
    if (games_array.length === 0) {
      return getDateTime();
    } else {
      return games_array[games_array.length - 1].datetime;
    }
  }

});
