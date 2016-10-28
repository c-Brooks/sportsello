$(document).ready(function() {

  Vue.component('vue-panel', {
    template:
      `<div class="close-panel clickable" v-on:click="closePanel">
        &times;
      </div>`,
    methods: {
      closePanel: function() {
        home.view = 'empty';
        // Enable the scroll for the body
        $('body').css('overflow', 'scroll');
      }
    }
  });

  var gameInfo = {
    props: ['game_info'],
    template:
      `<div class="vue-panel">
        <vue-panel/>
        <div class="app-container">
          <div class="game-info">
            <game-box
              :datetime="game_info.datetime"
              :sport="game_info.sport"
              :team1="game_info.team1"
              :team2="game_info.team2">
            </game-box>
            <div class="section-header">EVENTS</div>
            <event-box
              v-for="event in game_info.events"
              :id="event.id"
              :name="event.name"
              :venue="event.venue">
            </event-box>
          </div>
        </div>
      </div>`
  };

  Vue.component('event-box', {
    props: ['id', 'name', 'venue'],
    template:
      `<div class="event">
        <div class="col-sm-3">
        </div>
        <div class="info-container col-sm-9">
          <p class="alt-text" v-text="venue.description"></p>
          <div class="center">
            <div class="event-name col-sm-3" v-text="name"></div>
            <div class="at col-sm-3">@</div>
            <div class="venue-name col-sm-3" v-text="venue.name"></div>
          </div>
        </div>
      </div>`
  });

  Vue.component('game-box', {
    props: ['id', 'datetime', 'sport', 'team1', 'team2'],
    data: function() {
      return {
        displayDate: false,
        date: this.datetime
      }
    },
    beforeMount: function() {
      if (home.view != 'game-info') {
        // Format date
        var date = new Date(this.datetime);
        var month = date.getMonth() + 1;
        var date = date.getDate();
        var year = '2016'//date.getFullYear();

        this.date = year + '-' + month + '-' + date;

        if (home.lastDate != date) {
          home.lastDate = date;
          this.displayDate = true;
        }
      }
    },
    template:
      `<div>
        <div class="section-header" v-if="displayDate" v-text="date"></div>
        <div class="game" v-on:click="viewGame">
          <div class="time-container col-sm-3">
            <p class="time alt-text" v-text="datetime"></p>
          </div>
          <div class="info-container col-sm-9">
            <p class="sport alt-text" v-text="sport"></p>
            <div class="center">
              <div class="team1 col-sm-3" v-text="team1"></div>
              <div class="vs col-sm-3">VS</div>
              <div class="team2 col-sm-3" v-text="team2"></div>
            </div>
          </div>
        </div>
      </div>`,
    methods: {
      viewGame: function(event) {
        home.view = 'game-info';

        // Hide the scroll for the body
        $('body').css('overflow', 'hidden');

        var target = event.currentTarget;
        $(target).addClass('game-click');
        setTimeout(function() {
          $(target).removeClass('game-click');
        }, 400);

        $.ajax({
          url: `/games/${this.id}`,
          success: function(res) {
            home.game_info = {
              datetime: res.datetime,
              sport: res.sport.name,
              team1: res.team1.name,
              team2: res.team2.name,
              events: res.events
            };
          }
        });
      }
    },
  });

  $('.log-in').click(function() {
    home.view = 'login';
    // Hide the scroll for the body
    $('body').css('overflow', 'hidden');
  });

  $('.register').click(function() {
    home.view = 'register';
    // Hide the scroll for the body
    $('body').css('overflow', 'hidden');
  });

  Vue.component('login-form', {
    template:
      `<div class="login-form">
        <form id="loginForm" action="/login" method="POST">
          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="example@sportsello.com">
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
          </div>
          <button type="submit" class="btn btn-default pull-right">Log in</button>
        </form>
      </div>`
  });

  Vue.component('facebook-button', {
    template:
      `<button class="btn btn-block btn-social btn-facebook" onclick="window.location.href='/auth/facebook'">
        <span class="fa fa-facebook"></span>
        Log in with Facebook
      </button>`
  });

  Vue.component('register-form', {
    template:
      `<div class="login-form">
        <form action="/users" method="POST">

          <div class="form-group">
            <label for="name">Name</label>
            <input type="name" class="form-control" id="name" name="name" placeholder="Wayne Gretzky">
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="example@sportsello.com">
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
          </div>

          <div class="form-group">
            <label for="password_confirmation">Password Confirmation</label>
            <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" placeholder="Password Confirmation">
          </div>

          <button type="submit" class="btn btn-default pull-right">Register</button>
        </form>

      </div>`
  });

  var login = {
    template:
      `<div class="vue-panel">
        <vue-panel/>
        <div class="app-container">

          <div class="login box">
            <facebook-button/>
            <div class="center special-text">OR</div>
            <login-form/>
          </div>

        </div>
      </div>`
  };

  var register = {
    template:
      `<div class="vue-panel">
        <vue-panel/>
        <div class="app-container">
          <div class="login box">
            <facebook-button/>
            <div class="center special-text">OR</div>
            <register-form/>
          </div>
        </div>
      </div>`
  }

  var empty = {
    template: '<div></div>'
  };

  var home = new Vue({
    el: '#home',
    components: {
      'empty': empty,
      'game-info': gameInfo,
      'login': login,
      'register': register
    },
    data: {
      view: 'empty',
      games_list: [],
      game_info: {},
      last_date: ''
    },
    created: function() {
      this.scroll();
      this.getGames();
    },
    updated: function() {
      $('.bottom-loader').hide();
      $('.loader').fadeTo("slow", 0);
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
        $('.bottom-loader').show();
        var that = this;
        var lastDateTimeString = getLastDateTime(this.games_list)

        $.ajax({
          url: `/games.json?game_datetime=${lastDateTimeString}`,
          success: function(res) {
            res.games.forEach(function(game) {
              that.games_list.push(game);
            });
            $('.bottom-loader').hide();
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
