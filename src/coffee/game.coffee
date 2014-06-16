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
      @bird = new Bird(birdSprite)
      @pipes = []
      # @pipe.x = 500
      @width = 600
      @height = 400
      @pipeSpawnTime = 200
      @timeToPipeSpawn = 0

    tick: ->
      @update()
      @draw()

    update: ->
      # console.log(@timeToPipeSpawn)
      @timeToPipeSpawn--

      if @timeToPipeSpawn <= 0
        @spawnPipe()
        @timeToPipeSpawn = @pipeSpawnTime

      @bird.update()
      @pipeAt(@bird.x, @bird.y)

      for pipe in @pipes
        pipe.update()

    draw: ->
      ctx = document.getElementById('canvas').getContext('2d')
      ctx.fillStyle = 'white'
      ctx.fillRect(0, 0, @width, @height)
      @bird.draw(ctx)
      for pipe in @pipes
        pipe.draw(ctx)

    pipeAt: (x, y) ->
      for pipe in @pipes
        if pipe.x - 24 < x < pipe.x + 24 and Math.abs(pipe.y - y) > pipe.gap / 2
          alert('collision')

    spawnPipe: ->
      console.log("Spawning a pipe")
      pipe = new Pipe()
      pipe.x = @width
      pipe.y = 100 + (Math.random() * 200)
      @pipes.push(pipe)

  class Bird
    constructor: (sprite) ->
      @sprite = sprite
      @x = 50
      @y = 0
      @spriteWidth = sprite.width()
      @spriteHeight = sprite.height()

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

      ctx.fillStyle = 'red'
      ctx.fillRect(@x, @y, 2, 2)

  class Pipe
    constructor: ->
      @sprite = pipeSprite
      @x = 0
      @y = 100
      @spiteOffsetX = -25
      @spriteOffsetY = -371
      @gap = 75

    update: ->
      @x -= 2

    draw: (ctx) ->
      ctx.drawImage(@sprite, @x + @spiteOffsetX, @y + @spriteOffsetY)

      ctx.fillStyle = 'red'
      ctx.fillRect(@x, @y, 2, 2)

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

  birdSprite = new Image()
  birdSprite.src = 'public/img/bird.jpg'

  pipeSprite = new Image()
  pipeSprite.src = 'public/img/pipe2.png'

  pipeSprite.onload = ->
    console.log("image finished loading, starting game")
    game.start()
    main()