class FMushroom extends FGameObject {

  int direction = 1;
  float speed = 80;

  FMushroom(float x, float y) {
    super();
    setPosition(x, y);
    setName("mushroom");
    attachImage(mushroom);
  }

  void act() {
    setVelocity(speed*direction, getVelocityY());

    if (isTouching("wall")) {
      direction *= -1;
      setVelocity(speed*direction, getVelocityY());
    }
  }
}
