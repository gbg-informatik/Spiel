class Map
{
  int[] [] map = new int[50] [50];
  
  void fillMap()
  {
    for (int i = 0; i < 50; i++)
    {
      for (int j = 0; j < 50; j++)
      {
        map[i] [j] = int(random(4));
      }
    }
  }
  
  void drawMap(int x, int y)
  {
    clear();
    kachelx = floor((x-12*75)/75);
    kachely = floor((y-7*75)/75);
    for (int i = 0; i < 27; i++)
    {
      for (int j = 0; j < 16; j++)
      {
        switch(map[kachelx+i][kachely+j])
        {
          case 0:
            fill(255,255,255);
            break;
          case 1:
            fill(255,0,0);
            break;
          case 2:
            fill(0,255,0);
            break;
          case 3:
            fill(0,0,255);
            break;
        }
        rect(i*75-posx%75,j*75-posy%75,75,75);
      }
    } 
  }
}
