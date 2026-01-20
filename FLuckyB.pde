class FLuckyBlock extends FGameObject {

  boolean activated = false;

  FLuckyBlock(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("luckyBlock");
    setStatic(true);
    attachImage(luckyB);
  }
  void act() {
    if (activated) return;
    ArrayList<FContact> contacts = player.headSensor.getContacts();
    for (FContact c : contacts) {
      if (c.contains(this)) {
        spawnPowerUp();
        activated = true;
        return;
      }
    }
  }

  void spawnPowerUp() {
    if (random(1) < 0.5) {
      // Thus is for my ice power up I need to remeber
      FPowerUp ice = new FPowerUp(getX(), getY() - gridSize);
      world.add(ice);
      powerUps.add(ice);
    } else {
      // plasma
      FPlasmaPower plasma = new FPlasmaPower(getX(), getY() - gridSize);
      world.add(plasma);
      powerUps.add(plasma);
    }
  }
}
