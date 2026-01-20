class FPowerUp extends FGameObject {

    FPowerUp(float x, float y) {
        super(gridSize, gridSize);
        setPosition(x, y);
        setName("powerUpIce");
        attachImage(pwrUp);
        setSensor(true);
    }

    void act() {
    }
}
