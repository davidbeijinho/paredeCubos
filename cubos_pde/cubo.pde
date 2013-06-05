class cubo 
{
	int posx;
	int posy;
  int ativo;
  float angulo;
  color[] corFaces  = new color[6];
  int tamanho;
  boolean roda ;
  boolean desenho ;
  float rodando;
int velocidade=3;
 int t;
  cubo (int _x , int _y) 
  {
    posx=_x;
    posy=_y;
    angulo=0;
  //  angulo=random(0,361);
    roda=false;
    desenho=true;
    rodando=0;
    tamanho=larguraPECA/2;//PORQUE ??????????????
         t=tamanho;

for (int i = 0; i<6; i++){
  corFaces[i] =corArray[int(random(0,3))];
}

  }

  void anima()
  {
    if (roda)
    {
      rodando+=velocidade;
      if (rodando>90)
      {
        roda=false;
        rodando=0;
        angulo+=90;
        ativo++;
        if (ativo==4)
        ativo=0;
      }
      roda();
    }
    else  
    {
      desenha();
    }

  }
  int getCor() {return ativo;}
  void esconde() {desenho=false;}
  boolean mostro() {return desenho;}
  void ativa() {roda=true;}
  boolean getRoda(){return roda;}

  void desenha()
  {


    pushMatrix();

     translate(posx,posy );
    rotateY(radians(angulo));

    beginShape(QUADS);
    fill(corFaces[0]);
  // +Z "front" face
  vertex(-t, -t, t);
  vertex( t, -t, t);
  vertex( t, t, t);
  vertex(-t, t, t);  
  fill(corFaces[1]);
  // -Z "back" face
  vertex( t, -t, -t);
  vertex(-t, -t, -t);
  vertex(-t, t, -t);
  vertex( t, t, -t); 
  fill(corFaces[2]);
  // +Y "bottom" face
  vertex(-t, t, t);
  vertex( t, t, t);
  vertex( t, t, -t);
  vertex(-t, t, -t);
  fill(corFaces[3]);
  // -Y "top" face
  vertex(-t, -t, -t);
  vertex( t, -t, -t);
  vertex( t, -t, t);
  vertex(-t, -t, t);
  fill(corFaces[4]);
  // +X "right" face
  vertex( t, -t, t);
  vertex( t, -t, -t);
  vertex( t, t, -t);
  vertex( t, t, t);
  fill(corFaces[5]);
  // -X "left" face
  vertex(-t, -t, -t);
  vertex(-t, -t, t);
  vertex(-t, t, t);
  vertex(-t, t, -t);

  endShape();
  popMatrix();
}

void roda()
{
 

  pushMatrix();
  //translate(posx+(tamanho/2),posy+(tamanho/2),-(tamanho/2));
   translate(posx,posy);
  rotateY(radians(angulo+rodando));
    // translate(-(tamanho/2),-(tamanho/2));
  //translate(-(tamanho/2), -(tamanho/2),(tamanho/2));
  beginShape(QUADS);
  fill(corFaces[0]);
  // +Z "front" face
  vertex(-t, -t, t);
  vertex( t, -t, t);
  vertex( t, t, t);
  vertex(-t, t, t);  
  fill(corFaces[1]);
  // -Z "back" face
  vertex( t, -t, -t);
  vertex(-t, -t, -t);
  vertex(-t, t, -t);
  vertex( t, t, -t); 
  fill(corFaces[2]);
  // +Y "bottom" face
  vertex(-t, t, t);
  vertex( t, t, t);
  vertex( t, t, -t);
  vertex(-t, t, -t);
  fill(corFaces[3]);
  // -Y "top" face
  vertex(-t, -t, -t);
  vertex( t, -t, -t);
  vertex( t, -t, t);
  vertex(-t, -t, t);
  fill(corFaces[4]);
  // +X "right" face
  vertex( t, -t, t);
  vertex( t, -t, -t);
  vertex( t, t, -t);
  vertex( t, t, t);
  fill(corFaces[5]);
  // -X "left" face
  vertex(-t, -t, -t);
  vertex(-t, -t, t);
  vertex(-t, t, t);
  vertex(-t, t, -t);

  endShape();
  popMatrix();
}


}
