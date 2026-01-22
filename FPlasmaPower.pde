class FPlasmaPower extends FGameObject {
  FPlasmaPower(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("pwrUpPlasma");
    setSensor(true);
    attachImage(pwrUpPlasma);
  }
}
