void gameOver() {
    background(black);
  textAlign(CENTER, CENTER);
  fill(orange);
  text("GAME OVER", width/2, height/2);
}

void gameOverClicks() {
  mode = INTRO;
  setup();
}
