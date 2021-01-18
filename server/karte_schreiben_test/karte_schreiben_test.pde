JSONObject json;
JSONObject block_sand, block_bad;
JSONArray blocks, pos_sand, pos_bad;

JSONObject position(int x, int y) {
  JSONObject pos; 
  pos.setInt("x", x).setInt("y",y);
  return pos;
}

void setup() {

  json = new JSONObject();
  
  block_sand.setInt("id", 0);
  block_sand.setJSONObject("pos", );

  json.setString("name", "sandmap");
  json.setInt("breite", 100);
  json.setInt("hoehe", 500);
  json.setString("default", "sand");
  

  saveJSONObject(json, "data/map.txt");
}

// Sketch saves the following to a file called "new.karte":
/* {
     "name" : "name",
     "width": x,
     "height": y,
     "blocks" : [
       {
         "name": "sand",
         "id": 0,
         "pos" : [
           {"x:"
           }
         
         ]
     
     
     ],
  
*/   "id": 0,
//   "species": "Panthera leo",
//   "name": "Lion"
// }
