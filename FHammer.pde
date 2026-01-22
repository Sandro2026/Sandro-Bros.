class FHammer extends FGameObject {

  FHammer(float x, float y, int direction) {
    super(gridSize/2, gridSize/2);
    setPosition(x, y);
    setName("hammer");
    attachImage(hammer[0]);
    setSensor(true);
    setRestitution(0);
    float speedX = 150*direction;
    float speedY = -600;
    setVelocity(speedX, speedY);
  }
  void act() {

    if (getY() > height+100 || getX() < -100 || getX() > width+100) {
      world.remove(this);
    }
  }
}
