app = require '../app'

###*
 # Logic implemented in this service is a derived version of Angular Calculator Demo by Thom Porter (http://www.thomporter.com/docco/calc.html).
###
app.factory '$calc', ->

  memory = 0
  stuff = [0]
  justGotMath = false
  display = ''

  input: (n) ->
    console.log "input: #{n}"
    if justGotMath
        justGotMath = false
        stuff = [] if !@isOperator(n)

    n = n.toString()
    if n == '.'
      last = stuff.pop()
      if @isOperator(last) || Math.ceil(last) != parseInt(last)
        stuff.push(last)
      else
        last += '.'
        stuff.push(last)
        @writeScreen()
      return

    if (@isOperator(n))
      return if !stuff.length
      last = stuff.pop()
      stuff.push(last) if !@isOperator(last)
      stuff.push(n)
    else if stuff.length
      last = stuff.pop()
      if @isOperator(last)
        stuff.push(last)
        stuff.push(n)
      else if last.toString() == '0'
        stuff.push(n)
      else
        last += n.toString()
        stuff.push(last)
    else
      stuff.push(n)
    @writeScreen()
    console.log stuff
    @

  isOperator: (n) ->
    if isNaN(n)
      return true if n != '.'
    return false

  changeSign: () ->
    last = stuff.pop()
    if @isOperator(last)
      second_last = stuff.pop()
      if second_last.substr(0,1) == '-'
        second_last = substr(1)
      else
        second_last = '-' + second_last
      stuff.push(second_last)
    else
      if last.substr(0,1) == '-'
        last = substr(1)
      else
        last = '-' + last
    stuff.push(last)
    @writeScreen()

  writeScreen: () ->
    write = '';
    angular.forEach(stuff, (k, i)->
      if write == ''
        write = k
      else
        write += k.toString()
    )
    write = '0' if (write == '')
    display = write.toString();
    return

    if @isOperator(n)
      write = if n == '/'
        '&divide;'
      else if n == '*'
        '&times;'
      else if n == '+'
        '&plus;'
      else if n == '-'
        '&minus;'
    if (!stuff.length)
      display = write
    else
      display += write.toString()
    @

  clearCalc: () ->
    stuff = []
    @writeScreen()

  doMath: () ->
    justGotMath = true
    stuff = [@getMath()]
    @writeScreen()

  getMath: ->
    last = stuff.pop()
    if (!@isOperator(last))
      stuff.push(last)

      job = stuff.join('');
      x = 0
      eval('x = ' + job + ';');
      x

  memoryClear: ->
    memory = 0
    @memoryIndicator(0)

  memoryShow: ->
    stuff = [memory.toString()]
    @writeScreen()

  memoryAdd: () ->
    memory += @getMath()
    @memoryIndicator(1)

  memorySub: () ->
    memory -= @getMath()
    if (memory != 0)
      @memoryIndicator(1)
    else
      @memoryIndicator(0)

  display: -> display
