package;

   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.utils.*;
   import general.ButtonUpdater;
   import general.Heb;
   import general.MsgBox;
   import tween.TweenLiteHaxe;
   import com.greensock.easing.*;
   
   class BambaFight
   {
   var roundCardsIds:Array<Dynamic>;
  
   var enemy:BambaFighter;
  
   var cardFightLocationAndSize:Dynamic;
  
   var nextStepContinueInterval:Dynamic;
  
   var MC:MovieClip;
  
   var cardPicksLocation:Dynamic;
  
   var me:BambaFighter;
  
   var currStep:Float;
  
   var roundNum:Float;
  
   var fightStatus:Float;
  
   var cardUnPicksAttackLocation:Dynamic;
  
   var enemyLevelData:BambaEnemyLevel;
  
   var hitMatrix:MovieClip;
  
   var animCardInterval:Dynamic;
  
   var costOfPickedCards:Float;
  
   var enemyId:Float;
  
   var fightStage:Float;
  
   var enemyData:BambaEnemy;
  
   var cardsPlayerCanUse:Dynamic;
  
   var cardsEnemyCanUse:Dynamic;
  
   var noLife:Float;
  
   var enemyType:Float;
  
   var enemyLevel:Float;
  
   var cardPickedByPlayer:Array<Dynamic>;
  
   var endAnimInterval:Dynamic;
  
   var game:MovieClip;
  
   var roundCards:Array<Dynamic>;
  
   var cardUnPicksMoveLocation:Dynamic;
  
   var startAnimInterval:Dynamic;
  
   var winAnimInterval:Dynamic;
  
  public function new(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic, param5:Dynamic)
  {
     var _loc6_:Dynamic=undefined;
     cardPicksLocation=[[140,0],[70,0],[0,0]];
     cardUnPicksMoveLocation=[[513,0],[427.5,0],[342,0],[256.5,0],[171,0],[85.5,0],[0,0]];
     cardUnPicksAttackLocation=[[427.5,100],[342,100],[256.5,100],[171,100],[85.5,100],[427.5,200],[342,200],[256.5,200],[171,200],[85.5,200]];
     cardFightLocationAndSize=[[176,0,1],[252,18,0.63],[301,18,0.63],[98,0,1],[49,18,0.63],[0,18,0.63]];
     super();
     game=param1;
     MC=param2;
     enemyId=param3;
     enemyType=param4;
     enemyLevel=param5;
     enemyData=game.gameData.getCatalogEnemy(enemyId,enemyType);
     enemyLevelData=game.gameData.getCatalogEnemyLevel(enemyLevel,enemyType);
     ButtonUpdater.setButton(MC.cardPickMC.fightButton,fightButtonClicked);
     ButtonUpdater.setButton(MC.continueButtonParent.continueButton,continueButtonClicked);
     MC.cardPickMC.visible=true;
     MC.boardMC.visible=false;
     MC.continueButtonParent.visible=false;
     _loc6_= BambaAssets.fightBack();
     MC.boardMC.backMC.addChild(_loc6_);
     Heb.setText(MC.meData.LIFE,game.gameData.dictionary.LIFE);
     Heb.setText(MC.meData.MAGIC,game.gameData.dictionary.MAGIC);
     Heb.setText(MC.meData.NAME,game.gameData.playerData.pName + " " + game.gameData.dictionary.CHARACTER_LEVEL + " " + game.gameData.playerData.level);
     Heb.setText(MC.enemyData.LIFE,game.gameData.dictionary.LIFE);
     Heb.setText(MC.enemyData.MAGIC,game.gameData.dictionary.MAGIC);
     Heb.setText(MC.enemyData.NAME,enemyData.eName + " " + game.gameData.dictionary.CHARACTER_LEVEL + " " + enemyLevel);
     setFighters();
     resetFight();
  }
  
   function afterEndFight():Dynamic
  {
     var _loc1_:String=null;
     var _loc2_:Array<Dynamic>=null;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Array<Dynamic>=null;
     var _loc5_:Dynamic=undefined;
     var _loc6_:Dynamic=undefined;
     clearInterval(endAnimInterval);
     if(fightStatus==2)
     {
        _loc3_=1;
        _loc4_=enemyData.prizesIds;
        _loc5_=_loc4_[Math.floor(Math.random()* _loc4_.length)];
        _loc2_=game.gameData.playerData.addPrizes(enemyLevelData.exPoints,_loc5_,_loc3_);
        _loc6_=2;
        MsgBox.showWin(game.gameData.dictionary.WIN_FIGHT_MSG,_loc2_,closeMsgBox,_loc6_);
     }
     else
     {
        game.aDungeon.endFight(fightStatus);
     }
  }
  
  public function startRoundAnim():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     MC.cardPickMC.visible=false;
     MC.boardMC.visible=true;
     roundCards=[];
     _loc1_=0;
     while(_loc1_<6)
     {
        _loc2_=game.gameData.getNewCard(roundCardsIds[_loc1_]);
        roundCards.push(_loc2_);
        if(_loc1_<3)
        {
           _loc2_.generateMC(me.dir);
        }
        else
        {
           _loc2_.generateMC(enemy.dir);
        }
        MC.cardsFightMC.addChild(_loc2_.mc);
        _loc2_.mc.gotoAndStop("back");
        _loc2_.mc.scaleX=cardFightLocationAndSize[_loc1_][2];
        _loc2_.mc.scaleY=cardFightLocationAndSize[_loc1_][2];
        _loc2_.mc.x=cardFightLocationAndSize[_loc1_][0];
        _loc2_.mc.y=cardFightLocationAndSize[_loc1_][1];
        _loc1_++;
     }
     ++roundNum;
     currStep=0;
     playStep();
  }
  
   function showContinueAtStart():Dynamic
  {
     trace("showContinueAtStart");
     clearInterval(startAnimInterval);
     MC.continueButtonParent.visible=true;
     MC.continueButtonParent.gotoAndPlay("up");
  }
  
  public function resetFight():Dynamic
  {
     resetFightVars();
     if(me !=null)
     {
        me.initFighter();
        enemy.initFighter();
     }
     startFight();
  }
  
  public function disableExpensiveCards():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     _loc1_=0;
     while(_loc1_<cardsPlayerCanUse.length)
     {
        _loc2_=game.gameData.getCatalogCard(cardsPlayerCanUse[_loc1_]);
        if(_loc2_.picked==false)
        {
           if(_loc2_.cost>me.magicPower - costOfPickedCards)
           {
              _loc2_.mc.frontMC.gotoAndStop("disable");
              _loc2_.disabled=true;
           }
           else
           {
              _loc2_.mc.frontMC.gotoAndStop("reg");
              _loc2_.disabled=false;
           }
        }
        _loc1_++;
     }
  }
  
   function hideHitMatrix():Dynamic
  {
     if(MC.boardMC.backMC.contains(hitMatrix))
     {
        MC.boardMC.backMC.removeChild(hitMatrix);
     }
  }
  
  public function playStep():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     _loc1_=Math.floor(currStep / 2);
     _loc2_=currStep % 2;
     if(_loc2_==0)
     {
        animCards();
     }
     else
     {
        playCardinStep();
     }
  }
  
   function closeMsgBox():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     if(roundCards !=null)
     {
        _loc1_=0;
        while(_loc1_<roundCards.length)
        {
           if(MC.contains(roundCards[_loc1_].mc))
           {
              MC.cardsFightMC.removeChild(roundCards[_loc1_].mc);
           }
           _loc1_++;
        }
     }
     if(game.aDungeon !=undefined)
     {
        game.aDungeon.endFight(fightStatus);
     }
  }
  
   function reportNoLife(param1:Dynamic):Dynamic
  {
     if(noLife !=0)
     {
        noLife=4;
     }
     else
     {
        noLife=param1;
     }
  }
  
   function playWinAnim(param1:BambaFighter):Dynamic
  {
     clearInterval(winAnimInterval);
     param1.playWinAnim();
  }
  
   function endFight(param1:Dynamic):Dynamic
  {
     if(fightStatus==1)
     {
        fightStatus=param1;
        switch(fightStatus)
        {
           case 2:
              game.sound.playEffect("BATTLE_WIN");
              game.sound.stopMusic();
              winAnimInterval=setInterval(playWinAnim,500,me);
              enemy.playLoseAnim();
              break;
           case 3:
              game.sound.playEffect("BATTLE_LOSE");
              game.sound.stopMusic();
              winAnimInterval=setInterval(playWinAnim,500,enemy);
              me.playLoseAnim();
              break;
           case 4:
              game.sound.playEffect("BATTLE_LOSE");
              game.sound.stopMusic();
              enemy.playLoseAnim();
              me.playLoseAnim();
        }
        endAnimInterval=setInterval(afterEndFight,game.gameData.winAnimLength * 1000);
     }
  }
  
   function continueButtonClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        setCardPick();
        MC.continueButtonParent.visible=false;
     }
  }
  
   function clearEvents():Dynamic
  {
     ButtonUpdater.clearEvents(MC.cardPickMC.fightButton,fightButtonClicked);
     ButtonUpdater.clearEvents(MC.continueButtonParent.continueButton,continueButtonClicked);
  }
  
  public function nextStepContinue():Dynamic
  {
     clearInterval(nextStepContinueInterval);
     if(currStep % 2==0 && noLife !=0)
     {
        endFight(noLife);
     }
     else if(currStep<6)
     {
        playStep();
     }
     else
     {
        endRound();
     }
  }
  
   function resetFightVars():Dynamic
  {
     fightStatus=1;
     roundNum=0;
     fightStage=1;
     clearInterval(endAnimInterval);
     clearInterval(nextStepContinueInterval);
     clearInterval(animCardInterval);
     clearInterval(winAnimInterval);
     clearInterval(startAnimInterval);
     me.resetFighterVars();
     enemy.resetFighterVars();
  }
  
   function showHitMatrix(param1:Dynamic, param2:Dynamic):Dynamic
  {
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     var _loc6_:ColorTransform=null;
     var _loc7_:Dynamic=undefined;
     hitMatrix= BambaAssets.hitMatrix();
     MC.boardMC.backMC.addChild(hitMatrix);
     hitMatrix.y=260;
     _loc6_=new ColorTransform();
     _loc7_=game.gameData.dictionary.COLORS.split(",");
     _loc6_.color=_loc7_[param2 - 1];
     hitMatrix.transform.colorTransform=_loc6_;
     _loc3_=0;
     while(_loc3_<4)
     {
        _loc4_=0;
        while(_loc4_<3)
        {
           _loc5_="x" + _loc3_ + "y" + _loc4_;
           hitMatrix[_loc5_].gotoAndStop("hide");
           _loc4_++;
        }
        _loc3_++;
     }
     _loc3_=0;
     while(_loc3_<param1.length)
     {
        _loc5_="x" + param1[_loc3_][0] + "y" + param1[_loc3_][1];
        hitMatrix[_loc5_].gotoAndStop("show");
        _loc3_++;
     }
  }
  
  public function startFight():Dynamic
  {
     noLife=0;
     MC.cardPickMC.visible=false;
     MC.boardMC.visible=true;
     me.playEneterAnim();
     game.sound.playEffect("MAZE_BATTLE");
     startAnimInterval=setInterval(enemyEnterAnim,1500);
  }
  
  public function setFighters():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     cardsPlayerCanUse=game.gameData.playerData.cards;
     if(enemyData.levelCards.length>0)
     {
        cardsEnemyCanUse=enemyData.cards.concat(enemyData.levelCards[enemyLevel - 1]);
     }
     else
     {
        cardsEnemyCanUse=enemyData.cards;
     }
     _loc1_=true;
     me=new BambaFighter(this,_loc1_);
     _loc1_=false;
     enemy=new BambaFighter(this,_loc1_);
  }
  
  public function animCards():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:BambaCard=null;
     var _loc3_:BambaCard=null;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     var _loc6_:Dynamic=undefined;
     var _loc7_:Dynamic=undefined;
     _loc1_=Math.floor(currStep / 2);
     if(_loc1_ !=0)
     {
        _loc4_=_loc1_;
        while(_loc4_<3)
        {
           _loc5_=cardFightLocationAndSize[_loc4_ - _loc1_][0];
           _loc6_=cardFightLocationAndSize[_loc4_ - _loc1_][1];
           _loc7_=cardFightLocationAndSize[_loc4_ - _loc1_][2];
           roundCards[_loc4_].setCardDir(me.dir);
           TweenLiteHaxe.to(roundCards[_loc4_].mc,0.6,{
              "x":_loc5_,
              "y":_loc6_,
              "scaleX":_loc7_,
              "scaleY":_loc7_
           });
           _loc5_=cardFightLocationAndSize[_loc4_ + 3 - _loc1_][0];
           _loc6_=cardFightLocationAndSize[_loc4_ + 3 - _loc1_][1];
           _loc7_=cardFightLocationAndSize[_loc4_ + 3 - _loc1_][2];
           roundCards[_loc4_ + 3].setCardDir(enemy.dir);
           TweenLiteHaxe.to(roundCards[_loc4_ + 3].mc,0.6,{
              "x":_loc5_,
              "y":_loc6_,
              "scaleX":_loc7_,
              "scaleY":_loc7_
           });
           _loc4_++;
        }
        MC.cardsFightMC.removeChild(roundCards[_loc1_ - 1].mc);
        MC.cardsFightMC.removeChild(roundCards[_loc1_ + 3 - 1].mc);
     }
     _loc2_=roundCards[_loc1_];
     _loc3_=roundCards[_loc1_ + 3];
     _loc2_.mc.frontMC.gotoAndStop("reg");
     _loc3_.mc.frontMC.gotoAndStop("reg");
     _loc2_.mc.gotoAndPlay("flip-left");
     _loc3_.mc.gotoAndPlay("flip-right");
     game.sound.playEffect("BATTLE_CARD_FLIP");
     animCardInterval=setInterval(playCardinStep,600);
  }
  
  public function setCardPick():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     cardPickedByPlayer=[0,0,0];
     costOfPickedCards=0;
     _loc1_=game.help.showTutorial(17);
     if(!_loc1_)
     {
        _loc1_=game.help.showTutorial(18);
     }
     _loc2_=0;
     _loc3_=0;
     _loc4_=0;
     while(_loc4_<cardsPlayerCanUse.length)
     {
        _loc5_=game.gameData.getCatalogCard(cardsPlayerCanUse[_loc4_]);
        _loc5_.generateMC(me.dir);
        _loc5_.addClickEvent(this);
        MC.cardPickMC.cardsPickBoardMC.addChild(_loc5_.mc);
        _loc5_.mc.scaleX=1;
        _loc5_.mc.scaleY=1;
        if(_loc5_.damage>0)
        {
           _loc5_.mc.x=cardUnPicksAttackLocation[_loc3_][0];
           _loc5_.mc.y=cardUnPicksAttackLocation[_loc3_][1];
           _loc3_++;
        }
        else
        {
           _loc5_.mc.x=cardUnPicksMoveLocation[_loc2_][0];
           _loc5_.mc.y=cardUnPicksMoveLocation[_loc2_][1];
           _loc2_++;
        }
        _loc4_++;
     }
     showCardPick();
     me.updateIconPos();
     enemy.updateIconPos();
  }
  
  public function nextStep():Dynamic
  {
     if(fightStatus==1)
     {
        ++currStep;
        if(currStep % 2==0)
        {
           me.updateScreenData();
           enemy.updateScreenData();
           nextStepContinueInterval=setInterval(nextStepContinue,game.gameData.barAnimLength * 1000);
        }
        else
        {
           nextStepContinue();
        }
     }
  }
  
  public function enemyEnterAnim():Dynamic
  {
     clearInterval(startAnimInterval);
     enemy.playEneterAnim();
     startAnimInterval=setInterval(setFightMusic,1500);
  }
  
  public function fightButtonClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        if(cardPickedByPlayer[0] * cardPickedByPlayer[1] * cardPickedByPlayer[2]>0)
        {
           roundCardsIds=[];
           roundCardsIds=roundCardsIds.concat(cardPickedByPlayer);
           roundCardsIds=roundCardsIds.concat(enemy.AI.returnSequence());
           startRoundAnim();
        }
        else
        {
           MsgBox.show(game.gameData.dictionary.FIGHT_MUST_PICK_3);
        }
     }
  }
  
   function endRound():Dynamic
  {
     me.regenerateMagic(game.gameData.playerData.roundRegeneration);
     enemy.regenerateMagic(enemyLevelData.roundRegeneration);
     me.updateScreenData();
     enemy.updateScreenData();
     me.setDefense(0);
     enemy.setDefense(0);
     MC.continueButtonParent.visible=true;
     MC.continueButtonParent.gotoAndPlay("up");
     MC.cardsFightMC.removeChild(roundCards[2].mc);
     MC.cardsFightMC.removeChild(roundCards[5].mc);
  }
  
   function setFightMusic():Dynamic
  {
     clearInterval(startAnimInterval);
     if(game.aDungeon !=undefined)
     {
        trace("game.aDungeon.dungeonData.fightMusic:" + game.aDungeon.dungeonData.fightMusic);
        game.sound.playMusic(game.aDungeon.dungeonData.fightMusic);
     }
     startAnimInterval=setInterval(showContinueAtStart,1500);
  }
  
  public function playCardinStep():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     var _loc3_:BambaCard=null;
     var _loc4_:BambaFighter=null;
     if(animCardInterval !=null)
     {
        clearInterval(animCardInterval);
     }
     _loc1_=Math.floor(currStep / 2);
     _loc2_=currStep % 2;
     if(_loc2_==0)
     {
        if(roundCards[_loc1_].damage<roundCards[_loc1_ + 3].damage)
        {
           _loc3_=roundCards[_loc1_];
           _loc4_=me;
        }
        else
        {
           _loc3_=roundCards[_loc1_ + 3];
           _loc4_=enemy;
        }
     }
     else if(roundCards[_loc1_].damage<roundCards[_loc1_ + 3].damage)
     {
        _loc3_=roundCards[_loc1_ + 3];
        _loc4_=enemy;
     }
     else
     {
        _loc3_=roundCards[_loc1_];
        _loc4_=me;
     }
     _loc4_.useCard(_loc3_);
     _loc3_.mc.frontMC.gotoAndStop("frame");
  }
  
  public function showCardPick():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     MC.cardPickMC.visible=true;
     MC.boardMC.visible=false;
     _loc1_=0;
     while(_loc1_<cardsPlayerCanUse.length)
     {
        _loc2_=game.gameData.getCatalogCard(cardsPlayerCanUse[_loc1_]);
        _loc2_.mc.visible=true;
        _loc2_.setCardDir(me.dir);
        _loc1_++;
     }
     disableExpensiveCards();
  }
   }