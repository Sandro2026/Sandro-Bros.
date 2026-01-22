class FIceBall extends FGameObject {

  float startX;
  float maxDistance = 6000;
  
  FIceBall(float x, float y, int direction) {
    super(8, 8);
    setPosition(x+direction*20, y); 
    setName("iceCube");
    attachImage(iceCube);
    setSensor(true);
    setRestitution(0);

    float speedX = 400*direction;
    setVelocity(speedX, 0);
  }

  void act() {
    if (abs(getX()-startX) > maxDistance) {
      world.remove(this);
      powerUps.remove(this);
    }
    for (int i = enemies.size()-1; i >= 0; i--) {
      FGameObject e = enemies.get(i);
      if (e.getName().equals("thwomp")) continue;
      if (isTouching(e.getName())) {
        world.remove(e);
        enemies.remove(e);
        world.remove(this);
        powerUps.remove(this);
        break;
      }
    }
  }
}
