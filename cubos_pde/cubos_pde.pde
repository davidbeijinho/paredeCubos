import SimpleOpenNI.*;

int grelhaLargura=20;
int grelhaAltura=15;
float precentagem=0.5;

color[] corArray  = new color[3];
ArrayList<cubo> cubitos = new ArrayList<cubo>();


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
int vou;
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

  background(200,0,0);
  largura=context.sceneWidth();
  altura = context.sceneHeight();
  larguraPECA=largura/grelhaLargura;
  alturaPECA=altura/grelhaAltura;
  pixelsPECA=larguraPECA*alturaPECA;
  size(context.sceneWidth() , context.sceneHeight(),OPENGL); 
  criaParede();
  println("LARGURA "+largura+" PECA -> "+ larguraPECA);
}

void draw()
{
  lights();
  background(0);
  vou=0;
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
 //  unico = cubitos.get((ga*(grelhaLargura))+gl);
// println("vou-> "+vou+" ga-> "+ga+" gl-> "+gl);
 unico= cubitos.get(vou);
 vou++;
     if (countPIXELS>(pixelsPECA*precentagem))
     {
      //  desenhaCubo(gl,ga);
     //   grelha[gl][ga]=true;
        unico.ativa();
    }
    unico.anima();
      countPIXELS=0;
    }
  }
//  aux.updatePixels();
 // image(aux,0,0);
 // desenhaCubos();
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
     // println("XX ga-> "+aa+" gl-> "+bb);
    // cubinhos(larguraPECA);
     popMatrix();
   }
 }
//println("TODOS-> "+cubitos.size());
}






