import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import SimpleOpenNI.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class cubos_pde extends PApplet {



int grelhaLargura=20;
int grelhaAltura=15;
float precentagem=0.5f;

boolean [][] grelha = new boolean[grelhaLargura][grelhaAltura];

int larguraPECA;
int alturaPECA;
int pixelsPECA;
int comecoPIXEL;
int countPIXELS;
int contaMostra;
int corcor;
PImage aux;
int largura;
int altura;
SimpleOpenNI  context;

public void setup()
{
  context = new SimpleOpenNI(this);
  if(context.enableScene() == false)
  {
    println("PROBLEMAS!"); 
    exit();
    return;
  }
  background(200,0,0);
  largura=context.sceneWidth() ;
  altura = context.sceneHeight();
  larguraPECA=largura/grelhaLargura;
  alturaPECA=altura/grelhaAltura;
  pixelsPECA=larguraPECA*alturaPECA;
  size(context.sceneWidth() , context.sceneHeight(),OPENGL); 
}

public void draw()
{
  context.update();   
  aux =context.sceneImage();
  int dimension = aux.width*aux.height;
  aux.loadPixels();
  for (int ga = 0; ga<grelhaAltura; ga++)
  {
    for (int gl = 0; gl<grelhaLargura; gl++)
    {
     // grelha[gl][ga]=false;
      comecoPIXEL=( (gl*larguraPECA)+((pixelsPECA*grelhaLargura)*ga) );
      corcor= color(random(0, 256), random(0, 256), random(0, 256));
      for (int a = 0; a<alturaPECA; a++)
      {
        for (int i = comecoPIXEL   ; i < (comecoPIXEL+larguraPECA); i ++) 
        { 
         float r1 = red(aux.pixels[i]);
         float b1 = blue(aux.pixels[i]);
         float g1 = green(aux.pixels[i]);
         if ( (r1!=0) || (b1!=0) || (g1!=0) )
         {
           countPIXELS++;
         }
       }
       comecoPIXEL+=largura;
      }
     // comecoPIXEL=( (gl*larguraPECA)+((pixelsPECA*grelhaLargura)*ga) );
      if (countPIXELS>(pixelsPECA*precentagem))
      {
        // corcor= color(random(0, 256), random(0, 256), random(0, 256));
        // for (int a = 0; a<alturaPECA; a++)
        // {
        //   for (int i = comecoPIXEL   ; i < (comecoPIXEL+larguraPECA); i ++) 
        //   { 
        //     aux.pixels[i] = corcor;
        //   }
        //   comecoPIXEL+=largura;
        // }
        grelha[gl][ga]=true;
      }
      countPIXELS=0;
    }
  }
  aux.updatePixels();
  image(aux,0,0);
  desenhaCubos();
}


public void desenhaCubos()
{


for (int aa = 0; aa<grelhaAltura-1 ; aa++){
  
for (int bb = 0; bb<grelhaLargura-1; bb++){
  
 pushMatrix();
  translate((larguraPECA*bb)+larguraPECA, (alturaPECA*aa)+alturaPECA );
//  box(alturaPECA,larguraPECA,alturaPECA);
cubinhos(larguraPECA);
  popMatrix();

}


}

 
}


public void cubinhos(int t, int r, int g, int b) {

  pushMatrix();
  beginShape(QUADS);
  fill(r, g, b, 50);
  // +Z "front" face
  vertex(-t, -t, t);
  vertex( t, -t, t);
  vertex( t, t, t);
  vertex(-t, t, t);  
  fill(r, b, g, 75);
  // -Z "back" face
  vertex( t, -t, -t);
  vertex(-t, -t, -t);
  vertex(-t, t, -t);
  vertex( t, t, -t); 
  fill(r, g, b, 40);
  // +Y "bottom" face
  vertex(-t, t, t);
  vertex( t, t, t);
  vertex( t, t, -t);
  vertex(-t, t, -t);
  fill(g, r, b, 80);
  // -Y "top" face
  vertex(-t, -t, -t);
  vertex( t, -t, -t);
  vertex( t, -t, t);
  vertex(-t, -t, t);
  fill(r, g, g, 60);
  // +X "right" face
  vertex( t, -t, t);
  vertex( t, -t, -t);
  vertex( t, t, -t);
  vertex( t, t, t);
  fill(r, g, b, 30);
  // -X "left" face
  vertex(-t, -t, -t);
  vertex(-t, -t, t);
  vertex(-t, t, t);
  vertex(-t, t, -t);

  endShape();
  popMatrix();
}
class SimpleThread extends Thread {
 
  boolean running;           // Is the thread running?  Yes or no?
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter
 
  // Constructor, create the thread
  // It is not running by default
  SimpleThread (int w, String s) {
    wait = w;
    running = false;
    id = s;
    count = 0;
  }
 
  public int getCount() {
    return count;
  }
 
  // Overriding "start()"
  public void start () {
    // Set running equal to true
    running = true;
    // Print messages
    println("Starting thread (will execute every " + wait + " milliseconds.)"); 
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
 
 
  // We must implement run, this gets triggered by start()
  public void run () {
    while (running && count < 10) {
      println(id + ": " + count);
      count++;
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
  }
 
 
  // Our method that quits the thread
  public void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "cubos_pde" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
