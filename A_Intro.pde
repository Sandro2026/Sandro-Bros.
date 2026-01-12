void intro() {
  background(0);
  fill(orange);
  PFont font;
  font = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  textFont(font, 100);
  textAlign(CENTER, CENTER);
  text("Sandro Bros.", width/2, height/2);
}

void introClicks() {
  mode = GAME;
}
