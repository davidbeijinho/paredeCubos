import SimpleOpenNI.*;

int grelhaLargura=20;
int grelhaAltura=15;
float precentagem=0.5;

boolean [][] grelha = new boolean[grelhaLargura][grelhaAltura];

int larguraPECA;
int alturaPECA;
int pixelsPECA;
int comecoPIXEL;
int countPIXELS;
int contaMostra;
color corcor;
PImage aux;
int largura;
int altura;
SimpleOpenNI  context;

void setup()
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

void draw()
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
 // desenhaCubos();
}


void desenhaCubos()
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


void cubinhos(int t) {
int r =int ( random(0,256) );
 int g=int ( random(0,256) );
  int b=int ( random(0,256) );
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
