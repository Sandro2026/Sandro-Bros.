class FThwomp extends FGameObject {

  int mode;
  float startX, startY;
  float speedDown = 4;
  float speedUp = 4;
  float sensorRange;
  FThwomp(float x, float y) {
    super(gridSize, thwomp[0].height);
    startX = x;
    startY = y;
    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    attachImage(thwomp[0]);
    mode = 0;
    sensorRange = gridSize/2;
  }

  void act() {
    animate();
    thwompMode();
    collide();
  }

  void thwompMode() {
    if (mode == 0) {
      float px = player.getX();
      float py = player.getY();
      boolean below = abs(px-getX()) < sensorRange && py > getY();
      if (below) {
        mode = 1;
        setStatic(false);
      }
    } else if (mode == 1) {
      setPosition(getX(), getY()+speedDown);
      if (touchingGround()) {
        setVelocity(0, 0);
        setStatic(true);
        mode = 2;
      }
    } else if (mode == 2) {
      setPosition(getX(), getY()-speedUp);
      if (getY() <= startY) {
        setPosition(startX, startY);
        mode = 0;
      }
    }
  }
  void animate() {
    if (mode == 1) attachImage(thwomp[1]);
    else attachImage(thwomp[0]);
  }
  boolean touchingGround() {
    return isTouching("stone") || isTouching("ice") || isTouching("wall") || isTouching("bridge") || isTouching("spring") || isTouching("treetop");
  }
  void collide() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(player.spawnX, player.spawnY);
    }
  }
}
