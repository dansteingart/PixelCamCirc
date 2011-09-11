import processing.video.*;


PFont font; 


String message = "";
Capture camera;
boolean fresh;
int togmess = 1;
int i = 0;
int j = 0;
int alph = 126;
int multiple = 20;
int strokeO = 1;
int bitshift = 4;
int messalpha = 0;
void setup()
{
  //To use another webcam uncomment and examine console for proper string
  //println(Capture.list();

  size(640, 480);


  font = loadFont("AlBayan-48.vlw");   
  String s = "USB Video Class Video";
  camera = new Capture(this, width, height, 30);
  frameRate(30);
  //smooth();
}

void captureEvent(Capture camera)
{
  camera.read();
}

void draw()
{ 

  if (multiple < 200)
  {
    //image(camera,0,0);
    background(255);
    simplePixel();
    if (fresh)
    {
      fresh = false;
      messalpha = 250;
    }
    else messalpha = messalpha - 10;
    if (messalpha < 0) messalpha = 0;

    if (togmess == 1)
    {
      textFont(font, (height/240)*25); 
      textAlign(CENTER);
      fill(50, messalpha);
      text(message, width/2, height/2);
    }
  }  
  else
  {
    image(camera, 0, 0);
  }
}

void simplePixel()
{
  float ratio = 3/2;
  int xmul = 640/multiple;
  int ymul = 480/multiple;
  for (int i = 0; i < xmul; i ++)
  {
    for (int j = 0; j < ymul; j++)
    {
      int loc = (width/xmul)*(i+i+1)/2+camera.width*((height/ymul)*(j+j+1)/2);
      float r = red(camera.pixels[loc]);
      int rN = (int)r >> bitshift ;

      float g = green(camera.pixels[loc]);
      int gN = (int) g  >>  bitshift;
      float b = blue(camera.pixels[loc]);
      int bN = (int) b >> bitshift;
      fill(rN << bitshift, gN << bitshift, bN << bitshift, alph);
      if (strokeO == -1) noStroke();
      else stroke(0);
      noStroke();
      smooth();
      ellipseMode(CORNER);
      ellipse(i*width/xmul, j*height/ymul, .8*width/xmul, .8*height/(ymul));
    }
  }
}


void keyPressed() 
{

  if (key == 'u') 
  {
    alph++;
    if (alph > 255) alph = 255;   
    message = "more opaque";
    fresh = true;
  }
  if (key == 'd') 
  {
    alph--;  
    if (alph < 0) alph = 0;
    message = "more transparent";
    fresh = true;
  }
  if (key == 'q') 
  {
    bitshift++;
    if (bitshift > 7) bitshift = 7;
    message = String.valueOf(8-bitshift)+" bits/channel";
    fresh = true;
  }
  if (key == 'w')
  {
    bitshift--;
    if (bitshift < 0) bitshift = 0;
    message = String.valueOf(8-bitshift)+" bits/channel";
    fresh = true;
  }

  if (key == '1') multiple = 10;
  if (key == '2') multiple = 20;
  if (key == '3') multiple = 40;
  if (key == '4') multiple = 80;
  if (key == '5') multiple = 120;  
  if (key == '6') multiple = 32;  
  if (key == '7') multiple = 40; 
  if (key == '8') multiple = 80;
  if (key == '9') multiple = 160; 
  if (key == '0') multiple = 201;
  if (key == 'b') 
  {
    strokeO = -1* strokeO;  
    println(strokeO);
    message = "border toggle";
    fresh = true;
  }  
  if (key == '+') multiple=multiple+2;
  if (key == '-') multiple=multiple-2;
  if (key == 'm') 
  {
    togmess = -1*togmess;
    message = "messages on";
    fresh = true;
  }
}

