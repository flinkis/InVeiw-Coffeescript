( (window, $) ->
  'use strict'

  inViewTrigger = ( el, fromTop ) ->
    elTop = $(el).offset().top
    elBottom = elTop + $(el).height()
    viewportBottom = $(window).scrollTop() + $(window).height()
    fromTop = fromTop || 0

    viewportBottom >= elTop + ($(el).height() * fromTop) && elBottom >= $(window).scrollTop()

  inView = ->
    renderdCount = 0
    ticking = false

    _init = ->
      $(window).on 'scroll.inView', _onScroll

    _onScroll = ->
      if (!ticking)
        ticking = true
        setTimeout( _uppdate , 60 )

    _uppdate = =>
      @.each( ->
        if !$( this ).hasClass('inView') and inViewTrigger( this )
          _checkTotalRendered()
          $( this ).addClass('inView')
      )
      ticking = false

    _checkTotalRendered = =>
      $(window).off('scroll.inView', _onScroll ) if ( ++renderdCount == @.length )

    _init()
    return this

  $.fn.inView = inView

)(window, jQuery)