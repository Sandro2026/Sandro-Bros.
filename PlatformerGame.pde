import gifAnimation.*;

import processing.sound.*;

import fisica.*;

FWorld world;

SoundFile music;
int lastMode = -1;

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
color midnight = color(0, 2, 61);
color lavender = color(255, 155, 222);
color beige = color(142, 64, 58);
color mush = color(142, 130, 92);
color port = color(52, 255, 165);
color portE = color(187, 255, 0);
color lilB = color(121, 152, 0);
color dirtColor = color(129, 86, 0);
color dblue = color(22, 165, 219);
color flag = color(118, 117, 116);

FPortal prtlI;
FPortalE prtlE;



PImage flagTop, flagUnderTop, flagCenter, flagBottom, wall, map, ice, stone, treeTrunk, portal, portalExit, spring, spike, treeIntersect, treeMiddle, treeEndEast, treeEndWest, bridge, nightsky, shell, luckyB, savePB;
PImage dirt_center, dirt_n, dirt_e, dirt_s, dirt_w, dirt_ne, dirt_nw, dirt_se, dirt_sw, pwrUp, iceCube, plasmaBall, pwrUpPlasma, mushroom;
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] koopa;
//PImage[] shell;
PImage[] lava;
PImage[] thwomp;
PImage[] hammerbro;
PImage[] hammer;
PImage[] water;


int gridSize = 32;
float zoom = 1.5;
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, spacekey, dkey, qkey, ekey;
FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
ArrayList<FGameObject> powerUps;

Gif IntroGif, GameWinGif, GameOverGif;

void setup() {
  size(600, 600);
  Fisica.init(this);

  music = new SoundFile(this, "music.mp3");

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  powerUps = new ArrayList<FGameObject>();
  loadImages();
  loadWorld(map);
  loadPlayer();


   IntroGif = new Gif(this, "IntroGif.gif");
   IntroGif.loop();
   
   GameWinGif = new Gif(this, "GameWinGif.gif");
   GameWinGif.loop();
   
   GameOverGif = new Gif(this, "GameOverGif.gif");
   GameOverGif.loop();
   
}
void loadImages() {
  flagTop = loadImage("flagTop.png");
  flagTop.resize(32, 32);
  flagUnderTop = loadImage("flagUnderTop.png");
  flagUnderTop.resize(32, 32);
  flagCenter = loadImage("flagCenter.png");  
  flagCenter.resize(32, 32);
  flagBottom = loadImage("flagBottom.png");  
  flagBottom.resize(32, 32);
  dirt_center = loadImage("dirt_center.png");
  dirt_n = loadImage("dirt_n.png");
  dirt_ne = loadImage("dirt_ne.png");
  dirt_nw = loadImage("dirt_nw.png");
  dirt_s = loadImage("dirt_s.png");
  dirt_se = loadImage("dirt_se.png");
  dirt_sw = loadImage("dirt_sw.png");
  dirt_e = loadImage("dirt_e.png");
  dirt_w = loadImage("dirt_w.png");

  savePB = loadImage("LilBuddy.png");
  portal = loadImage("portal.png");
  portalExit = loadImage("portalExit.png");
  mushroom = loadImage("mushroom.png");
  mushroom.resize(32, 32);
  plasmaBall = loadImage("plasmaBall.png");
  plasmaBall.resize(32, 32);
  pwrUpPlasma = loadImage("pwrUpPlasma.png");
  pwrUpPlasma.resize(32, 32);
  iceCube = loadImage("icube.png");
  iceCube.resize(32, 32);
  pwrUp = loadImage("pwrUp.png");
  pwrUp.resize(32, 32);
  luckyB = loadImage("luckyB.png");
  luckyB.resize(32, 32);
  map = loadImage("map.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice.resize(32, 32);
  stone = loadImage("brick.png");
  spring = loadImage("spring2.png");
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

  water = new PImage[4];
  water[0] = loadImage("water1.png");
  water[0].resize(gridSize, gridSize);
  water[1] = loadImage("water3.png");
  water[1].resize(gridSize, gridSize);
  water[2] = loadImage("water3.png");
  water[2].resize(gridSize, gridSize);
  water[3] = loadImage("water4.png");
  water[3].resize(gridSize, gridSize);


  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");

  hammer = new PImage[1];
  hammer[0] = loadImage("hammer.png");

  koopa = new PImage[2];
  koopa[0] = loadImage("koopa0.png");
  koopa[0].resize(gridSize, gridSize);
  koopa[1] = loadImage("koopa1.png");
  koopa[1].resize(gridSize, gridSize);


  shell = loadImage("shell.png");
  shell.resize(32, 32);
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
      color n = img.get(x, y-1); //color north of current pixel
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
      } else if (c == flag && n != flag) {
        b.attachImage(flagTop);
        b.setSensor(true);
        b.setName("flagPole");
        world.add(b);
      } else if (c == flag && n == flag && img.get(x, y-2) != flag) {
        b.attachImage(flagUnderTop);
        b.setSensor(true);
        b.setName("flagPole");
        world.add(b);
      } else if (c == flag && n == flag && s == flag) {
        b.attachImage(flagCenter);
        b.setSensor(true);
        b.setName("flagPole");
        world.add(b);
      } else if (c == flag && s != flag) {
        b.attachImage(flagBottom);
        b.setSensor(true);
        b.setName("flagPole");
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
      } else if (c == dblue) {
        FWater wtr = new FWater(x*gridSize, y*gridSize);
        wtr.setSensor(true);
        terrain.add(wtr);
        world.add(wtr);
      } else if ( c == aqua) {
        FThwomp thmp = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(thmp);
        world.add(thmp);
      } else if ( c == midnight) {
        FHammerbro hmm = new FHammerbro(x*gridSize, y*gridSize);
        enemies.add(hmm);
        world.add(hmm);
      } else if ( c == lavender) {
        FKoopa kpa = new FKoopa(x*gridSize, y*gridSize);
        enemies.add(kpa);
        world.add(kpa);
      } else if ( c == beige) {
        FLuckyBlock Lky = new FLuckyBlock(x*gridSize, y*gridSize);
        terrain.add(Lky);
        world.add(Lky);
      } else if ( c == mush) {
        FMushroom mush = new FMushroom(x*gridSize, y*gridSize);
        powerUps.add(mush);
        world.add(mush);
      } else if ( c == port) {
        prtlI = new FPortal(x*gridSize, y*gridSize);
        terrain.add(prtlI);
        prtlI.attachImage(portal);
        prtlI.setFriction(5);
        prtlI.setName("FPortals");
        world.add(prtlI);
      } else if (c == portE) {
        prtlE = new FPortalE(x*gridSize, y*gridSize);
        terrain.add(prtlE);
        prtlE.attachImage(portalExit);
        prtlE.setFriction(6);
        prtlE.setName("FPortalE");
        world.add(prtlE);
      } else if (c == lilB) {
        FCheckpoint cp = new FCheckpoint(x*gridSize, y*gridSize);
        terrain.add(cp);
        world.add(cp);
      } else if (c == dirtColor && n != dirtColor && w != dirtColor) {
        b.attachImage(dirt_nw);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      } else if (c == dirtColor && n != dirtColor && e != dirtColor) {
        b.attachImage(dirt_ne);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      } else if (c == dirtColor && n != dirtColor) {
        b.attachImage(dirt_n);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      } else if (c == dirtColor && w == dirtColor && e == dirtColor) {
        b.attachImage(dirt_center);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      } else if (c == dirtColor && w != dirtColor) {
        b.attachImage(dirt_w);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      } else if (c == dirtColor && e != dirtColor) {
        b.attachImage(dirt_e);
        b.setFriction(4);
        b.setName("dirt");
        world.add(b);
      }
    }
  }
}

void spawnIceBall(float x, float y, int dir) {
  FIceBall iceCube = new FIceBall(x, y, dir);
  world.add(iceCube);
  powerUps.add(iceCube);
}
void spawnPlasmaBall(float x, float y, int dir) {
  FPlasmaBall plasmaBall = new FPlasmaBall(x, y, dir);
  world.add(plasmaBall);
  powerUps.add(plasmaBall);
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
  for (int i = 0; i < powerUps.size(); i++) {
    FGameObject p = powerUps.get(i);
    p.act();
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
