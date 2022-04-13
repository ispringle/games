import * as Bacon from 'node_modules/baconjs/dist/Bacon.mjs';

const Game = {
  canvas: {},
  context: {},
  timestamp: 0,
  priorTimestamp: 0,
  width: 512,
  height: 400,
  state: {},
};

// TODO: Figure out how to scale game window based on viewport size
// const getScaleFactor: number = (gameWidth: number, gameHeight: number, windowWidth: number, windowHeight: number) => {
//   diffWidth = windowWidth / gameWidth;
//   diffHeight = windowHeight / gameHeight;
//   return diffWidth < diffHeight ? diffWidth : diffHeight
// }

const init = () => {
  Game.canvas = document.getElementById('game-window');
  Game.canvas.width = Game.width;
  Game.canvas.height = Game.height;
  Game.context = Game.canvas.getContext('2d');
  Game.canvas.style.background = 'blue';
  window.requestAnimationFrame(loop);
}

const loop = timestamp => {
  let elapsed = (Game.timestamp - Game.priorTimestamp) / 1000;
  Game.priorTimestamp = Game.timestamp;
  let dt = Math.min(elapsed, 0.1);

  update(dt);
  clear();
  draw();
  window.requestAnimationFrame(loop)
}

const update = dt => {
  // Updates go here
}

const clear = () => Game.context.clearRect(0, 0, Game.canvas.width, Game.canvas.height);

const draw = () => {
  // Drawing goes here
}

window.addEventListener('load', init)
