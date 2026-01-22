void gameOver() {
  background(black);
  image(GameOverGif, 150, 375, 300, 250);
  fill(aqua);
  noStroke();
  rect(70, 250, 460, 100);
  fill(blue);
  PFont font;
  font = loadFont("BerlinSansFBDemi-Bold-48.vlw");
  textFont(font, 100);
  textAlign(CENTER, CENTER);
  text("GAMEOVER", width/2, height/2);
}

void gameOverClicks() {
  player.spawnX = player.ogSpawnX;
  player.spawnY = player.ogSpawnY;
  player.setPosition(player.spawnX, player.spawnY);
  player.setVelocity(0, 0);
  if (mouseX > 70 && mouseX < 530 && mouseY > 250 && mouseY < 350) {
    mode = INTRO;
    setup();
  }
}
