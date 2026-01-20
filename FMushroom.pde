class FMushroom extends FGameObject {

  int direction = 1;
  float speed = 80;

  FMushroom(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("mushroom");
    attachImage(mushroom);
    setSensor(false);
    setRestitution(0);
  }

  void act() {
    setVelocity(speed * direction, getVelocityY());

    if (isTouching("wall")) {
      direction *= -1;
      setVelocity(speed * direction, getVelocityY());
    }
    
    if (getY() > height + 100) {
      world.remove(this);
      powerUps.remove(this);
    }
  }
}
