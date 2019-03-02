class Pipe
{
  float x;
  int gap = 380;
  float h = random(100, (height - terrain) - gap - 100);
  int w = 200;
  
  Pipe(float position)
  {
    x = position;
  }
  
  void move(float prevH)
  {
    x -= 7.125;
    
    if(x < -200)
    {
      x = 1240;
      
      do{
        h = random(100, (height - terrain) - gap - 100);
      }while(abs(h - prevH) > 400);
    }
  }
  
  void render()
  {
    fill(0, 154, 50);
    rect(x, (height - terrain) - h, w, h);
    rect(x, 0, w, (height - terrain) - h - gap);
  }
  
  int collision(float objectX, float objectY)
  {
    if(objectX + 60 > x && objectX < x + w)
    {
      if(objectY > 0 && objectY < (height - terrain) - h - gap) return -1;
      else if(objectY + 60 > (height - terrain) - h && objectY + 60 < (height - terrain)) return 1;
    }
    return 0;
  }
}
