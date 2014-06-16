game = null;

window.main = ->
  window.requestAnimationFrame(main)
  game.tick()


window.onload = ->

  window.addEventListener('keyup', ((event) -> Key.onKeyup(event)), false);
  window.addEventListener('keydown', ((event) -> Key.onKeydown(event)), false);

  gravity = 0.1;

  class Game
    start: ->
      @bird = new Bird(img)
      @width = 500
      @height = 300

    tick: ->
      @update()
      @draw()

    update: ->
      @bird.update()

    draw: ->
      ctx = document.getElementById('canvas').getContext('2d')
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, @width, @height)
      @bird.draw(ctx)


  class Bird
    constructor: (sprite) ->
      @sprite = sprite
      @x = 15
      @y = 0
      @vAccel = 0
      @flapAccel = -5
      @canFlap = true

    update: ->
      if Key.isDown(Key.JUMP)
        @flap()
        @canFlap = false
      else
        @canFlap = true

      @vAccel += gravity
      @y += @vAccel

    flap: ->
      if @canFlap
        console.log("Flap!")
        @vAccel = @flapAccel

    draw: (ctx) ->
      ctx.drawImage(@sprite, @x, @y)

  Key =
    _pressed: {}

    JUMP: 32

    isDown: (keyCode) ->
      @_pressed[keyCode]

    onKeydown: (event) ->
       @._pressed[event.keyCode] = true

    onKeyup: (event) ->
      delete @._pressed[event.keyCode]


  game = new Game()

  img = new Image()
  img.src = 'public/img/bird.jpg'

  img.onload = ->
    console.log("image finished loading, starting game")
    game.start()
    main()