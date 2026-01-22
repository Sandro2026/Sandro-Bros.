void gameWin() {
  background(black);
  image(GameWinGif, 150, 340, 300, 270);
  fill(aqua);
  noStroke();
  rect(70, 250, 460, 100);
  fill(blue);
  PFont font;
  font = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  textFont(font, 100);
  textAlign(CENTER, CENTER);
  text("GAMEWIN", width/2, height/2);
}

void gameWinClicks() {
  if (mouseX > 70 && mouseX < 530 && mouseY > 250 && mouseY < 350) {
    mode = INTRO;
    setup();
  }
}
