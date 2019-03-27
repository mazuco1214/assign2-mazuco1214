final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_OVER = 3;
final int TOTAL_LIFE =2;

PImage blueSky , groundHog , life , robot , soil , soldier , title , gameOver, cabbage ;
PImage startHovered , startNormal;
PImage restartHovered , restartNormal;
int gameState;
int Life;

float soldierWalk_X = 0;
float soldierWalk_Y ;
float soldierPlace=int(random(2,6));
float soldierX;
float soldierY;
float groundHogX;
float groundHogY;
float groundHogW = 80;
float groundHogH = 80;
float cabbageX=int(random(0,8))*80;
float cabbageY=int(random(2,6))*80;

void setup() {
  size(640, 480, P2D);
  colorMode(RGB);
  blueSky = loadImage("img/bg.jpg");
  groundHog = loadImage("img/groundhogIdle.png");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  title = loadImage("img/title.jpg");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  gameOver = loadImage("img/gameover.jpg");
  cabbage = loadImage("img/cabbage.png");

  imageMode(CORNERS);

  groundHogX = 320;
  groundHogY = 80;
  Life = TOTAL_LIFE ;
}

void draw() {
  
 switch (gameState){
    case GAME_START:
    background(title);
      if (mouseX > 248 && mouseX < 392 && mouseY > 360 && mouseY< 420){
      image(startHovered,248,360);
      if (mousePressed){
          // click
          gameState = GAME_RUN; 
      }
        }else{
         image(startNormal,248,360);
        }
          break;
          
     case GAME_RUN:
     background(blueSky);
     image(soil,0,160);
    
      //grass
     rectMode(CORNERS);
     noStroke();
     fill(124, 204, 25);
     rect(0,145,640,160);
     
     //sun
     fill(253, 184, 19);
     stroke(255,255,0);
     strokeWeight(5);
     ellipse(590,50,120,120);
     
     //soldier's place and walk
     image(soldier,soldierWalk_X-80,soldierWalk_Y);
     soldierWalk_Y=soldierPlace*80;
     soldierWalk_X +=5;
     soldierWalk_X %=720;

     //groundhog

     image(groundHog,groundHogX,groundHogY);

     if(groundHogX >= 640- groundHogW ){
     groundHogX = 640- groundHogW ;
     }
     if(groundHogX <=0 ){
     groundHogX = 0;
     }
     if(groundHogY >= 480- groundHogH ){
     groundHogY = 480- groundHogH ;
     }
  
     if(groundHogX >= soldierWalk_X && groundHogX+80 <= soldierWalk_X+80 && groundHogY >= soldierWalk_Y && groundHogY+80 <= soldierWalk_Y+80){
     Life -=1;
     groundHogY = 80;
     groundHogX = 320;
     }
     image(cabbage,cabbageX,cabbageY);
     if(groundHogX >= cabbageX && groundHogX+80 <= cabbageX+80 && groundHogY >= cabbageY && groundHogY+80 <= cabbageY+80){
     cabbageX = 1000;
     cabbageY = 1000;
     Life +=1;
     }
     if(Life == 3){
    
     image(life,10,10);
     image(life,80,10);
     image(life,150,10);
     }     
     if(Life == 2){
     image(life,10,10);
     image(life,80,10);
     }

     if(Life == 1){
     image(life,10,10);
     }
  
    
     if(Life <= 0){
     gameState = GAME_OVER;
     }

       break;
       
    case GAME_OVER:
      background(gameOver);
      if (mouseX > 248 && mouseX < 392 && mouseY > 360 && mouseY< 420){
      image(restartHovered,248,360);
        if(mousePressed){
          gameState = GAME_RUN;
          groundHogY = 80;
          groundHogX = 320;
          Life = 2;
          cabbageX=int(random(0,8))*80;
          cabbageY=int(random(2,6))*80;
        }
      }else{
        image(restartNormal,248,360);
      }
    break;
      
 }
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case DOWN:
         groundHogY += 80;
        break;
      case LEFT:
        groundHogX -= 80;
        break;
      case RIGHT:
        groundHogX += 80;
        break;
    }
  }
}
