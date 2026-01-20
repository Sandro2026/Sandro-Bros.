class FPlasmaBall extends FGameObject {

  FPlasmaBall(float x, float y, int direction) {
    super(8, 8);
    setPosition(x + direction * 20, y); 
    setName("plasmaPower");
    attachImage(plasmaBall); 
    setSensor(true);
    setRestitution(0);

    float speedX = 600 * direction;
    setVelocity(speedX, 0);
  }

  void act() {
    if (getX() < -50 || getX() > width + 50) {
      world.remove(this);
      powerUps.remove(this);
    }

    for (int i = enemies.size()-1; i >= 0; i--) {
      FGameObject e = enemies.get(i);
      if (isTouching(e.getName()) && !e.getName().equals("thwomp")) {
        world.remove(e);
        enemies.remove(e);
        world.remove(this);
        powerUps.remove(this);
        break;
      }
    }
  }
}
