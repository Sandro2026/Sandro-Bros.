void game() {
  background(nightsky);
  drawWorld();
  actWorld();
  player.act();
  pauseButton();
}

void gameClicks() {
   if (dist(18, 18, mouseX, mouseY) < 10) {
    mode = PAUSE;
  }
}

void pauseButton() {
  fill(white);
  stroke(black);
  rect(17, 18, 3, 10, 5);
  rect(23, 18, 3, 10, 5);
}
