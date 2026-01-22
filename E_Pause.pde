void pause() {
  fill(aqua);
  noStroke();
  rect(70, 250, 460, 100);
  fill(blue);
  PFont font;
  font = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  textFont(font, 100);
  textAlign(CENTER, CENTER);
  text("GAME PAUSED", width/2, height/2);
}

void pauseClicks() {
  if (mouseX > 70 && mouseX < 530 && mouseY > 250 && mouseY < 350) {
    mode = GAME;
  }
}
