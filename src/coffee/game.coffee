game = null;

window.main = ->
  window.requestAnimationFrame(main)
  game.tick()


window.onload = ->

  gravity = 5;

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
      @x = 0
      @y = 0

    update: ->
      @x += 1
      @y += gravity

    draw: (ctx) ->
      ctx.drawImage(@sprite, @x, @y)


  game = new Game()

  img = new Image()
  img.src = 'public/img/bird.jpg'

  img.onload = ->
    console.log("image finished loading, starting game")
    game.start()
    main()