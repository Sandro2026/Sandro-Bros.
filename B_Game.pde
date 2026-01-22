void game() {
  background(nightsky);
  drawWorld();
  actWorld();
  player.act();
  pauseButton();
  drawLives();
  
  if (mode != lastMode) {
    handleMusic();
    lastMode = mode;
  }
  if (player.lives <= 0) {
    mode = GAMEOVER;
    return;
  }
  if (player.getY() > 6000) {
    player.lives--;
    player.setPosition(player.spawnX, player.spawnY);
    player.setVelocity(0, 0);
  }
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

void drawLives() {
  fill(white);
  textAlign(LEFT, TOP);
  textSize(20);
  text("Lives: "+player.lives, 20, 50);
}


void handleMusic() {
  if (music == null) return;
  
  music.stop();
  if(mode == GAME) {
    music.loop();
  }
}
