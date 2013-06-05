//GIT GUI
import SimpleOpenNI.*;

int grelhaLargura=20;
int grelhaAltura=15;
float precentagem=0.5;
int numCores=3;
color[] corArray  = new color[numCores];
ArrayList<cubo> cubitos = new ArrayList<cubo>();


boolean [][] grelha = new boolean[grelhaLargura][grelhaAltura];

int larguraPECA;
int alturaPECA;
int pixelsPECA;
int comecoPIXEL;
int countPIXELS;


PImage aux;
int largura;
int altura;
SimpleOpenNI  context;
cubo unico;
void setup()
{
  corArray[0] = #00C2FF;
  corArray[1] = #CC6699;
  corArray[2] = #D2145A;
  context = new SimpleOpenNI(this);
  if(context.enableScene() == false)
  {
    println("PROBLEMAS!"); 
    exit();
    return;
  }


  largura=context.sceneWidth();
  altura = context.sceneHeight();
  larguraPECA=largura/grelhaLargura;
  alturaPECA=altura/grelhaAltura;
  pixelsPECA=larguraPECA*alturaPECA;
  size(context.sceneWidth() , context.sceneHeight(),OPENGL); 
  criaParede();
}

void draw()
{
  lights();
  background(0);
  context.update();   
  aux =context.sceneImage();
  aux.loadPixels();
  for (int ga = 0; ga<grelhaAltura; ga++)
  {
    for (int gl = 0; gl<grelhaLargura; gl++)
    {
     comecoPIXEL=( (gl*larguraPECA)+((pixelsPECA*grelhaLargura)*ga) );
     for (int a = 0; a<alturaPECA; a++)
     {
      for (int i = comecoPIXEL   ; i < (comecoPIXEL+larguraPECA); i ++) 
      { 
       if ( (red(aux.pixels[i])!=0) || (blue(aux.pixels[i])!=0) || (green(aux.pixels[i])!=0) )
       {
         countPIXELS++;
       }
     }
     comecoPIXEL+=largura;
   }
   unico= cubitos.get((ga*grelhaLargura)+gl);
   if (countPIXELS>(pixelsPECA*precentagem))
   {
    unico.ativa();
  }
  unico.anima();
  countPIXELS=0;
}
}
procuraColunas();
/*  aux.updatePixels();*/
/* image(aux,0,0);*/
}




void criaParede()
{
  cubo auxCubo;
  for (int aa = 0; aa<grelhaAltura ; aa++)
  {
    for (int bb = 0; bb<grelhaLargura; bb++)
    {
     pushMatrix();
     translate((larguraPECA*bb)+larguraPECA, (alturaPECA*aa)+alturaPECA );
     auxCubo = new cubo( (larguraPECA*bb)+larguraPECA,(alturaPECA*aa)+alturaPECA );
     cubitos.add(auxCubo);
     auxCubo.anima();
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

      //  for (int cc = 0; cc<conta; cc++)
        //{
         //inicial+=cc;
         auxCubo=cubitos.get( bb + ( grelhaLargura * ( inicial /*+ cc*/ ) ) );
         auxCubo.esconde();
       //}
     }
     else 
     {
      conta=0;
    }
    }
  }

}

} 
}