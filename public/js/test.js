// Generated by CoffeeScript 1.7.1
(function() {
  var Looper, l;

  Looper = (function() {
    function Looper() {
      this.message = "Heyo";
    }

    Looper.prototype.loop = function() {
      var toLoop;
      toLoop = (function(_this) {
        return function() {
          return _this.loop();
        };
      })(this);
      setTimeout(toLoop, 100);
      return console.log(this.message + " there!");
    };

    return Looper;

  })();

  l = new Looper();

  l.loop();

}).call(this);
