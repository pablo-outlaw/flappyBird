import processing.sound.*;

SoundFile wing;
SoundFile point;
SoundFile die;
PImage bird;
PImage cevka;
PImage cevkaObrnuta;
PImage bg;
float x;
float y;
float pomeraj;
float pomeraj2;
float pomeraj3;
float visinaPrvogStuba;
float visinaDrugogStuba;
float visinaTrecegStuba;
float sirinaStuba;
PFont score;
int counter;
PrintWriter hiScore;
float padanje;
BufferedReader reader;
int highscore;
boolean end = false;
boolean intro = true;
//CREATED BY: pablo-outlaw
void setup() {

  //fullScreen();
  size(600, 800);
  parseFile();
  
  bird = loadImage("flappyTest1.png");
  cevka = loadImage("cevka.png");
  cevkaObrnuta = loadImage("cevkaObrnuta.png");
  bg = loadImage("background.png");
  
  x = width/5;
  y = height/2;
  pomeraj = width  +175;
  pomeraj2 = width + 550;
  pomeraj3 = width +925;

  visinaPrvogStuba = random(600) +100;
  visinaDrugogStuba = random(600) +100;
  visinaTrecegStuba =random(600) +100;
  sirinaStuba = 100;
  
  score = createFont("Arial", 50, true);
  wing = new SoundFile(this, "wing.mp3");
  die = new SoundFile(this, "die.mp3");
  point = new SoundFile(this, "point.mp3");
}

void draw() {

  background(bg);
  textAlign(CENTER);

  image(bird, x, y, 100, 100);


  image(cevkaObrnuta, pomeraj, 0, sirinaStuba, visinaPrvogStuba -100);
  image(cevka, pomeraj, visinaPrvogStuba + 100, sirinaStuba, 800);

  image(cevkaObrnuta, pomeraj2, 0, sirinaStuba, visinaDrugogStuba -100);
  image(cevka, pomeraj2, visinaDrugogStuba +100, sirinaStuba, 800 );

  image(cevkaObrnuta, pomeraj3, 0, sirinaStuba, visinaTrecegStuba -100);
  image(cevka, pomeraj3, visinaTrecegStuba +100, sirinaStuba, 800 );


  if (end) {
    drag();
    kretanje();
  }

  sudarSaCevkom(pomeraj, visinaPrvogStuba -100, visinaPrvogStuba +100);
  sudarSaCevkom(pomeraj2, visinaDrugogStuba -100, visinaDrugogStuba +100);
  sudarSaCevkom(pomeraj3, visinaTrecegStuba- 100, visinaTrecegStuba +100);

  if (x> pomeraj && pomeraj >= 118) {
    counter ++;
    point.play();
  } 
  if (x> pomeraj2 && pomeraj2 >= 118) {
    counter ++;
    point.play();
  }
  if (x >pomeraj3 && pomeraj3 >= 118) {
    counter ++;
    point.play();
  }

  if (x > pomeraj+ 160 + x) {

    pomeraj = width+ 400;

    visinaPrvogStuba = random(600) +100;
    image(cevkaObrnuta, pomeraj, 0, sirinaStuba, visinaPrvogStuba -100);
    image(cevka, pomeraj, visinaPrvogStuba + 100, sirinaStuba, 800);
  } 
  if (x > pomeraj2+ 160 + x) {
   
    pomeraj2 = width+ 400;

    visinaDrugogStuba = random(600) +100;
    image(cevkaObrnuta, pomeraj2, 0, sirinaStuba, visinaDrugogStuba -100);
    image(cevka, pomeraj2, visinaDrugogStuba +100, sirinaStuba, 800 );
  } 
  if (x > pomeraj3+ 160 + x) {

    pomeraj3 = width+ 400;

    visinaTrecegStuba =random(600) +100;
    image(cevkaObrnuta, pomeraj3, 0, sirinaStuba, visinaTrecegStuba -100);
    image(cevka, pomeraj3, visinaTrecegStuba +100, sirinaStuba, 800 );
  } 

  fill(0);
  textFont(score, 50); 
  text(counter, width/2, 50);

  if (y >= height) {
    setup();
    die.play();
    end = false;
  }
  updateHighscore();
  text("Highscore: "+ highscore, width/2, height - 50);
  if (end) {
  } else {
    rect(150, 100, 300, 50);
    rect(150, 200, 300, 50);
    fill(255);
    if (intro) {
      text("Flappy Bird", 300, 140);
      text("Click to Play", 300, 240);
    } else {
      text("Game Over", 300, 140);
      text("Score:", 290, 240);
      text(counter, 400, 240);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    padanje = -10;
    wing.play();
    intro=false;
    if (end==false) {
      mouseClicked();
    }
  }
}

void mouseClicked() {
  end=true;
  setup();
  counter = 0;
}
void sudarSaCevkom(float pomeraj, float visinaStuba1, float visinaStuba2) {
  if ((x >= pomeraj -100  && x <= pomeraj +100) && ((y >= 0 && y <= visinaStuba1 -35 || y >= visinaStuba2 -35) || (y<0))) {

    updateHighscore();
    die.play();
    end=false;
    setup();
  }
}
void drag() {
  padanje+=0.4;
}
void kretanje() {
  y+=padanje;
  pomeraj-=3;
  pomeraj2-=3;
  pomeraj3-=3;
}
void parseFile() {

  reader = createReader("hiScore.txt");
  if (reader == null) {
    highscore = 0;
    return;
  }
  String line;
  try {
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line != null) {
    highscore = int(line);
  }
  try {
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 
void updateHighscore() {
  if ( counter > highscore) {
    hiScore = createWriter("hiScore.txt");
    highscore = counter;
    hiScore.println(highscore);

    hiScore.close();
  }
}
