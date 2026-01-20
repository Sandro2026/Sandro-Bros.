class FThwomp extends FGameObject {

  int mode = 0; 
  float sensor = gridSize / 2;
  float startX, startY;
  float riseSpeed = -1;
  float fallSpeed = 0; 

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
    updateMode();
    collidePlayer();
  }
  void animate() {
    if (mode == 1) attachImage(thwomp[1]); 
    else attachImage(thwomp[0]);         
  }
  void updateMode() {
    float px = player.getX();
    float py = player.getY();
    switch(mode) {
      case 0:
        boolean under = abs(px - getX()) < sensor && py > getY();
        if (under) {
          mode = 1;
          setStatic(false);
        }
        break;
      case 1:
        if (touchingGround()) {
          mode = 2;   
          setStatic(true);
        }
        break;
      case 2:
        float newY = getY() + riseSpeed;
        if (newY <= startY) {
          newY = startY;
          mode = 0;
        }
        setPosition(getX(), newY);
        break;
    }
  }
  boolean touchingGround() {
    return isTouching("stone") || isTouching("ice") || isTouching("wall") ||
           isTouching("bridge") || isTouching("spring") || isTouching("treetop");
  }
  void collidePlayer() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(0, 0);
    }
  }
}
