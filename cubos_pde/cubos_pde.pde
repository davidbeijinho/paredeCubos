import SimpleOpenNI.*;
import java.util.Collections;

int grelhaLargura=20;
int grelhaAltura=15;
float precentagem=0.5;
int numCores=4;
color[] corArray  = new color[numCores];
ArrayList<cubo> cubitos = new ArrayList<cubo>();
boolean [][] grelha = new boolean[grelhaLargura][grelhaAltura];
int larguraPECA;
int alturaPECA;
int pixelsPECA;
int comecoPIXEL;
int countPIXELS;
PImage fundo;
PImage aux;
int largura;
int altura;
SimpleOpenNI  context;
cubo unico;


void setup()
{
  fundo = loadImage("fundo.png");
  corArray[0] = #00C2FF;
  corArray[1] = #CC6699;
  corArray[2] = #D2145A;
  corArray[3] = #FF7300;
  context = new SimpleOpenNI(this);
  if(context.enableScene() == false)
  {
    println("PROBLEMAS!"); 
    exit();
    return;
  }
  largura=context.sceneWidth()*2;
  altura = context.sceneHeight()*2;
  larguraPECA=largura/grelhaLargura;
  alturaPECA=altura/grelhaAltura;
  pixelsPECA=larguraPECA*alturaPECA;
  size(context.sceneWidth()*2 , context.sceneHeight()*2,OPENGL); 
  criaParede();
}

void draw()
{
   // rotateY(radians(map(mouseX,0,1280,0,360)));
  background(255);
  pushMatrix();
  translate(0, 0, -((larguraPECA*1.5)) );
  image(fundo, 0, 0, largura, altura);
  popMatrix();
  translate(-(larguraPECA/2), -(larguraPECA*2), -40);

  lights();
  context.update();   
  aux =context.sceneImage();
 // aux.resize(largura,altura);
  aux.loadPixels();
  for (int ga = 0; ga<grelhaAltura; ga++)
  {
    for (int gl = 0; gl<grelhaLargura; gl++)
    {
      comecoPIXEL=( (gl* (larguraPECA/2) )+(( (pixelsPECA/4)* (grelhaLargura/2) )*ga) );
      for (int a = 0; a<alturaPECA; a++)
      {
        for (int i = comecoPIXEL   ; i < (comecoPIXEL+larguraPECA); i ++) 
        { 
          if ( (red(aux.pixels[i])!=0) || (blue(aux.pixels[i])!=0) || (green(aux.pixels[i])!=0) )
          {
            countPIXELS++;
          }
        }
        comecoPIXEL+=(largura/2);
      }
      unico= cubitos.get((ga*grelhaLargura)+gl);
      if (countPIXELS>((pixelsPECA/4)*precentagem))
      {
        unico.ativa();
      }
      unico.anima();
      countPIXELS=0;
    }
  }
 procuraColunas();
  baixaColunas();
  //  aux.updatePixels();
  // image(aux,0,0);
}

void criaParede()
{
  cubitos = new ArrayList<cubo>();
  cubo auxCubo;
  for (int aa = 0; aa<grelhaAltura ; aa++)
  {
    for (int bb = 0; bb<grelhaLargura; bb++)
    {
      pushMatrix();
      translate((larguraPECA*bb)+larguraPECA, (alturaPECA*aa)+alturaPECA );
      auxCubo = new cubo( (larguraPECA*bb)+larguraPECA,(alturaPECA*aa)+alturaPECA );
      cubitos.add(auxCubo);
      //auxCubo.anima();
      popMatrix();
    }
  }
}

void procuraColunas()
{
  color comparar;
  int inicial=0;
  int conta=0;
  cubo auxCubo;
  for (int vai = 0; vai<numCores; vai++)
  {
    conta=0;
    for (int bb = 0; bb<grelhaLargura; bb++)
    {
      conta=0;
      for (int aa = 0; aa<grelhaAltura ; aa++)
      {
        auxCubo=cubitos.get(bb+(grelhaLargura*aa));
        if (auxCubo.mostro() )
        {
          comparar=auxCubo.getCor();
          if (comparar==corArray[vai])
          {
            if (conta==0)
            {
              inicial=aa;  
            }
            conta++;
          }
          else if (conta>=3) 
          {

            for (int cc = 0; cc<conta; cc++)
            {
              auxCubo=cubitos.get( bb + ( grelhaLargura * ( inicial + cc ) ) );
              auxCubo.esconde();
            }
          }
          else {conta=0;}
        }
        else {conta=0;}
      }
    }
  } 
}

void baixaColunas()
{
  cubo auxCubo;
  cubo aux1Cubo;
  for (int bb = 0; bb<grelhaLargura; bb++)
  {
    for (int aa = 0; aa<grelhaAltura ; aa++)
    {
      auxCubo=cubitos.get(bb+(grelhaLargura*aa));
      if (auxCubo.mostro() )
      {
        if ((aa+1)<grelhaAltura)
        {
          aux1Cubo=cubitos.get(bb+(grelhaLargura* (aa+1)  ));
          if (aux1Cubo.mostro()==false)
          {
            auxCubo.baixa();
            aux1Cubo.sobe();
            Collections.swap(cubitos,(bb+(grelhaLargura*aa)),(bb+(grelhaLargura*(aa+1))) );
          }
        }
      }
    }
  }
}

boolean sketchFullScreen() {
  return true;
}

void keyPressed() {

}