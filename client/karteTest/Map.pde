class Map
{
  int numImages = 4;
  String imageNames[] = {"Boden.png", "Mauer_1.png", "Gut.png", "Böse.png"};
  PImage images[] = new PImage[numImages];
  
  int[] [] map = new int[50] [50];
  
  void loadImages() {
    for(int i = 0; i < numImages; i++) {
      images[i] = loadImage(imageNames[i]);      
    }
  }
  
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
        image( images[map[kachelx+i][kachely+j]] ,i*75-posx%75,j*75-posy%75);
        //fill(150);
        //rect(i*75 - x%75, j*75 - y%75, 75, 75);
      }
    } 
  }
}
