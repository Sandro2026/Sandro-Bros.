import fisica.*;
FWorld world;

final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEWIN = 3;
final int GAMEOVER = 4;

int mode;


color white  = #FFFFFF;
color black  = #000000;
color cyan   = color(153, 217, 234);
color green  = color(34, 177, 76);
color brown  = color(185, 122, 87);
color red    = #FF0000;
color blue   = #0000FF;
color orange = color(255, 127, 39);
color grey   = color(195, 195, 195);
color purple = color(163, 73, 164);
color pink   = color(255, 174, 201);
color yellow = color(255, 236, 59);
color magenta  = color(204, 0, 184);
color aqua = color(47, 255, 234);
color midnight = color(39, 52, 95);

PImage wall, map, ice, stone, treeTrunk, spring, spike, treeIntersect, treeMiddle, treeEndEast, treeEndWest, bridge, nightsky;

PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] lava;
PImage[] thwomp;
PImage[] hammerbro;
PImage[] hammer;


int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, spacekey, dkey, qkey, ekey;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

void setup() {
  size(600, 600);
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadImages();
  loadWorld(map);
  loadPlayer();
}
void loadImages() {
  map = loadImage("map.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice.resize(32, 32);
  stone = loadImage("brick.png");
  spring = loadImage("spring.png");
  spike = loadImage("spike.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeMiddle = loadImage("treetop_center.png");
  treeEndEast = loadImage("treetop_e.png");
  treeEndWest = loadImage("treetop_w.png");
  bridge = loadImage("bridge_center.png");
  wall = loadImage("wall.png");
  wall.resize(32, 32);
  nightsky = loadImage("background.png");
  nightsky.resize(600, 600);

  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  action = idle;

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);
  
  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[0].resize(gridSize, gridSize);
  lava[1] = loadImage("lava1.png");
  lava[1].resize(gridSize, gridSize);
  lava[2] = loadImage("lava2.png");
  lava[2].resize(gridSize, gridSize);
  lava[3] = loadImage("lava3.png");
  lava[3].resize(gridSize, gridSize);
  lava[4] = loadImage("lava4.png");
  lava[4].resize(gridSize, gridSize);
  lava[5] = loadImage("lava5.png");
  lava[5].resize(gridSize, gridSize);
  
  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");
  
  hammer = new PImage[1];
  hammer[0] = loadImage("hammer.png");
  
}

void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 10000, 10000);
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);   //color of current pixel
      color s = img.get(x, y+1); //color below current pixel
      color w = img.get(x-1, y); //color west of current pixel
      color e = img.get(x+1, y); //color east of current pixel
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {
        b.attachImage(stone);
        b.setFriction(4);
        b.setName("stone");
        world.add(b);
      } else if (c == magenta) {
        b.setFriction(4);
        b.attachImage(wall);
        b.setName("wall");
        world.add(b);
      } else if (c == cyan) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      } else if ( c == green && s == brown) {
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      } else if ( c == green && w == green & e == green) {
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      } else if ( c == green && w != green) {
        b.attachImage(treeEndWest);
        b.setName("treetop");
        world.add(b);
      } else if ( c == green && e != green) {
        b.attachImage(treeEndEast);
        b.setName("treetop");
        world.add(b);
      } else if (c == brown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("tree trunk");
        world.add(b);
      } else if (c == grey) {
        b.attachImage(spring);
        b.setRestitution(2);
        b.setName("spring");
        world.add(b);
      } else if (c == purple) {
        b.attachImage(spike);
        b.setRestitution(2);
        b.setName("spike");
        world.add(b);
      } else if (c == pink) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
     } else if (c == orange) {
       FLava lva = new FLava(x*gridSize, y*gridSize);
       terrain.add(lva);
       world.add(lva);
     } else if ( c == aqua) {
       FThwomp thmp = new FThwomp(x*gridSize, y*gridSize);
       enemies.add(thmp);
       world.add(thmp);
     } else if ( c == midnight) {
      FHammerbro hmm = new FHammerbro(x*gridSize, y*gridSize);
      enemies.add(hmm);
      world.add(hmm);
     }
    }
  }
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
 if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEWIN) {
    gameWin();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else {
    println("Error, mode is" + mode);
  }
}

void actWorld () {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
