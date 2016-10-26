
$(document).ready(function() {

  var games = new Vue({
    el: '#games',
    data: {
      games: []
    },
    created: function() {
      console.log('Loading');
      this.scroll();
      var that = this;
      var lastDateTimeString = getLastDateTime(this.games)
      $.ajax({
        url: `/games.json?game_datetime=${lastDateTimeString}`,
        success: function(res) {
          that.games = res.games;
        }
      });
    },
    methods: {
      scroll: function() {
        window.addEventListener('scroll', function () {
          if($(window).scrollTop() + $(window).height() == $(document).height()) {
            console.log('end of page');
          }
        })
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
