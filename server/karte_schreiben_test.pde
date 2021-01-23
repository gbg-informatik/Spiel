JSONObject karte;

void setup() {

  karte = new JSONObject();

  karte.setString("name", "sandmap");
  karte.setInt("breite", 100);
  karte.setInt("hoehe", 500);
  karte.setString("default", "sand");
  

  saveJSONObject(karte, "data/new.karte");
}

// Sketch saves the following to a file called "new.karte":
// {
//   "id": 0,
//   "species": "Panthera leo",
//   "name": "Lion"
// }
