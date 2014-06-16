// Generated by CoffeeScript 1.7.1
(function() {
  var game;

  game = null;

  window.main = function() {
    window.requestAnimationFrame(main);
    return game.tick();
  };

  window.onload = function() {
    var Bird, Game, gravity, img;
    gravity = 5;
    Game = (function() {
      function Game() {}

      Game.prototype.start = function() {
        this.bird = new Bird(img);
        this.width = 500;
        return this.height = 300;
      };

      Game.prototype.tick = function() {
        this.update();
        return this.draw();
      };

      Game.prototype.update = function() {
        return this.bird.update();
      };

      Game.prototype.draw = function() {
        var ctx;
        ctx = document.getElementById('canvas').getContext('2d');
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, this.width, this.height);
        return this.bird.draw(ctx);
      };

      return Game;

    })();
    Bird = (function() {
      function Bird(sprite) {
        this.sprite = sprite;
        this.x = 0;
        this.y = 0;
      }

      Bird.prototype.update = function() {
        this.x += 1;
        return this.y += gravity;
      };

      Bird.prototype.draw = function(ctx) {
        return ctx.drawImage(this.sprite, this.x, this.y);
      };

      return Bird;

    })();
    game = new Game();
    img = new Image();
    img.src = 'public/img/bird.jpg';
    return img.onload = function() {
      console.log("image finished loading, starting game");
      game.start();
      return main();
    };
  };

}).call(this);