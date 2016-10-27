$(document).ready(function() {

  Vue.component('game-info', {
    data: function () {
      return {
        message: 'Hey there!',
      }
    },
    template: '<div class="game-info">{{ message }}</div>'
  });

  Vue.component('game-box', {
    props: ['datetime', 'sport', 'team1', 'team2'],
    template:
      `<div class="game" v-on:click="viewGame">
        <div class="time-container col-sm-3">
          <p class="time alt-text" v-text="datetime"></p>
        </div>
        <div class="info-container col-sm-9">
          <p class="sport alt-text" v-text="sport"></p>
          <div class="team1 col-sm-3" v-text="team1"></div>
          <div class="vs col-sm-3">VS</div>
          <div class="team2 col-sm-3" v-text="team2"></div>
        </div>
      </div>`,
    methods: {
      viewGame: function(event) {
        var target = event.currentTarget;
        $(target).addClass('game-click');
        $('.game-info').show();
        setTimeout(function() {
          $(target).removeClass('game-click');
        }, 400);
      }
    },
  });

  var games = new Vue({
    el: '#games',
    data: {
      games: [],
    },
    created: function() {
      this.scroll();
      this.getGames();
    },
    methods: {
      scroll: function() {
        var that = this;
        window.addEventListener('scroll', function () {
          if($(window).scrollTop() + $(window).height() == $(document).height()) {
            that.getGames();
          }
        })
      },
      getGames: function() {
        var that = this;
        var lastDateTimeString = getLastDateTime(this.games)
        var lock = true;

        $.ajax({
          url: `/games.json?game_datetime=${lastDateTimeString}`,
          success: function(res) {
            res.games.forEach(function(game) {
              that.games.push(game);
            });
            lock = false;
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
    console.log(JSON.stringify(games_array[games_array.length - 1]))
      return games_array[games_array.length - 1].datetime;
  }


});
