import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import java.util.*;

ParticleSystem ps;


String terminoBusqueda;
ArrayList<String> palabras = new ArrayList();
ArrayList<String> palabraAs = new ArrayList();

PImage twitterBackground, clouds;
List<Status> tweets;

//PImage[] img = new PImage[1000];

Twitter twitter;


void setup() {
  size(displayWidth, displayHeight);

  ps = new ParticleSystem(new PVector(width/2, 50));

  ConfigurationBuilder cb = new ConfigurationBuilder ()  ;
  cb.setOAuthAccessToken("121878907-cCrAoj562Xg71hLxG15A7x8ozhJjEacOpTKyg5h0");
  cb.setOAuthAccessTokenSecret("fQ7m2dVdLzIajHiMlCedzh1Rvv5xsRUZoES9lHH71Cje2");
  cb.setOAuthConsumerKey("8Dkqay1z247NprWZwWqUSuAfq");
  cb.setOAuthConsumerSecret("uf6y7urdwSOTQ99Nu9G1y6ELNsnNPWavSz5CXNhvxT1v1OP3zU");

  TwitterFactory tf = new  TwitterFactory(cb.build());

  twitter = tf.getInstance();

  terminoBusqueda = "Panteon Rococo";

  conectarTwitter();

  twitterBackground=loadImage("Twitter_logo_blue.png");
  clouds = loadImage ("tumblr_o3z65tMUpi1unv3kbo1_1280.png");

}




void draw () {
  //background(0);

  noCursor();
 //frameRate(2);


  //Draw a word from the list of words that we've built
  int a = (frameCount % palabras.size());
  String palabra = palabras.get(a);
  int b= (frameCount % palabraAs.size());
  String palabraA = palabraAs.get(b);
  clouds.resize(displayWidth, displayHeight);
  image(clouds, 0, 0);
  twitterBackground.resize(45, 40);
  image(twitterBackground, mouseX, mouseY+20);

 

  ps.addParticle(mouseX, mouseY);
  ps.update();
  ps.intersection();
  ps.display();


  fill(255);
  textSize(25);
  text("Se está hablando de " + terminoBusqueda, mouseX, mouseY);
  fill(random(255), random(100), random(145));
  strokeWeight(random(25));
  text(palabra, mouseX, mouseY+100);

  //frameRate(2);
  textSize(15); 
  textAlign(CENTER);
 text(palabraA, mouseX, mouseY+200);



}


void conectarTwitter() {
  try {
    Query query = new Query (terminoBusqueda);
    QueryResult respuesta = twitter.search(query);



    tweets = respuesta.getTweets();
    for (int i = 0; i<tweets.size(); i++) {

      println("Tweet" + tweets.get(i).getText());
      // println("Usuario" + tweets.get(i).getUser().getName());
      println("Ubicación" + tweets.get(i).getUser().getLocation());
      println("Imagen Perfil" + tweets.get(i).getUser().getProfileImageURL());
      println("Usuario" + tweets.get(i).getUser().getName()+"\n");
      tweets.get(i).getUser();


      String tweetContenido =tweets.get(i).getText();
      String Usuario =  tweets.get(i).getUser().getName()+"\n";
    
     
      
      


     
      String[] entrada = Usuario.split(",");
      for (int j = 0; j < entrada.length; j++) {
      
        palabras.add(entrada[j]);
      } 


    
      String[] entradas = tweetContenido.split(",");
      for (int h = 0; h < entradas.length; h++) {
       
        palabraAs.add(entradas[h]);
      }
    }
  }
  catch(TwitterException te) {
    println("Error de conexión con la base de Twitter");
    println("Error:"+ te.getMessage());
  }
}