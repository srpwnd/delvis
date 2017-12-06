import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import megamu.mesh.*;

Mover[] movers = new Mover[30];
ArrayList<float[]> points;

Attractor a;

Minim minim;
AudioPlayer player;
AudioMetaData meta;
BeatDetect beat;
FFT fft;

void setup() {
  //size(1920, 1080);
  fullScreen();
  frameRate(24);
  background(255);
  stroke(255,30);
  strokeWeight(1.2);
  noCursor();
  noFill();
  smooth();
  colorMode(HSB, 360, 100, 100);
  
  
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 2));
  }
  a = new Attractor();
  points = new ArrayList<float[]>();
  
  minim = new Minim(this);
  player = minim.loadFile("milk.mp3"); //provide your soundfile
  beat = new BeatDetect();
  beat.detectMode(BeatDetect.FREQ_ENERGY);
  //player.play();
  player.loop();
  
  fft = new FFT(player.bufferSize(),player.sampleRate());
}

void draw() {
  println(frameRate);
  noStroke();
  fill(0,2);
  rect(0,0,width,height);
  noFill();
  stroke(255,30);
  strokeWeight(1);
  
  beat.detect(player.mix);
  fft.forward(player.mix);
  
  if(beat.isKick()) {
    background(0);
  }
  if(beat.isSnare()) {
    background(255);
  }
  if(beat.isHat()) {
    stroke(random(359),80,86,70);
  }

  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]);
    movers[i].applyForce(force);
    movers[i].update();
  }
  
  points.clear();
  for(Mover w : movers) {
    for(float[] f : w.soundWave.returnPoints(w.location)){
     points.add(f); 
    }
  }
 
  Delaunay d = new Delaunay(points.toArray(new float[points.size()][2]));
  for(float[] edge : d.getEdges()) {
    if(edgeLenght(edge) < (beat.isSnare() ? 150 : 100)) {
      line(edge[0],edge[1],edge[2],edge[3]);
    }
  }
  
  if(!player.isPlaying()) {
    exit();
  }
}


float edgeLenght(float [] edge) {
  return (float) Math.sqrt((edge[0]-edge[2]) * (edge[0]-edge[2]) + (edge[1]-edge[3]) * (edge[1]-edge[3]));
}

void stop()
{
  player.close();
  minim.stop();
 
  super.stop();
} 