import { Actor, CollisionType, Color, DisplayMode, Engine, vec } from "excalibur";

const game = new Engine({
  width: 600,
  height: 400,
  displayMode: DisplayMode.FitScreen,
})

const paddle = new Actor({
  x: 150,
  y: game.drawHeight - 40,
  width: 200,
  height: 20,
  color: Color.Chartreuse
})

paddle.body.collisionType = CollisionType.Fixed
game.add(paddle);

const ball = new Actor({
  x: 100,
  y: 300,
  radius: 10,
  color: Color.Red,
})

setTimeout(() => {
  ball.vel = vec(100, 100);
}, 1000);

ball.body.collisionType = CollisionType.Passive
ball.on("postupdate", () => {
  if (ball.pos.x < ball.width / 2) {
    ball.vel.x *= -1;
  }

  if (ball.pos.x + ball.width / 2 > game.drawWidth) {
    ball.vel.x *= -1;
  }

  if (ball.pos.y < ball.height / 2) {
    ball.vel.y *= -1;
  }
});
game.add(ball)

game.input.pointers.primary.on("move", (event) => {
  paddle.pos.x = event.worldPos.x;
})
game.start()
