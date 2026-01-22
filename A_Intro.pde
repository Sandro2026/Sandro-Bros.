void intro() {
  background(0);
  image(IntroGif, 150, 270, 300, 400);
  fill(aqua);
  noStroke();
  rect(70, 250, 460, 100);
  fill(blue);
  PFont font;
  font = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  textFont(font, 100);
  textAlign(CENTER, CENTER);
  text("Sandro Bros.", width/2, height/2);
}

void introClicks() {
  if (mouseX > 70 && mouseX < 530 && mouseY > 250 && mouseY < 350) {
    mode = GAME;
  }
}
