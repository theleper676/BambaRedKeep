package;

   import flash.display.*;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.*;
   import general.ButtonUpdater;
   import general.MsgBox;
   
   class BambaDungeon
   {
   var currBabyHideFrame:Float;
  
   var dungeonDifficulty:Float;
  
   var randomTileIdToJupmOnSurprise:Float;
  
  public var canPlay:Bool;
  
   var currBabyShowFrame:Float;
  
   var aFight:BambaFight;
  
   var calledChackTileAfterEnemyMove:Bool;
  
   var currSurprise:BambaSurprise;
  
   var dungeonDiceActions:Array<Dynamic>;
  
   var endDiceAnimInterval:Float;
  
   var dontDoJump:Bool;
  
   var dungeonMapMC:MovieClip;
  
   var usedAction:Bool;
  
   var possibleMoveIcons:Array<Dynamic>;
  
   var diceRolled:Bool;
  
   var dungeonId:Float;
  
   var dungeonIcons:Array<Dynamic>;
  
  public var dungeonData:BambaDungeonData;
  
   var MC:MovieClip;
  
   var currEndTile:Float;
  
   var me:BambaDungeonIcon;
  
   var dontSoundRoll:Bool;
  
  public var fightScreen:MovieClip;
  
   var possibleWaysToMove:Array<Dynamic>;
  
   var enemyId:Float;
  
   var currIcon:BambaDungeonIcon;
  
   var currDiceNum:Float;
  
  public var dungeonMC:MovieClip;
  
   var rollDiceAnimInterval:Float;
  
   var diceArraw:MovieClip;
  
   var game:MovieClip;
  
   var label:TextField;
  
  public function new(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic, param5:Dynamic, param6:Dynamic, param7:Dynamic, param8:Dynamic, param9:Dynamic)
  {
     var _loc10_:TextFormat=null;
     super();
     game=param1;
     MC=param2;
     dungeonId=param3;
     dungeonDifficulty=param4 - 1;
     dungeonData=game.gameData.getCatalogDungeonData(dungeonId);
     dungeonMapMC= BambaAssets.dungeonMap();
     MC.mapMC.addChild(dungeonMapMC);
     dungeonMC=MC.mapMC.getChildAt(MC.mapMC.numChildren - 1);
     enemyId=param5;
     if(dungeonData.dungeonIconsGib.length==0)
     {
        generateDungeonIcons(param6,param7,param8,param9);
     }
     else
     {
        loadDungeonIcons(param6,param7,param8,param9);
     }
     canPlay=true;
     dontSoundRoll=false;
     possibleMoveIcons=[];
     dungeonDiceActions=[1,1,1];
     MC.diceMC.addEventListener(MouseEvent.CLICK,rollDiceClicked);
     MC.diceMC.buttonMode=true;
     MC.diceMC.tabEnabled=false;
     MC.showCharacterMC.addEventListener(MouseEvent.CLICK,openCharacterWin);
     MC.showCharacterMC.buttonMode=true;
     MC.showCharacterMC.tabEnabled=false;
     ButtonUpdater.setButton(MC.exitMC,exitDungeonClicked);
     MC.rollAgainMC.addEventListener(MouseEvent.CLICK,rollAgainClicked);
     MC.rollAgainMC.buttonMode=true;
     MC.rollAgainMC.tabEnabled=false;
     MC.plusOneMC.addEventListener(MouseEvent.CLICK,plusOneClicked);
     MC.plusOneMC.buttonMode=true;
     MC.plusOneMC.tabEnabled=false;
     MC.minusOneMC.addEventListener(MouseEvent.CLICK,minusOneClicked);
     MC.minusOneMC.buttonMode=true;
     MC.minusOneMC.tabEnabled=false;
     showDiceArraw();
     MC.exitSpecialMC.gotoAndPlay("reg");
     label=new TextField();
     label.autoSize=TextFieldAutoSize.LEFT;
    (_loc10_=new TextFormat()).font="Arial";
     _loc10_.color=0;
     _loc10_.size=10;
     label.defaultTextFormat=_loc10_;
     currDiceNum=6;
     MC.addChild(label);
  }
  
   function removePossibleIcons():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     _loc1_=0;
     while(_loc1_<possibleMoveIcons.length)
     {
        _loc2_=possibleMoveIcons[_loc1_];
        _loc2_.removeEventListener(MouseEvent.CLICK,pickMoveIcon);
        MC.mapMC.removeChild(_loc2_);
        _loc1_++;
     }
     possibleMoveIcons=[];
  }
  
   function closeCharacterWin():Void
  {
     game.hideCharacter();
  }
  
   function pathFinish():Dynamic
  {
     checkTile();
  }
  
   function openTreasure(param1:Dynamic, param2:Dynamic):Dynamic
  {
     var _loc3_:String=null;
     var _loc4_:Array<Dynamic>=null;
     var _loc5_:Dynamic=undefined;
     var _loc6_:Dynamic=undefined;
     game.sound.playEffect("MAZE_TREASURE");
     if(param2)
     {
        _loc3_="מצאת אוצר!";
     }
     else
     {
        _loc3_=game.gameData.dictionary.FOUND_TREASURE_MSG;
        dungeonIcons.splice(dungeonIcons.indexOf(currIcon),1);
        if(dungeonMC.lowerMC.contains(currIcon.iconGraphics))
        {
           dungeonMC.lowerMC.removeChild(currIcon.iconGraphics);
        }
        if(dungeonMC.uperMC.contains(currIcon.iconGraphics))
        {
           dungeonMC.uperMC.removeChild(currIcon.iconGraphics);
        }
     }
     _loc5_=0;
     _loc6_=3;
     _loc4_=game.gameData.playerData.addPrizes(_loc5_,param1,_loc6_);
     MsgBox.showWin(_loc3_,_loc4_,closeTreasureMsg);
  }
  
   function plusOneClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        if(diceRolled && !usedAction)
        {
           if(dungeonDiceActions[1]>0)
           {
              game.sound.playEffect("MAZE_ROLL_ONE_MORE");
              usedAction=true;
              --dungeonDiceActions[1];
              showPossibleIcons(currDiceNum + 1);
              if(dungeonDiceActions[1]==0)
              {
                 MC.plusOneMC.gotoAndStop(2);
              }
           }
        }
     }
  }
  
   function moveEnemies():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     var _loc6_:Dynamic=undefined;
     var _loc7_:Dynamic=undefined;
     if(dungeonMC.lowerMC.contains(me.iconGraphics))
     {
        dungeonMC.lowerMC.setChildIndex(me.iconGraphics,0);
     }
     if(dungeonMC.uperMC.contains(me.iconGraphics))
     {
        dungeonMC.uperMC.setChildIndex(me.iconGraphics,0);
     }
     _loc1_=false;
     _loc2_=0;
     while(_loc2_<dungeonIcons.length)
     {
        if(dungeonIcons[_loc2_].type==2)
        {
           _loc3_=[];
           _loc3_=_loc3_.concat(dungeonData.getTile(dungeonIcons[_loc2_].currTileId).links);
           _loc4_=false;
           while(!_loc4_)
           {
              if(_loc3_.length>0)
              {
                 _loc5_=_loc3_[Math.floor(Math.random()* _loc3_.length)];
                 _loc3_.splice(_loc3_.indexOf(_loc5_),1);
                 _loc6_=true;
                 if(_loc5_==dungeonData.startTile)
                 {
                    _loc6_=false;
                 }
                 else
                 {
                    _loc7_=0;
                    while(_loc7_<dungeonIcons.length)
                    {
                       if(_loc5_==dungeonIcons[_loc7_].currTileId)
                       {
                          if(dungeonIcons[_loc7_].type !=1)
                          {
                             _loc6_=false;
                             break;
                          }
                       }
                       _loc7_++;
                    }
                 }
                 if(_loc6_)
                 {
                    dungeonIcons[_loc2_].jumpToTile(_loc5_);
                    _loc4_=true;
                    _loc1_=true;
                 }
              }
              else
              {
                 _loc4_=true;
              }
           }
        }
        _loc2_++;
     }
     if(!_loc1_)
     {
        enemyMoveFinish();
     }
  }
  
   function continueDiceAnim():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     clearInterval(rollDiceAnimInterval);
     _loc1_="in" + currDiceNum;
     MC.diceMC.gotoAndPlay(_loc1_);
  }
  
   function pickMoveIcon(param1:MouseEvent):Void
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     if(!game.msgShown)
     {
        canPlay=false;
        diceRolled=false;
        usedAction=false;
        _loc2_=0;
        while(_loc2_<possibleMoveIcons.length)
        {
           _loc3_=possibleMoveIcons[_loc2_];
           if(_loc3_==param1.currentTarget)
           {
              break;
           }
           _loc2_++;
        }
        removePossibleIcons();
        me.moveInPath(possibleWaysToMove[_loc2_]);
     }
  }
  
   function showSurpriseMsgBox():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Bool=false;
     _loc1_=currSurprise.sDesc;
     switch(currSurprise.type)
     {
        case 3:
           _loc2_=currSurprise.prizesIds[Math.floor(Math.random()* currSurprise.prizesIds.length)];
           _loc3_=game.gameData.playerData.addPrizes(0,_loc2_,3);
           _loc1_=_loc1_ + " " + -_loc3_[3] + " " + game.gameData.dictionary.MONEY_NAME;
           MsgBox.show(_loc1_,closeSurpriseMsgBox,currSurprise.type);
           break;
        case 4:
           _loc4_=true;
           _loc2_=currSurprise.prizesIds[Math.floor(Math.random()* currSurprise.prizesIds.length)];
           openTreasure(_loc2_,_loc4_);
           break;
        default:
           MsgBox.show(_loc1_,closeSurpriseMsgBox,currSurprise.type);
     }
  }
  
   function checkAnim(param1:Event):Void
  {
     if(param1.currentTarget.currentFrame==currBabyHideFrame)
     {
        hideMe();
     }
     if(param1.currentTarget.currentFrame==currBabyShowFrame || param1.currentTarget.currentFrame==param1.currentTarget.totalFrames)
     {
        showMe(currEndTile);
        param1.currentTarget.removeEventListener(Event.ENTER_FRAME,checkAnim);
     }
  }
  
   function closeTreasureMsg():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     _loc1_=false;
     if(currIcon.isSpecial)
     {
        _loc1_=game.questManager.reportQuestCompleted(4);
     }
     if(!_loc1_)
     {
        checkTile();
     }
  }
  
   function showPossibleIcons(param1:Float):Dynamic
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Array<Dynamic>=null;
     var _loc5_:Float=NaN;
     var _loc6_:Dynamic=undefined;
     possibleWaysToMove=dungeonData.getPossibleWays(me.currTileId,param1);
     removePossibleIcons();
     _loc2_=0;
     while(_loc2_<possibleWaysToMove.length)
     {
        _loc3_= BambaAssets.possibleMove();
        MC.mapMC.addChild(_loc3_);
        possibleMoveIcons.push(_loc3_);
        _loc4_=possibleWaysToMove[_loc2_].split(",");
        _loc5_=Std.parseFloat(_loc4_[_loc4_.length - 1]);
        _loc6_=dungeonData.getTile(_loc5_);
        _loc3_.x=_loc6_.x;
        _loc3_.y=_loc6_.y;
        ButtonUpdater.setButton(_loc3_,pickMoveIcon);
        _loc2_++;
     }
  }
  
   function openSurprise(param1:Dynamic):Dynamic
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     game.sound.playEffect("MAZE_SURPRIZE");
     currSurprise=game.gameData.getCatalogSurprise(param1);
     dungeonIcons.splice(dungeonIcons.indexOf(currIcon),1);
     if(dungeonMC.lowerMC.contains(currIcon.iconGraphics))
     {
        dungeonMC.lowerMC.removeChild(currIcon.iconGraphics);
     }
     if(dungeonMC.uperMC.contains(currIcon.iconGraphics))
     {
        dungeonMC.uperMC.removeChild(currIcon.iconGraphics);
     }
     switch(currSurprise.type)
     {
        case 1:
           _loc2_=[];
           _loc3_=0;
           while(_loc3_<dungeonData.tiles.length)
           {
              _loc4_=true;
              _loc5_=0;
              while(_loc5_<dungeonIcons.length)
              {
                 if(dungeonData.tiles[_loc3_].id==dungeonIcons[_loc5_].currTileId)
                 {
                    _loc4_=false;
                 }
                 _loc5_++;
              }
              if(_loc4_)
              {
                 _loc2_.push(dungeonData.tiles[_loc3_].id);
              }
              _loc3_++;
           }
           randomTileIdToJupmOnSurprise=_loc2_[Math.floor(Math.random()* _loc2_.length)];
           showSurpriseMsgBox();
           break;
        case 2:
           showSurpriseMsgBox();
           break;
        case 3:
           showSurpriseMsgBox();
           break;
        case 4:
           showSurpriseMsgBox();
     }
  }
  
   function openCharacterWin(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        game.showCharacter();
     }
  }
  
   function jumpFinish(param1:Dynamic):Dynamic
  {
     if(param1==false)
     {
        dontDoJump=true;
     }
     checkTile();
  }
  
   function endDiceAnim():Dynamic
  {
     clearInterval(endDiceAnimInterval);
     showPossibleIcons(currDiceNum);
  }
  
   function enemyMoveFinish():Dynamic
  {
     if(!calledChackTileAfterEnemyMove)
     {
        game.help.showTutorial(7);
        dontDoJump=true;
        calledChackTileAfterEnemyMove=true;
        checkTile();
     }
  }
  
   function minusOneClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        if(diceRolled && !usedAction)
        {
           if(dungeonDiceActions[2]>0)
           {
              game.sound.playEffect("MAZE_ROLL_ONE_LESS");
              usedAction=true;
              --dungeonDiceActions[2];
              showPossibleIcons(currDiceNum - 1);
              if(dungeonDiceActions[2]==0)
              {
                 MC.minusOneMC.gotoAndStop(2);
              }
           }
        }
     }
  }
  
   function showDiceArraw():Dynamic
  {
     hideDiceArraw();
     diceArraw= BambaAssets.possibleMove();
     MC.addChild(diceArraw);
     diceArraw.x=Math.floor(MC.diceMC.x + MC.diceMC.width / 2);
     diceArraw.y=Math.floor(MC.diceMC.y + 5);
     diceArraw.addEventListener(MouseEvent.CLICK,rollDiceClicked);
     MC.setChildIndex(MC.diceMC,MC.numChildren - 1);
     MC.setChildIndex(diceArraw,MC.numChildren - 2);
  }
  
   function hideMe():Dynamic
  {
     trace("hideMe");
     if(dungeonMC.lowerMC.contains(me.iconGraphics))
     {
        dungeonMC.lowerMC.removeChild(me.iconGraphics);
     }
     if(dungeonMC.uperMC.contains(me.iconGraphics))
     {
        dungeonMC.uperMC.removeChild(me.iconGraphics);
     }
  }
  
   function showMe(param1:Dynamic):Dynamic
  {
     trace("showMe");
     if(me.currLevel==1)
     {
        dungeonMC.lowerMC.addChild(me.iconGraphics);
     }
     else
     {
        dungeonMC.uperMC.addChild(me.iconGraphics);
     }
     me.iconGraphics.scaleX=1;
     me.setTile(param1);
     me.setLevel();
     jumpFinish(false);
  }
  
   function showExitSpecial():Dynamic
  {
     MC.exitSpecialMC.gotoAndPlay("special");
  }
  
   function removeFightMC():Dynamic
  {
     if(fightScreen !=null)
     {
        if(MC.contains(fightScreen))
        {
           MC.removeChild(fightScreen);
        }
     }
     aFight=null;
  }
  
   function loadDungeonIcons(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic):Dynamic
  {
     var _loc5_:Dynamic=undefined;
     dungeonIcons=[];
     _loc5_=0;
     while(_loc5_<dungeonData.dungeonIconsGib.length)
     {
        dungeonData.dungeonIconsGib[_loc5_].setDungeon(this);
        if(dungeonData.dungeonIconsGib[_loc5_].type==1)
        {
           me=dungeonData.dungeonIconsGib[_loc5_];
           me.setTile(dungeonData.startTile);
        }
        dungeonIcons.push(dungeonData.dungeonIconsGib[_loc5_]);
        if(dungeonData.dungeonIconsGib[_loc5_].currLevel==1)
        {
           dungeonMC.lowerMC.addChild(dungeonData.dungeonIconsGib[_loc5_].iconGraphics);
        }
        else
        {
           dungeonMC.uperMC.addChild(dungeonData.dungeonIconsGib[_loc5_].iconGraphics);
        }
        if(param1 || param2 || param3 || param4)
        {
           if(dungeonData.dungeonIconsGib[_loc5_].isSpecial)
           {
              dungeonData.dungeonIconsGib[_loc5_].markSpecial(true);
           }
           else
           {
              dungeonData.dungeonIconsGib[_loc5_].markSpecial(false);
           }
        }
        else
        {
           dungeonData.dungeonIconsGib[_loc5_].markSpecial(false);
        }
        _loc5_++;
     }
     if(dungeonMC.lowerMC.contains(me.iconGraphics))
     {
        dungeonMC.lowerMC.setChildIndex(me.iconGraphics,dungeonMC.lowerMC.numChildren - 1);
     }
     if(dungeonMC.uperMC.contains(me.iconGraphics))
     {
        dungeonMC.uperMC.setChildIndex(me.iconGraphics,dungeonMC.uperMC.numChildren - 1);
     }
  }
  
   function generateDungeonIcons(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic):Dynamic
  {
     var _loc5_:Dynamic=undefined;
     var _loc6_:BambaDungeonIcon=null;
     var _loc7_:Dynamic=undefined;
     var _loc8_:Float=NaN;
     var _loc9_:Dynamic=undefined;
     dungeonIcons=[];
     _loc9_=[];
     _loc5_=0;
     while(_loc5_<dungeonData.tiles.length)
     {
        _loc9_.push(dungeonData.tiles[_loc5_].id);
        _loc5_++;
     }
     me=new BambaDungeonIcon(this,1);
     dungeonMC.lowerMC.addChild(me.iconGraphics);
     me.setTile(dungeonData.startTile);
     _loc9_.splice(_loc9_.indexOf(me.currTileId),1);
     dungeonIcons.push(me);
     if(!isNaN(enemyId))
     {
        if(dungeonData.bossTile !=0)
        {
           _loc6_=new BambaDungeonIcon(this,3);
           dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
           _loc6_.setTile(dungeonData.bossTile);
           dungeonIcons.push(_loc6_);
           _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId),1);
           _loc6_.markSpecial(false);
           if(param3)
           {
              _loc6_.markSpecial(true);
           }
           if(param2)
           {
              _loc6_.markSpecial(true);
           }
        }
        _loc7_=param1;
        _loc5_=0;
        while(_loc5_<dungeonData.difficultiesData[dungeonDifficulty][0])
        {
           _loc6_=new BambaDungeonIcon(this,2);
           dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
           _loc8_=Std.parseFloat(_loc9_[Math.floor(Math.random()* _loc9_.length)]);
           _loc6_.setTile(_loc8_);
           dungeonIcons.push(_loc6_);
           _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId),1);
           _loc6_.markSpecial(false);
           if(_loc7_)
           {
              _loc7_=false;
              _loc6_.markSpecial(true);
           }
           if(param3)
           {
              _loc6_.markSpecial(true);
           }
           _loc5_++;
        }
     }
     _loc7_=param4;
     _loc5_=0;
     while(_loc5_<dungeonData.difficultiesData[dungeonDifficulty][1])
     {
        _loc6_=new BambaDungeonIcon(this,4);
        dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
        _loc8_=Std.parseFloat(_loc9_[Math.floor(Math.random()* _loc9_.length)]);
        _loc6_.setTile(_loc8_);
        dungeonIcons.push(_loc6_);
        _loc6_.markSpecial(false);
        if(_loc7_)
        {
           _loc7_=false;
           _loc6_.markSpecial(true);
           if(game.help.currTutorialCode==5)
           {
              _loc6_.setTile(17);
           }
        }
        _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId),1);
        _loc5_++;
     }
     _loc5_=0;
     while(_loc5_<dungeonData.difficultiesData[dungeonDifficulty][2])
     {
        _loc6_=new BambaDungeonIcon(this,5);
        dungeonMC.lowerMC.addChild(_loc6_.iconGraphics);
        _loc8_=Std.parseFloat(_loc9_[Math.floor(Math.random()* _loc9_.length)]);
        _loc6_.setTile(_loc8_);
        dungeonIcons.push(_loc6_);
        _loc9_.splice(_loc9_.indexOf(_loc6_.currTileId),1);
        _loc5_++;
     }
     if(me.currLevel==1)
     {
        dungeonMC.lowerMC.setChildIndex(me.iconGraphics,dungeonMC.lowerMC.numChildren - 1);
     }
     else
     {
        dungeonMC.uperMC.setChildIndex(me.iconGraphics,dungeonMC.uperMC.numChildren - 1);
     }
  }
  
   function showMazePlan(param1:MouseEvent):Void
  {
     dungeonData.drawDungeon(MC.mapMC);
  }
  
   function exitDungeon():Dynamic
  {
     clearFight();
     removeFightMC();
     dungeonData.saveDungeonIconsGib(dungeonIcons,enemyId,dungeonDifficulty + 1);
     game.closeDungeon();
  }
  
   function showXY(param1:MouseEvent):Void
  {
     label.x=MC.mouseX;
     label.y=MC.mouseY + 10;
     label.text=Std.string(MC.mapMC.mouseX + "," + MC.mapMC.mouseY);
  }
  
   function rollDice():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     if(canPlay)
     {
        if(!diceRolled && !usedAction)
        {
           hideDiceArraw();
           if(!dontSoundRoll)
           {
              game.sound.playEffect("MAZE_CUBE");
           }
           else
           {
              dontSoundRoll=false;
           }
           diceRolled=true;
           if(dungeonMC.lowerMC.contains(me.iconGraphics))
           {
              dungeonMC.lowerMC.setChildIndex(me.iconGraphics,dungeonMC.lowerMC.numChildren - 1);
           }
           if(dungeonMC.uperMC.contains(me.iconGraphics))
           {
              dungeonMC.uperMC.setChildIndex(me.iconGraphics,dungeonMC.uperMC.numChildren - 1);
           }
           dontDoJump=false;
           calledChackTileAfterEnemyMove=false;
           _loc1_="out" + currDiceNum;
           currDiceNum=Math.floor(Math.random()* 6)+ 1;
           rollDiceAnimInterval=setInterval(continueDiceAnim,160);
           endDiceAnimInterval=setInterval(endDiceAnim,1100);
           MC.diceMC.gotoAndPlay(_loc1_);
        }
     }
  }
  
   function rollDiceClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        rollDice();
     }
  }
  
   function hideDiceArraw():Dynamic
  {
     if(diceArraw !=null)
     {
        if(MC.contains(diceArraw))
        {
           MC.removeChild(diceArraw);
        }
     }
  }
  
   function clearFight():Dynamic
  {
     trace("clearFight:" + aFight);
     if(aFight !=null)
     {
        aFight.resetFightVars();
        aFight.clearEvents();
     }
  }
  
   function rollAgainClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        if(diceRolled && !usedAction)
        {
           if(dungeonDiceActions[0]>0)
           {
              game.sound.playEffect("MAZE_ROLL_AGAIN");
              dontSoundRoll=true;
              --dungeonDiceActions[0];
              if(dungeonDiceActions[0]==0)
              {
                 MC.rollAgainMC.gotoAndStop(2);
              }
              diceRolled=false;
              rollDice();
              usedAction=true;
           }
        }
     }
  }
  
   function clearEvents():Dynamic
  {
     MC.diceMC.removeEventListener(MouseEvent.CLICK,rollDiceClicked);
     MC.showCharacterMC.removeEventListener(MouseEvent.CLICK,openCharacterWin);
     MC.exitMC.removeEventListener(MouseEvent.CLICK,exitDungeonClicked);
     MC.rollAgainMC.removeEventListener(MouseEvent.CLICK,rollAgainClicked);
     MC.plusOneMC.removeEventListener(MouseEvent.CLICK,plusOneClicked);
     MC.minusOneMC.removeEventListener(MouseEvent.CLICK,minusOneClicked);
     MC.mapMC.removeEventListener(MouseEvent.CLICK,showXY);
  }
  
   function checkTile():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Int=null;
     var _loc3_:Float=NaN;
     var _loc4_:Float=NaN;
     var _loc5_:Float=NaN;
     var _loc6_:Array<Dynamic>=null;
     var _loc7_:Dynamic=undefined;
     var _loc8_:Array<Dynamic>=null;
     var _loc9_:Dynamic=undefined;
     var _loc10_:Dynamic=undefined;
     var _loc11_:Dynamic=undefined;
     var _loc12_:Dynamic=undefined;
     _loc1_=true;
     _loc2_=0;
     for (_loc2_ in 0...dungeonIcons.length)
     {
        if(me.currTileId !=dungeonIcons[_loc2_].currTileId)
        {
           continue;
        }
        currIcon=dungeonIcons[_loc2_];
        switch(dungeonIcons[_loc2_].type)
        {
           case 2:
              _loc1_=false;
              _loc3_=1;
              setFight(enemyId,_loc3_,dungeonIcons[_loc2_].enemyLevel);
              break;
           case 3:
              _loc1_=false;
              _loc3_=2;
              setFight(enemyId,_loc3_,dungeonIcons[_loc2_].enemyLevel);
              break;
           case 4:
              _loc1_=false;
              _loc6_=dungeonData.difficultiesData[dungeonDifficulty][3];
              _loc4_=Std.parseFloat(_loc6_[Math.floor(Math.random()* _loc6_.length)]);
              _loc7_=false;
              openTreasure(_loc4_,_loc7_);
              break;
           case 5:
              _loc1_=false;
              _loc8_=dungeonData.difficultiesData[dungeonDifficulty][4];
              _loc5_=Std.parseFloat(_loc8_[Math.floor(Math.random()* _loc8_.length)]);
              openSurprise(_loc5_);
              break;
        }
     }
     if(!calledChackTileAfterEnemyMove)
     {
        if(_loc1_)
        {
           _loc9_=dungeonData.getTile(me.currTileId);
           if(_loc9_.jump==0)
           {
              moveEnemies();
           }
           else if(!dontDoJump)
           {
              _loc10_=false;
              _loc11_=0;
              while(_loc11_<dungeonData.anims.length)
              {
                 if(dungeonData.anims[_loc11_][0]==_loc9_.id)
                 {
                    _loc10_=true;
                    break;
                 }
                 _loc11_++;
              }
              if(_loc10_)
              {
                 _loc12_=dungeonData.anims[_loc11_][1];
                 dungeonMapMC[_loc12_].gotoAndPlay(2);
                 game.sound.playEffect("MAZE_SHORTCUT");
                 me.iconGraphics.scaleX=1;
                 currBabyHideFrame=dungeonData.anims[_loc11_][2];
                 currBabyShowFrame=dungeonData.anims[_loc11_][3];
                 currEndTile=_loc9_.jump;
                 dungeonMapMC[_loc12_].addEventListener(Event.ENTER_FRAME,checkAnim);
              }
              else
              {
                 me.jumpToTile(_loc9_.jump);
              }
           }
           else
           {
              moveEnemies();
           }
        }
     }
     else if(_loc1_)
     {
        canPlay=true;
        showDiceArraw();
     }
  }
  
   function setFight(param1:Dynamic, param2:Dynamic, param3:Dynamic):Dynamic
  {
     fightScreen= BambaAssets.fightScreen();
     MC.addChild(fightScreen);
     fightScreen.cardPickMC.visible=true;
     fightScreen.boardMC.visible=false;
     clearFight();
     aFight=new BambaFight(game,fightScreen,param1,param2,param3);
     game.sound.playEffect("MAZE_BATTLE");
     game.sound.stopMusic();
  }
  
   function lostDungeonExitMsgBox():Dynamic
  {
     me.changeAndForceLevel(2);
     me.jumpToTile(dungeonData.startTile,false,2);
  }
  
   function playDungeonMusic():Dynamic
  {
     game.sound.playMusic(dungeonData.music);
  }
  
   function exitDungeonClicked(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        game.sound.playEffect("GENERAL_MENU_CLICK");
        exitDungeon();
     }
  }
  
   function closeSurpriseMsgBox():Void
  {
     var _loc1_:Bool=false;
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     _loc1_=true;
     switch(currSurprise.type)
     {
        case 1:
           me.changeAndForceLevel(2);
           me.jumpToTile(randomTileIdToJupmOnSurprise,_loc1_);
           break;
        case 2:
           _loc3_=1;
           _loc4_=game.gameData.dungeonDifficulties[dungeonDifficulty][_loc3_ - 1];
           _loc5_=game.gameData.playerData.level + Std.parseFloat(_loc4_[Math.floor(Math.random()* _loc4_.length)]);
           if(_loc5_<game.gameData.minEnemyLevel)
           {
              _loc5_=game.gameData.minEnemyLevel;
           }
           if(_loc5_>game.gameData.maxEnemyLevel)
           {
              _loc5_=game.gameData.maxEnemyLevel;
           }
           setFight(enemyId,_loc3_,_loc5_);
           break;
        case 3:
           canPlay=true;
           checkTile();
     }
  }
  
   function endFight(param1:Dynamic):Dynamic
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     playDungeonMusic();
     removeFightMC();
     _loc2_=false;
     switch(param1)
     {
        case 2:
           if(currIcon.isSpecial)
           {
              _loc2_=game.questManager.reportQuestCompleted(1);
           }
           if(currIcon.type==3)
           {
              _loc2_=game.questManager.reportQuestCompleted(2);
           }
           if(currIcon.type !=5)
           {
              dungeonIcons.splice(dungeonIcons.indexOf(currIcon),1);
              if(dungeonMC.lowerMC.contains(currIcon.iconGraphics))
              {
                 dungeonMC.lowerMC.removeChild(currIcon.iconGraphics);
              }
              if(dungeonMC.uperMC.contains(currIcon.iconGraphics))
              {
                 dungeonMC.uperMC.removeChild(currIcon.iconGraphics);
              }
           }
           _loc3_=0;
           _loc4_=0;
           while(_loc4_<dungeonIcons.length)
           {
              if(dungeonIcons[_loc4_].type==2 || dungeonIcons[_loc4_].type==3)
              {
                 _loc3_++;
              }
              _loc4_++;
           }
           if(_loc3_==0)
           {
              _loc2_=game.questManager.reportQuestCompleted(3);
           }
           if(!_loc2_)
           {
              checkTile();
           }
           break;
        default:
           lostDungeon();
     }
  }
  
   function lostDungeon():Dynamic
  {
     MsgBox.show(game.gameData.dictionary.CLOSE_DUNGEON_MSG,lostDungeonExitMsgBox);
  }
   }