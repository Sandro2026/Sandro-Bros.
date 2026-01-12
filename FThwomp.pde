class FThwomp extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  
  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    
    
  }
  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    if (frame >= thwomp.length) frame = 0;
    if (frameCount % 25 == 0) {
      if (direction == R) attachImage(thwomp[frame]);
      if (direction == L) attachImage(thwomp[frame]);
      frame++;
    }
  }

  void collide() {
    if (isTouching("player")) {
        player.lives--;
        player.setPosition(0, 0);
      }
    }

  void move() {
  //  float vy = getVelocityY();
  //  setVelocity(speed*direction, vy);
  }
}
