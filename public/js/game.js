// Generated by CoffeeScript 1.7.1
(function() {
  var game;

  game = null;

  window.main = function() {
    window.requestAnimationFrame(main);
    return game.tick();
  };

  window.onload = function() {
    var Bird, Game, Key, Pipe, birdSprite, gravity, pipeSprite;
    window.addEventListener('keyup', (function(event) {
      return Key.onKeyup(event);
    }), false);
    window.addEventListener('keydown', (function(event) {
      return Key.onKeydown(event);
    }), false);
    gravity = 0.1;
    Game = (function() {
      function Game() {}

      Game.prototype.start = function() {
        this.bird = new Bird(birdSprite);
        this.pipes = [];
        this.width = 600;
        this.height = 400;
        this.pipeSpawnTime = 200;
        return this.timeToPipeSpawn = 0;
      };

      Game.prototype.tick = function() {
        this.update();
        return this.draw();
      };

      Game.prototype.update = function() {
        var pipe, _i, _len, _ref, _results;
        this.timeToPipeSpawn--;
        if (this.timeToPipeSpawn <= 0) {
          this.spawnPipe();
          this.timeToPipeSpawn = this.pipeSpawnTime;
        }
        this.bird.update();
        this.pipeAt(this.bird.x, this.bird.y);
        _ref = this.pipes;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          pipe = _ref[_i];
          _results.push(pipe.update());
        }
        return _results;
      };

      Game.prototype.draw = function() {
        var ctx, pipe, _i, _len, _ref, _results;
        ctx = document.getElementById('canvas').getContext('2d');
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, this.width, this.height);
        this.bird.draw(ctx);
        _ref = this.pipes;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          pipe = _ref[_i];
          _results.push(pipe.draw(ctx));
        }
        return _results;
      };

      Game.prototype.pipeAt = function(x, y) {
        var pipe, _i, _len, _ref, _results;
        _ref = this.pipes;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          pipe = _ref[_i];
          if ((pipe.x - 24 < x && x < pipe.x + 24) && Math.abs(pipe.y - y) > pipe.gap / 2) {
            _results.push(alert('collision'));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };

      Game.prototype.spawnPipe = function() {
        var pipe;
        console.log("Spawning a pipe");
        pipe = new Pipe();
        pipe.x = this.width;
        pipe.y = 100 + (Math.random() * 200);
        return this.pipes.push(pipe);
      };

      return Game;

    })();
    Bird = (function() {
      function Bird(sprite) {
        this.sprite = sprite;
        this.x = 50;
        this.y = 0;
        this.spriteWidth = sprite.width();
        this.spriteHeight = sprite.height();
        this.vAccel = 0;
        this.flapAccel = -5;
        this.canFlap = true;
      }

      Bird.prototype.update = function() {
        if (Key.isDown(Key.JUMP)) {
          this.flap();
          this.canFlap = false;
        } else {
          this.canFlap = true;
        }
        this.vAccel += gravity;
        return this.y += this.vAccel;
      };

      Bird.prototype.flap = function() {
        if (this.canFlap) {
          console.log("Flap!");
          return this.vAccel = this.flapAccel;
        }
      };

      Bird.prototype.draw = function(ctx) {
        ctx.drawImage(this.sprite, this.x, this.y);
        ctx.fillStyle = 'red';
        return ctx.fillRect(this.x, this.y, 2, 2);
      };

      return Bird;

    })();
    Pipe = (function() {
      function Pipe() {
        this.sprite = pipeSprite;
        this.x = 0;
        this.y = 100;
        this.spiteOffsetX = -25;
        this.spriteOffsetY = -371;
        this.gap = 75;
      }

      Pipe.prototype.update = function() {
        return this.x -= 2;
      };

      Pipe.prototype.draw = function(ctx) {
        ctx.drawImage(this.sprite, this.x + this.spiteOffsetX, this.y + this.spriteOffsetY);
        ctx.fillStyle = 'red';
        return ctx.fillRect(this.x, this.y, 2, 2);
      };

      return Pipe;

    })();
    Key = {
      _pressed: {},
      JUMP: 32,
      isDown: function(keyCode) {
        return this._pressed[keyCode];
      },
      onKeydown: function(event) {
        return this._pressed[event.keyCode] = true;
      },
      onKeyup: function(event) {
        return delete this._pressed[event.keyCode];
      }
    };
    game = new Game();
    birdSprite = new Image();
    birdSprite.src = 'public/img/bird.jpg';
    pipeSprite = new Image();
    pipeSprite.src = 'public/img/pipe2.png';
    return pipeSprite.onload = function() {
      console.log("image finished loading, starting game");
      game.start();
      return main();
    };
  };

}).call(this);
