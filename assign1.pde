SlotMachine machine;
boolean rolling = false;
// button information
boolean button = false;
int x = 640/2;
int y = 440;
int w = 150;
int h = 50;

// declare variables
// --------------------------------------------
// put your code inside here
int totalScore = 500;
int score;
int random0,random1,random2,fAmount,e;
int probability0,probability1,probability2,check000; //for probability
int score0,score1,score2;





// --------------------------------------------

void setup() {
  size(640,480);
  textFont(createFont("fonts/Square_One.ttf", 20));
  machine = new SlotMachine();
  //println("You have 500!!");
}

void draw() {
  background(245,229,124);
  fill(64,162,171);
  rect(320,248,396,154,25);
  fill(253,253,253);
  rect(220,247,97,114,2);
  rect(320,247,97,114,2);
  rect(420,247,97,114,2);
  // draw button
  fill(64,162,171);
  noStroke();
  rectMode(CENTER);
  rect(x,y,w,h,105);
  // show title
  fill(64,64,63);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Slot Machine",x,49);
  textSize(20);
  text("Score"+" "+":"+" "+totalScore,x, 89);
  
  // event handler
  if (button) {
    if (!rolling){
      rolling = true;
      // start rolling
      // -------------------------------------------------
      // put your code inside here
      
      // Step0================spend $50 to play the game================
      totalScore = totalScore -50;
      //println("You spent 50. Current score: " + totalScore);
      
      
      // Step1================set 777 probability
      probability0 = machine.probability(0.1); 
      probability1 = machine.probability(0.1); 
      probability2 = machine.probability(0.1);

      // Sept2================if the probability==1, set fruits to 777================
      if(probability0 == 1 && probability1 == 1 && probability2 == 1) {
        random0 = random1 = random2 = 0;
      }
      
      // Sept3================start random the fid================
      else  {
        random0 = int(random(6));
        random1 = int(random(6));
        random2 = int(random(6));
        
      // Sept4================if fruits=000, random again(stop radoming when a!=0&&b!=0&&c!=0 ================
        if(random0 == 0 && random1 == 0 && random2 == 0)
        {
          for(check000=1;;check000++)
          {
          random0 = int(random(6));
          random1 = int(random(6));
          random2 = int(random(6));
            if(random0 != 0 && random1 != 0 && random2 != 0)
              {break;}
          }  
        }      
      }
      
      // Sept5================set score================

      
      machine.setSlotFruit(0, random0);
      score0 = machine.getSlotScore(random0);
      
      machine.setSlotFruit(1, random1);
      score1 = machine.getSlotScore(random1);
      
      machine.setSlotFruit(2, random2);
      score2 = machine.getSlotScore(random2);
      
      
      // -------------------------------------------------
    }
    machine.roll();
    textSize(19);
    text("Stop",x,y);
  
  } else {
    if (rolling){
      rolling = false;
      // stop rolling
      // -------------------------------------------------
      // put your code inside here
      
      // Sept6================count fruits================
      for(e=0; e<6; e++)
      {
        fAmount=machine.getFruitCount(e);
        if(fAmount==3){break;}
        if(fAmount==2){break;}
      }
     if(fAmount==0){fAmount=1;}
    
     // Sept7================count totalScore================
      
      //situation 1 *****************
      if(fAmount==1){
        totalScore = totalScore + score0 + score1 + score2;
        //println("Not the same. " + score0 +"," + score1 +"," + score2);
      }
      
      //situation 2 *****************
      if(fAmount == 2){
        //println("fAmount == 2");
        if( score0 == score1 ){
          totalScore = totalScore + score0*4 + score2;
          //println("score0 == score1:" + score0 +"," + score1 +"," + score2 );
        }
        else if(score1 == score2){
          totalScore = totalScore + score1*4 + score0;
          //println("score1 == score2:" + score0 +"," + score1 +"," + score2);
        }
        else{
          totalScore = totalScore + score0*4 + score1;
          //println("score0 == score2:" + score0 +"," + score1 +"," + score2);
        }
      }
      
      //situation 3 *****************
      if(fAmount==3){
        totalScore = totalScore + score0*9;
        //println("TotalScore = " + totalScore );
      }
      
      
      

      
      // -------------------------------------------------
    }
    machine.stop();
    fill(253,253,253);
    textSize(19);
    text("Roll",x,y);
  }

}

// When the mouse is pressed, the state of the button is toggled.   
void mousePressed() {
  if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
    button = !button;
  }  
}






