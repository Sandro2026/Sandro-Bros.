void pause() {
  background(black);
  textAlign(CENTER, CENTER);
  fill(orange);
  text("GAME PAUSED", width/2, height/2);
}

void pauseClicks() {
  mode = GAME;
}
