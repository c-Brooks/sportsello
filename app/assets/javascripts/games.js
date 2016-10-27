
$(document).ready(function() {
  var count = 1;

  var games = new Vue({
    el: '#games',
    data: {
      games: []
    },
    created: function() {
      this.scroll();
      var that = this;
      var lastDateTimeString = getDateTime()
      console.log(lastDateTimeString);
      $.ajax({
        url: `/games.json?game_datetime=${lastDateTimeString}`,
        success: function(res) {
           res.games.forEach(function(game){
              that.games.push(game);
            });
        }
      });
    },
    methods: {
      scroll: function() {
        var then = this;
        window.addEventListener('scroll', function () {
          if($(window).scrollTop() + $(window).height() == $(document).height()) {
            var that = then;
            var newDateTimeString = getLastDateTime(that.games);
            $.ajax({
              url: `/games.json?game_datetime=${newDateTimeString}`,
              success: function(res) {
                console.log('doing it');
                res.games.forEach(function(game){
                  that.games.push(game);
                });
              }
            });
          }
        })
      }
    }
  });

  function getDateTime() {
    var today = new Date();
      var yr = today.getFullYear();
      var month = today.getMonth() + 1;
      var day = today.getDate() - 1;
      return yr + '-' + month + '-' + day + ' 00:00:00.000000';
  }

  function getLastDateTime(games_array) {
    console.log(JSON.stringify(games_array[games_array.length - 1]))
      return games_array[games_array.length - 1].datetime;
  }


});
