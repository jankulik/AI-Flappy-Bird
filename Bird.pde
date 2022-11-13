class Bird
{
  float x = 240;
  float y = (height - terrain) / 2;
  float aGrav = 5.4;
  float aJump = 46.8;
  boolean jump = false;
  float jumped = 0;
  boolean alive = true;
  int collision = 0;
  
  void gravity()
  {
    if(aGrav < 24) aGrav = aGrav * 1.1;
    if(y < (height - terrain) + 20) y += aGrav;
  }
  
  void jump()
  {
    aJump = aJump / 1.165;
    y -= aJump;
    jumped++;
    
    if(jumped == 20)
    {
      jumped = 0;
      jump = false;
    }
  }
  
  void resetJump()
  {
    jumped = 0;
    aGrav = 5.4;
    aJump = 46.8;
  }
  
  void render()
  {
    stroke(0);
    fill(255);
    rect(x, y, 60, 60);
  }
  
  void reset()
  {
      y = (height - terrain) / 2;
      collision = 0;
      alive = true;
  }
  
  void collision(int closestPipe)
  {
    if(pipe[closestPipe].collision(x, y) == 1 || y + 60 >= (height - terrain)) collision = 1;
    else if(pipe[closestPipe].collision(x, y) == -1 || y <= 0) collision = -1;
  }
}
