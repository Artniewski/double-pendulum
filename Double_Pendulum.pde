
import controlP5.*;
ControlP5 cp5;
float mass1 = 2;
float mass2 = 2;
float r1 = 1;
float r2 = 1;
float deg1 = PI/2;
float deg2 = 3*PI/4;
float g = 9.82;
float deg1_vel = 0;
float deg2_vel = 0;
float previousX2 = -1;
float previousY2 = -1;
boolean isActive = false;
int frames = 0;
color traceColor = color(161, 152, 233);

PGraphics drawPanel;

void setup() {
  frameRate(60);
  size(1300, 800);
  cp5 = new ControlP5(this);
  setupControls();
  drawPanel = createGraphics(width-330, height);
  drawPanel.beginDraw();
  drawPanel.background(255);
  drawPanel.endDraw();
  randomSeed(0);
}

void draw() {
  if (abs(deg2_vel)>10) {
    isActive = false;
  }    
  background(255);
  imageMode(CORNER);
  image(drawPanel, 0, 0, width-330, height);
  if (isActive) {
    float exp1 = -(g/3600) * (2 * mass1 + mass2) * sin(deg1);
    float exp2 = -mass2 * (g/3600) * sin(deg1-2*deg2);
    float exp3 = -2*sin(deg1-deg2)*mass2;
    float exp4 = deg2_vel*deg2_vel*r2+deg1_vel*deg1_vel*r1*cos(deg1-deg2);
    float denominal = r1 * (2*mass1+mass2-mass2*cos(2*deg1-2*deg2));
    float deg1_acc = (exp1 + exp2 + exp3*exp4) / denominal;

    exp1 = 2 * sin(deg1-deg2);
    exp2 = (deg1_vel*deg1_vel*r1*(mass1+mass2));
    exp3 = (g/3600) * (mass1 + mass2) * cos(deg1);
    exp4 = deg2_vel*deg2_vel*r2*mass2*cos(deg1-deg2);
    denominal = r2 * (2*mass1+mass2-mass2*cos(2*deg1-2*deg2));
    float deg2_acc = (exp1*(exp2+exp3+exp4)) / denominal;

    stroke(0);
    strokeWeight(4);
    translate((width-300)/2, 200);

    float x1 = r1 * sin(deg1);
    float y1 = r1 * cos(deg1);

    float x2 = x1+ r2 * sin(deg2);
    float y2 = y1+ r2 * cos(deg2);

    stroke(125);
    line(0, 0, 200*x1, 200*y1);
    line(200*x1, 200*y1, 200*x2, 200*y2);
    fill(0);
    stroke(0);
    ellipse(200*x1, 200*y1, 17*mass1, 17*mass1);
    ellipse(200*x2, 200*y2, 17*mass2, 17*mass2);
    deg1_vel += deg1_acc;
    deg2_vel += deg2_acc;
    deg1 += deg1_vel;
    deg2 += deg2_vel;

    drawPanel.beginDraw();
    drawPanel.translate((width-300)/2, 200);
    drawPanel.stroke(traceColor);
    drawPanel.strokeWeight(2);
    if (frameCount > frames+1) {

      drawPanel.line(200*previousX2, 200*previousY2, 200*x2, 200*y2);
    }
    drawPanel.endDraw();

    previousX2 = x2;
    previousY2 = y2;
    translate(-(width-300)/2, -200);
  } else {
    strokeWeight(4);
    translate((width-300)/2, 200);
    float x1 = r1 * sin(deg1);
    float y1 = r1 * cos(deg1);

    float x2 = x1+ r2 * sin(deg2);
    float y2 = y1+ r2 * cos(deg2);
    stroke(125);
    line(0, 0, 200*x1, 200*y1);
    line(200*x1, 200*y1, 200*x2, 200*y2);
    fill(0);
    stroke(0);
    ellipse(200*x1, 200*y1, 17*mass1, 17*mass1);
    ellipse(200*x2, 200*y2, 17*mass2, 17*mass2);
    translate(-(width-300)/2, -200);
  }
}

void setupControls() {
  cp5.addTextlabel("Options1")
    .setText("Live Options:")
    .setPosition(width-305, 5)
    .setSize(250, 30)
    .setColorValue(0)
    .setFont(createFont("Arial", 20))
    ;
  cp5.addSlider("massSlider1")
    .setBroadcast(false)
    .setPosition(width-300, 50)
    .setSize(250, 30)
    .setRange(0.5, 4)
    .setValue(mass1)
    .setLabel("Mass 1 (kg)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addSlider("massSlider2")
    .setBroadcast(false)
    .setPosition(width-300, 105)
    .setSize(250, 30)
    .setRange(0.5, 4)
    .setValue(mass2)
    .setLabel("Mass 2 (kg)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addSlider("lengthSlider1")
    .setBroadcast(false)
    .setPosition(width-300, 160)
    .setSize(250, 30)
    .setRange(0.5, 1.5)
    .setValue(r1)
    .setLabel("Rod 1 Length (m)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addSlider("lengthSlider2")
    .setBroadcast(false)
    .setPosition(width-300, 215)
    .setSize(250, 30)
    .setRange(0.5, 1.5)
    .setValue(r2)
    .setLabel("Rod 2 Length (m)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addTextlabel("Options2")
    .setText("Paused Options:")
    .setPosition(width-305, 275)
    .setSize(250, 30)
    .setColorValue(0)
    .setFont(createFont("Arial", 20));
  cp5.addSlider("angleSlider1")
    .setBroadcast(false)
    .setPosition(width-300, 325)
    .setSize(250, 30)
    .setRange(0, 2*PI)
    .setValue(deg1)
    .setLabel("Rod 1 starting angle (radians)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addSlider("angleSlider2")
    .setBroadcast(false)
    .setPosition(width-300, 380)
    .setSize(250, 30)
    .setRange(0, 2*PI)
    .setValue(deg2)
    .setLabel("Rod 2 starting angle (radians)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addSlider("gravitySlider")
    .setBroadcast(false)
    .setPosition(width-300, 435)
    .setSize(250, 30)
    .setRange(0.01, 2*9.82 )
    .setValue(g)
    .setLabel("Gravitation (m/s^2)")
    .setSliderMode(Slider.FLEXIBLE)
    .setBroadcast(true)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0).setFont(createFont("Arial", 12)).toUpperCase(false).setColor(0)
    ; 
  cp5.addButton("startButton")
    .setBroadcast(false)
    .setPosition(width-300, 510)
    .setSize(250, 30)
    .setLabel("Start / Stop")
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("clearButton")
    .setBroadcast(false)
    .setPosition(width-300, 560)
    .setSize(250, 30)
    .setLabel("Clear")
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("purpleButton")
    .setBroadcast(false)
    .setPosition(width-300, 600)
    .setSize(35, 35)
    .setLabel("")
    .setColorForeground(color(161, 152, 233))
    .setColorActive(color(141, 132, 213))
    .setColorBackground(color(161, 152, 233))
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("orangeButton")
    .setBroadcast(false)
    .setPosition(width-128, 600)
    .setSize(35, 35)
    .setLabel("")
    .setColorForeground(color(241, 123, 35))
    .setColorActive(color(221, 103, 15))
    .setColorBackground(color(241, 123, 35))
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("goldButton")
    .setBroadcast(false)
    .setPosition(width-174, 600)
    .setSize(35, 35)
    .setLabel("")
    .setColorForeground(color(254, 204, 24))
    .setColorActive(color(234, 184, 4))
    .setColorBackground(color(254, 204, 24))
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("redButton")
    .setBroadcast(false)
    .setPosition(width-85, 600)
    .setSize(35, 35)
    .setLabel("")
    .setColorForeground(color(241, 4, 77))
    .setColorActive(color(221, 4, 57))
    .setColorBackground(color(241, 4, 77))
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("greenButton")
    .setBroadcast(false)
    .setPosition(width-214, 600)
    .setSize(35, 35)
    .setLabel("")
    .setColorForeground(color(67, 255, 117))
    .setColorActive(color(47, 235, 97))
    .setColorBackground(color(67, 255, 117))
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addButton("blueButton")
    .setBroadcast(false)
    .setPosition(width-257, 600)
    .setSize(35, 35)
    .setLabel("")
    .setColorForeground(color(0, 118, 213))
    .setColorActive(color(0, 98, 193))
    .setColorBackground(color(0, 118, 213))
    .setBroadcast(true)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).align(CENTER, CENTER)
    ;
  cp5.addTextlabel("credits")
    .setText("Created by Artur Trześniewski 2021")
    .setPosition(width-245, height-30)
    .setSize(250, 30)
    .setColorValue(0)
    .setFont(createFont("Arial", 12));
}
void massSlider1(float val) {
  mass1 = val;
}
void massSlider2(float val) {
  mass2 = val;
}
void lengthSlider1(float val) {
  r1 = val;
}
void lengthSlider2(float val) {
  r2 = val;
}
void angleSlider1(float val) {
  if (isActive==false) {
    deg1 = val;
  }
}
void angleSlider2(float val) {
  if (isActive==false) {
    deg2 = val;
  }
}
void gravitySlider(float val) {
  if (isActive == false) {
    g = val;
  }
}
void purpleButton() {
  traceColor = color(161, 152, 233);
}
void blueButton() {
  traceColor = color(0, 118, 213);
}
void greenButton() {
  traceColor = color(67, 255, 117);
}
void goldButton() {
  traceColor = color(254, 204, 24);
}
void orangeButton() {
  traceColor = color(241, 123, 35);
}
void redButton() {
  traceColor = color(241, 4, 77);
}

void startButton() {
  deg1_vel = 0;
  deg2_vel = 0;
  if (isActive == false) {
    frames = frameCount;
  }
  isActive = !isActive;
}
void clearButton() {
  drawPanel.beginDraw();
  drawPanel.background(255);
  drawPanel.endDraw();
}
