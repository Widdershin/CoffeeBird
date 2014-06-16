class Looper
  constructor: ->
    @message = "Heyo"

  loop: ->
    toLoop = =>
      @loop()

    setTimeout(toLoop, 100)
    console.log(@message + " there!")


l = new Looper()

l.loop()