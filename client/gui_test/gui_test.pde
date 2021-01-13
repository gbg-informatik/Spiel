

guiButton menujoin = new guiButton(20,20,100,30,2);

void setup() {
  size(640, 360);
  
}

void draw() {
  background(255);
  menujoin.updateMouse(mouseX, mouseY);
  menujoin.show();
}


// Klasse der health bar

/* die health kann folgendermaßen angezeigt werden:

// health über setHealth setzen

guiHealthBar healthBar(...);
...
setHealth(health); 
...
show();

//oder direkt über show()

guiHealthBar healthBar(...);
...
show(health);

*/



class guiHealthBar {
  
  private float x, y;
  private float width, height;
  private float radius;
  private int health = 0;  // from 0 - 100
  private float health_width = 0;
  
  
  /*
    Initialisiert die health bar.
    X und Y werte sind hierbei der Mittelpunkt 
  */
  guiHealthBar (float x, float y, float width, float height, float radius) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.radius = radius;
  }
    
  void setHealth( int health ) {
    
    // auf 0-100 beschränken
    if (health > 100) health = 100;
    if (health < 0) health = 0;
    
    // klassen
    this.health = health;
    this.health_width = width * health / 100f;
  }
  
  void show( int health ) {
    setHealth(health);
    show();
  }  
    
  void show() {
    rectMode(CENTER);
    stroke(150);
    fill(130);
    rect(x, y, width, height, 5);
    
        

  }
  
}


// Klasse für einen Button

class guiButton {

  private boolean highlighted = false;

  private float x, y;
  private float width, height, radius;

  guiButton (float x, float y, float width, float height, float radius) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.radius = radius;
  }

  private boolean mouseOnButton(int mouse_x, int mouse_y) {
    return mouse_x > x && mouse_x < x + width && mouse_y > y && mouse_y < y + height;
  }

  void updateMouse(int mouse_x, int mouse_y) {
    if( mouseOnButton(mouse_x, mouse_y) ) {
      highlighted = true;
    } else {
      highlighted = false;
    }
  }

  void show() {
    rectMode(CORNER);

    if(highlighted) {
      fill(170);
    } else {
      fill(150);
    }
    noStroke();
    rect(x, y, width, height, radius);
  }

  // gibt true zurück, wenn der Button mit der Maus angeklickt wurde
  boolean clicked(int mouse_x, int mouse_y) {
    return mouseOnButton(mouse_x, mouse_y);
  }

}
