package;

   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.utils.*;
   
   class BambaMap
   {
   var dungeons:Array<Dynamic>;
  
   var areas:Array<Dynamic>;
  
   var game:MovieClip;
  
   var mapAnimInterval:Float;
  
   var mc:MovieClip;
  
   var firstTime:Bool;
  
   var mapIcons:Array<Dynamic>;
  
   var currDungeonId:Float;
  
   var areasShown:Array<Dynamic>;
  
   var canWalk:Bool;
  
   var addDungeonInterval:Float;
  
  public function new(param1:Dynamic)
  {
     super();
     game=param1;
     mc= BambaAssets.kingdomMap();
     mc.orgWidth=mc.width;
     mc.orgHeight=mc.height;
     mc.towerMC.addEventListener(MouseEvent.CLICK,towerClicked);
     mc.towerMC.buttonMode=true;
     mc.towerMC.tabEnabled=false;
     areas=game.gameData.mapData.areas;
     dungeons=game.gameData.mapData.dungeons;
     mc.showCharacterMC.addEventListener(MouseEvent.CLICK,openCharacterWin);
     mc.showCharacterMC.buttonMode=true;
     mc.showCharacterMC.tabEnabled=false;
     resetMap();
  }
  
  public function update():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     if(game.questManager.currQuestDungeonId !=0)
     {
        _loc1_=0;
        while(_loc1_<mapIcons.length)
        {
           if(mapIcons[_loc1_].dongeonId==game.questManager.currQuestDungeonId)
           {
              mapIcons[_loc1_].specialMC.gotoAndPlay(2);
           }
           else
           {
              mapIcons[_loc1_].specialMC.gotoAndStop(1);
           }
           _loc1_++;
        }
        mc.towerMC.specialMC.gotoAndStop(1);
     }
     else
     {
        mc.towerMC.specialMC.gotoAndPlay(2);
        _loc1_=0;
        while(_loc1_<mapIcons.length)
        {
           mapIcons[_loc1_].specialMC.gotoAndStop(1);
           _loc1_++;
        }
     }
  }
  
   function dongeonClicked(param1:MouseEvent):Void
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     var _loc6_:String=null;
     var _loc7_:Dynamic=undefined;
     var _loc8_:Dynamic=undefined;
     if(!game.msgShown)
     {
        if(canWalk)
        {
           game.msgShown=true;
           canWalk=false;
           if(currDungeonId==param1.currentTarget.dongeonId)
           {
              afterDongeonClickedAnim();
           }
           else if(currDungeonId==0)
           {
              _loc4_=param1.currentTarget.dongeonId;
              _loc3_=currDungeonId + "to" + _loc4_;
              mc.mapAnimMC.gotoAndPlay(_loc3_);
              currDungeonId=_loc4_;
              _loc5_=getAnimTime(_loc3_);
              mapAnimInterval=setInterval(afterDongeonClickedAnim,_loc5_);
              game.sound.playEffect("MAP_MOVEMENT");
           }
           else
           {
              _loc7_=false;
              _loc4_=param1.currentTarget.dongeonId;
              _loc3_=currDungeonId + "to" + _loc4_;
              _loc5_=getAnimTime(_loc3_);
              _loc8_=0;
              while(_loc8_<game.gameData.mapTrails.length)
              {
                 if(_loc3_==game.gameData.mapTrails[_loc8_])
                 {
                    _loc7_=true;
                    break;
                 }
                 _loc8_++;
              }
              if(_loc7_)
              {
                 mc.mapAnimMC.gotoAndPlay(_loc3_);
                 currDungeonId=_loc4_;
                 mapAnimInterval=setInterval(afterDongeonClickedAnim,_loc5_);
                 game.sound.playEffect("MAP_MOVEMENT");
              }
              else
              {
                 _loc3_=currDungeonId + "to0";
                 _loc5_=getAnimTime(_loc3_);
                 mc.mapAnimMC.gotoAndPlay(_loc3_);
                 currDungeonId=_loc4_;
                 mapAnimInterval=setInterval(secondMove,_loc5_);
                 game.sound.playEffect("MAP_MOVEMENT");
              }
           }
        }
     }
  }
  
   function dongeonRollOver(param1:MouseEvent):Void
  {
     var _loc2_:Dynamic=undefined;
     if(!game.msgShown)
     {
        _loc2_=game.gameData.getCatalogDungeonData(param1.currentTarget.dongeonId);
        param1.currentTarget.iconMC.gotoAndStop(2);
        param1.currentTarget.iconMC.DT.text=_loc2_.dName;
     }
  }
  
   function afterTowerClickedAnim():Dynamic
  {
     currDungeonId=0;
     clearInterval(mapAnimInterval);
     canWalk=true;
     game.msgShown=false;
     game.sound.stopEffects();
     game.showTower();
  }
  
   function setMap():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     canWalk=true;
     mapIcons=[];
     while(mc.iconsMC.numChildren>0)
     {
        mc.iconsMC.removeChildAt(0);
     }
     _loc1_=0;
     while(_loc1_<areas.length)
     {
        _loc4_=false;
        _loc2_=0;
        while(_loc2_<game.gameData.playerData.pastDungeonsIds.length)
        {
           _loc3_=game.gameData.getCatalogDungeonData(game.gameData.playerData.pastDungeonsIds[_loc2_]);
           if(areas[_loc1_][0]==_loc3_.areaCode)
           {
              _loc4_=true;
              if(areasShown.indexOf(areas[_loc1_][0])==-1 && !firstTime)
              {
                 addDungeonIcon(_loc3_.id);
                 mapIcons[mapIcons.length - 1].visible=false;
                 addDungeonInterval=setInterval(showAllDungeons,1500);
              }
              else
              {
                 if(game.help.currTutorialCode==4)
                 {
                    game.help.finishTutorial();
                 }
                 addDungeonIcon(_loc3_.id);
              }
           }
           _loc2_++;
        }
        if(areas[_loc1_][0]==1)
        {
           _loc4_=true;
        }
        if(_loc4_)
        {
           if(firstTime)
           {
              mc[areas[_loc1_][2]].gotoAndStop("show");
              areasShown.push(areas[_loc1_][0]);
           }
           else if(areasShown.indexOf(areas[_loc1_][0])!=-1)
           {
              mc[areas[_loc1_][2]].gotoAndStop("show");
           }
           else
           {
              mc[areas[_loc1_][2]].gotoAndPlay("show-anim");
              areasShown.push(areas[_loc1_][0]);
              game.sound.playEffect("MAP_REVEAL");
           }
        }
        else
        {
           mc[areas[_loc1_][2]].gotoAndStop("hide");
        }
        _loc1_++;
     }
     if(firstTime)
     {
        currDungeonId=0;
        firstTime=false;
     }
     update();
  }
  
  public function resetMap():Dynamic
  {
     areasShown=[];
     firstTime=true;
     setMap();
  }
  
   function getAnimTime(param1:String):Float
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     _loc2_=game.gameData.mapTimeDef * 1000;
     _loc3_=0;
     while(_loc3_<game.gameData.mapTimes.length)
     {
        if(param1==game.gameData.mapTimes[_loc3_][0])
        {
           _loc2_=game.gameData.mapTimes[_loc3_][1] * 1000;
           break;
        }
        _loc3_++;
     }
     return _loc2_;
  }
  
   function setBabyAtTower():Dynamic
  {
     mc.mapAnimMC.gotoAndStop(1);
     currDungeonId=0;
  }
  
   function dongeonRollOut(param1:MouseEvent):Void
  {
     param1.currentTarget.iconMC.gotoAndStop(1);
     param1.currentTarget.iconMC.DT.text="";
  }
  
   function secondMove():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     var _loc2_:Dynamic=undefined;
     clearInterval(mapAnimInterval);
     _loc1_="0to" + currDungeonId;
     _loc2_=getAnimTime(_loc1_);
     mc.mapAnimMC.gotoAndPlay(_loc1_);
     mapAnimInterval=setInterval(afterDongeonClickedAnim,_loc2_);
     game.sound.playEffect("MAP_MOVEMENT");
  }
  
   function openCharacterWin(param1:MouseEvent):Void
  {
     if(!game.msgShown)
     {
        game.showCharacter();
     }
  }
  
   function towerClicked(param1:MouseEvent):Void
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     if(!game.msgShown)
     {
        if(canWalk)
        {
           canWalk=false;
           game.msgShown=true;
           if(currDungeonId==0)
           {
              afterTowerClickedAnim();
           }
           else
           {
              _loc2_=currDungeonId + "to0";
              _loc3_=getAnimTime(_loc2_);
              mc.mapAnimMC.gotoAndPlay(_loc2_);
              mapAnimInterval=setInterval(afterTowerClickedAnim,_loc3_);
              game.sound.playEffect("MAP_MOVEMENT");
           }
        }
     }
  }
  
   function addDungeonIcon(param1:Dynamic):Dynamic
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     _loc2_=game.gameData.getCatalogDungeonData(param1);
     _loc3_= BambaAssets.mapIcon();
     mc.iconsMC.addChild(_loc3_);
     _loc3_.dongeonId=param1;
     _loc4_=0;
     _loc5_=0;
     while(_loc5_<dungeons.length)
     {
        if(dungeons[_loc5_][0]==param1)
        {
           _loc4_=_loc5_;
        }
        _loc5_++;
     }
     _loc3_.x=dungeons[_loc4_][1];
     _loc3_.y=dungeons[_loc4_][2];
     _loc3_.iconMC.mazeIconMC.gotoAndStop(_loc2_.areaCode);
     _loc3_.buttonMode=true;
     _loc3_.tabEnabled=false;
     _loc3_.addEventListener(MouseEvent.CLICK,dongeonClicked);
     _loc3_.addEventListener(MouseEvent.ROLL_OVER,dongeonRollOver);
     _loc3_.addEventListener(MouseEvent.ROLL_OUT,dongeonRollOut);
     mapIcons.push(_loc3_);
  }
  
   function afterDongeonClickedAnim():Dynamic
  {
     clearInterval(mapAnimInterval);
     canWalk=true;
     game.msgShown=false;
     game.sound.stopEffects();
     game.startDungeon(currDungeonId);
  }
  
   function showAllDungeons():Dynamic
  {
     var _loc1_:Dynamic=undefined;
     game.help.showTutorial(5);
     clearInterval(addDungeonInterval);
     _loc1_=0;
     while(_loc1_<mapIcons.length)
     {
        mapIcons[_loc1_].visible=true;
        _loc1_++;
     }
  }
   }