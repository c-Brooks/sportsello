
$(document).ready(function() {
  Vue.use(infiniteScroll);
console.log(infiniteScroll);
  var games = new Vue({
    el: '#games',
    data: {
      games: [],
      busy: true
    },
    methods: {
      loadMore: function() {
        console.log('Loading');
        var that;
        that = this;
        var lastDateTimeString = getLastDateTime(this.games)
        console.log(lastDateTimeString)
        this.busy = true;

        $.ajax({
          url: `/games.json?game_datetime=${lastDateTimeString}`,
          success: function(res) {
            that.games = res.games;
            // that.busy = false;
          }
        });
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
