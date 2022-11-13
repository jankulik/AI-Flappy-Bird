int numberOfBirds = 15;

Pipe pipe[] = new Pipe[2];
Bird bird[] = new Bird[numberOfBirds];
Perceptron perceptron[] = new Perceptron[numberOfBirds];
float[] input = new float[4];

boolean first = true;
float dane = 0;

int terrain = 300;
int closestPipe;
int generation = 1;
int score = 0;
int highScore = 0;
float prevH;

void setup()
{
  size(1080, 1920);
  
  for(int i = 0; i < pipe.length; i++)
  {
    pipe[i] = new Pipe(1080 + (i * 720));
  }
  
    for(int i = 0; i < perceptron.length; i++)
  {
    bird[i] = new Bird();
    perceptron[i] = new Perceptron(4);
  }
}

void draw()
{
  background(55, 184, 252);
  
  int alive = 0;
  if(pipe[1].x < 45) closestPipe = 0;
  else if(pipe[0].x < 45) closestPipe = 1;
  
  for(int i = 0; i < pipe.length; i++)
  {
    pipe[i].move(prevH);
    pipe[i].render();
  }
  
  for(int i = 0; i < perceptron.length; i++)
  {
    getInput(i); 
    bird[i].collision(closestPipe);
    
    if(bird[i].collision != 0 && bird[i].alive == true)
    {
      bird[i].alive = false;
      perceptron[i].train(input, bird[i].collision);
    } 
    else if(perceptron[i].feedForward(input) == 1 && bird[i].alive)
    {
      bird[i].jump = true;
      bird[i].resetJump();
    }
    
    if(!bird[i].jump) bird[i].gravity();
    else bird[i].jump();
    
    bird[i].render();
    
    if(bird[i].alive == true) alive++;
  }
  
  if(alive == 0)
  {
    for(int i = 0; i < perceptron.length; i++)
    {
      bird[i].reset();
    }
    
    for(int i = 0; i < pipe.length; i++)
    {
      pipe[i] = new Pipe(1080 + (i * 720));
    }
    
    closestPipe = 0;
    score = 0;
    generation++;
  }
  
  if(pipe[closestPipe].x == 64.375 || pipe[closestPipe].x == 61.125 || pipe[closestPipe].x == 61.5) score++;
  if(score >= highScore) highScore = score;
  
  fill(255, 204, 153);
  rect(0, height - terrain, width, height);
  textSize(60);
  fill(0);
  text("Generation:", 62, height - terrain + 100);
  text(generation, 412, height - terrain + 100);
  text("Birds alive:", 62, height - terrain + 200);
  text(alive, 412, height - terrain + 200);
  
  text("Score:", 584, height - terrain + 100);
  text(score, 934, height - terrain + 100);
  text("High Score:", 582, height - terrain + 200);
  text(highScore, 934, height - terrain + 200);
  
  prevH = pipe[closestPipe].h;
}

void getInput(int i)
{  
  input[0] = pipe[closestPipe].x - bird[i].x;
  input[1] = abs((height - terrain) - pipe[closestPipe].h - pipe[closestPipe].gap - bird[i].y);
  input[2] = abs((height - terrain) - pipe[closestPipe].h - bird[i].y);
  input[3] = 1;
}
