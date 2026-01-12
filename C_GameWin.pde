void gameWin() {
  background(black);
  textAlign(CENTER, CENTER);
  fill(orange);
  text("GAME WIN", width/2, height/2);
}

void gameWinClicks() {
  mode = INTRO;
  setup();
}
