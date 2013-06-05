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
  float spedd;
  int gogo;
  int jaja;
  int vou;
  int t;
  cubo (int _x , int _y) 
  {
    posx=_x;
    posy=_y;
    angulo=0;
    roda=false;
    desenho=true;
    rodando=0;
    tamanho=larguraPECA/2;//PORQUE ??????????????
    t=tamanho;
gogo=0;
jaja=0;
spedd=larguraPECA/5;
    for (int i = 0; i<6; i++){
      corFaces[i] =corArray[int(random(0,3))];
    }

  }
  void baixa(){
  //  posy+=larguraPECA;
  gogo++;
  }
  void sobe(){posy-=larguraPECA;}
  color getCor() {return corFaces[ativo];}
  void esconde() {desenho=false;}
  boolean mostro() {return desenho;}
  void ativa() {roda=true;}
  boolean getRoda(){return roda;}
  
  void anima()
  {
    if (desenho){
      
    
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
    }
    desenha();
    if (gogo>0)
    {
      posy+=spedd;
      jaja+=spedd;
      if (jaja>=larguraPECA)
      {
        posy-=jaja-larguraPECA;
      gogo--;
      jaja=0;
    }
    }
  }
  }

  void desenha()
  {
    pushMatrix();
    translate(posx,posy );
    rotateY(radians(angulo+rodando));
    beginShape(QUADS);

    fill(corFaces[0]);/* +Z "front" face*/
    vertex(-t, -t, t);
    vertex( t, -t, t);
    vertex( t, t, t);
    vertex(-t, t, t);

    fill(corFaces[2]);/* -Z "back" face*/
    vertex( t, -t, -t);
    vertex(-t, -t, -t);
    vertex(-t, t, -t);
    vertex( t, t, -t); 

    fill(corFaces[1]);/* +X "right" face*/
    vertex( t, -t, t);
    vertex( t, -t, -t);
    vertex( t, t, -t);
    vertex( t, t, t);

    fill(corFaces[3]);/* -X "left" face*/
    vertex(-t, -t, -t);
    vertex(-t, -t, t);
    vertex(-t, t, t);
    vertex(-t, t, -t);

    fill(corFaces[4]);/* +Y "bottom" face*/
    vertex(-t, t, t);
    vertex( t, t, t);
    vertex( t, t, -t);
    vertex(-t, t, -t);

    fill(corFaces[5]);/* -Y "top" face*/
    vertex(-t, -t, -t);
    vertex( t, -t, -t);
    vertex( t, -t, t);
    vertex(-t, -t, t);

    endShape();
    popMatrix();
  }

}
