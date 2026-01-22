class FPortal extends FGameObject {

  FPortal(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("FPortals");
    setStatic(true);
  }
}
