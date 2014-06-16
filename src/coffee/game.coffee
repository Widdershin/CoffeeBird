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
      @bird = new Bird(birdSprite, 60, 200)
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
          console.log('collision')

          ctx = document.getElementById('canvas').getContext('2d')
          ctx.fillRect(x - 5, y - 5, 10, 10)

    spawnPipe: ->
      pipe = new Pipe(pipeSprite)
      pipe.x = @width
      pipe.y = 100 + (Math.random() * 200)
      @pipes.push(pipe)

  class GameObject
    constructor: (sprite, x = 0, y = 0) ->
      @sprite = sprite
      @x = x
      @y = y
      @width = sprite.naturalWidth
      @height = sprite.naturalHeight
      @spriteOffsetX = -(@width / 2)
      @spriteOffsetY = -(@height / 2)

    draw: (ctx) ->
      ctx.drawImage(@sprite, @x + @spriteOffsetX, @y + @spriteOffsetY)


      ctx.fillStyle = 'red'
      ctx.fillRect(@x - 1, @y - 1, 2, 2)


  class Bird extends GameObject
    constructor: (sprite, x = 15, y = 15) ->
      super sprite, x, y

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
        @vAccel = @flapAccel


  class Pipe extends GameObject
    constructor: (sprite, x = 0, y = 0) ->
      super sprite, x, y
      @gap = 85
      @spriteOffsetY += 25

    update: ->
      @x -= 2

    draw: (ctx) ->
      super ctx

      ctx.fillStyle = 'red'
      ctx.beginPath()
      ctx.rect @x - 24, @y - @gap / 2, 48, @gap
      ctx.lineWidth = 3
      ctx.strokeStyle = 'black'
      ctx.stroke()
      # console.log 'finished drawing'


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

  gameStarted = false

  gameStarter = (event) ->
    # console.log(event.keyCode)
    if event.keyCode == 32 and not gameStarted
      console.log("starting game")
      game.start()
      main()
      gameStarted = true

  window.addEventListener('keydown', ((event) -> gameStarter(event)), false);
