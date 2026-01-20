class FThwomp extends FGameObject {

  boolean activated = false;
  boolean waiting = false;

  float sensor = gridSize / 2;
  float startX, startY;

  int waitStart;

  FThwomp(float x, float y) {
    super(gridSize, thwomp[0].height);
    startX = x;
    startY = y;

    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    attachImage(thwomp[0]);
  }

  void act() {
    animate();
    trigger();
    reset();
    collide();
  }

  void animate() {
    if (activated) attachImage(thwomp[1]);
    else attachImage(thwomp[0]);
  }

  void trigger() {
    if (activated) return;

    float px = player.getX();
    float py = player.getY();

    boolean under =
      abs(px - getX()) < sensor &&
      py > getY();

    if (under) {
      activated = true;
      setStatic(false);
    }
  }

  void reset() {
    if (player.getX() == 0 && player.getY() == 0 && activated) {
      activated = false;
      setStatic(true);
      setVelocity(0, 0);
      setPosition(startX, startY);
    }
  }

  void collide() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(0, 0);
    }
  }
}
