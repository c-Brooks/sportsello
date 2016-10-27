$(document).ready(function() {

  var games = new Vue({
    el: '#games',
    data: {
      games: []
    },
    created: function() {
      this.scroll();
      var that = this;
      getGames(that);
    },
    methods: {
      scroll: function() {
        window.addEventListener('scroll', function () {
          if($(window).scrollTop() + $(window).height() == $(document).height()) {

          }
        })
      },
      viewGame: function(event) {
        var target = event.currentTarget;
        $(target).addClass('game-click');

        setTimeout(function() {
          $(target).removeClass('game-click');
        }, 400);
      }
    }
  });

  function getGames(gamesVue) {
    var lastDateTimeString = getLastDateTime(gamesVue.games)
    var lock = true;

    $.ajax({
      url: `/games.json?game_datetime=${lastDateTimeString}`,
      success: function(res) {
        gamesVue.games = res.games;
        lock = false;
      }
    });
  }

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
