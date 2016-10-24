jQuery ($) ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_games_url = $('.pagination a.next_page').attr('href')
      if more_games_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_games_url
      return
  return