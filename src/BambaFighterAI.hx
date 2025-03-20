package;

   import flash.display.*;
   import flash.utils.*;
   
   class BambaFighterAI
   {
   var enemy:BambaFighter;
  
   var GOOD_ATTACK_CHANCE:Dynamic=0.1;
  
   var cardCounter:Float;
  
   var baby:BambaFighter;
  
   var yMoveAdd:Dynamic;
  
   var possibleAttacks:Array<Dynamic>;
  
   var fight:BambaFight;
  
   var MOVE_CHANCE:Dynamic=0.3;
  
   var costOfPickedCards:Float;
  
   var xMoveAdd:Dynamic;
  
  public function new(param1:Dynamic)
  {
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     MOVE_CHANCE=0.3;
     GOOD_ATTACK_CHANCE=0.1;
     super();
     enemy=param1;
     baby=param1.fight.me;
     fight=param1.fight;
     trace("AIType:" + fight.enemyData.AIType);
     switch(fight.enemyData.AIType)
     {
        case "1":
           GOOD_ATTACK_CHANCE=0.15;
           break;
        case "2":
           GOOD_ATTACK_CHANCE=0.25;
           break;
        case "3":
           GOOD_ATTACK_CHANCE=0.32;
     }
     possibleAttacks=[];
     _loc2_=0;
     while(_loc2_<fight.cardsEnemyCanUse.length)
     {
        _loc3_=fight.game.gameData.getCatalogCard(fight.cardsEnemyCanUse[_loc2_]);
        if(_loc3_.damage>0)
        {
           if(possibleAttacks.indexOf(_loc3_.id)==-1)
           {
              possibleAttacks.push(_loc3_.id);
           }
        }
        _loc2_++;
     }
  }
  
   function switchLocations(param1:Dynamic, param2:Dynamic, param3:Dynamic):Dynamic
  {
     var _loc4_:Dynamic=undefined;
     _loc4_=param1[param2];
     param1[param2]=param1[param3];
     param1[param3]=_loc4_;
  }
  
   function returnSequence():Dynamic
  {
     var _loc1_:Array<Dynamic>=null;
     var _loc2_:Dynamic=undefined;
     var _loc3_:Dynamic=undefined;
     var _loc4_:Array<Dynamic>=null;
     var _loc5_:BambaCard=null;
     var _loc6_:Dynamic=undefined;
     var _loc7_:Dynamic=undefined;
     var _loc8_:Dynamic=undefined;
     var _loc9_:Dynamic=undefined;
     var _loc10_:Dynamic=undefined;
     var _loc11_:Dynamic=undefined;
     var _loc12_:Dynamic=undefined;
     var _loc13_:Dynamic=undefined;
     var _loc14_:Dynamic=undefined;
     _loc1_=[];
     _loc2_=0;
     while(_loc2_<fight.cardsEnemyCanUse.length)
     {
        _loc1_.push(fight.cardsEnemyCanUse[_loc2_]);
        _loc2_++;
     }
     _loc4_=[];
     cardCounter=1;
     costOfPickedCards=0;
     xMoveAdd=0;
     yMoveAdd=0;
     while(_loc4_.length<3)
     {
        if(_loc1_.length==0)
        {
           _loc3_=cardCounter;
           while(_loc3_<=3)
           {
              _loc4_.push(10);
              _loc3_++;
           }
           break;
        }
        switch(fight.enemyData.AIType)
        {
           case "1":
           case "2":
           case "3":
              _loc8_=0;
              _loc9_=0;
              _loc10_=-1;
              _loc3_=0;
              while(_loc3_<possibleAttacks.length)
              {
                 _loc5_=fight.game.gameData.getCatalogCard(possibleAttacks[_loc3_]);
                 _loc11_=calcHitChance(_loc5_,cardCounter);
                 if(_loc8_<_loc11_ * _loc5_.damage)
                 {
                    _loc8_=_loc11_ * _loc5_.damage;
                    _loc9_=_loc11_;
                    _loc10_=_loc5_.id;
                 }
                 _loc3_++;
              }
              if(_loc9_>GOOD_ATTACK_CHANCE)
              {
                 trace(_loc10_);
                 trace(_loc1_);
                 _loc12_=false;
                 _loc3_=0;
                 while(_loc3_<_loc1_.length)
                 {
                    if(_loc1_[_loc3_]==_loc10_)
                    {
                       _loc12_=true;
                       break;
                    }
                    _loc3_++;
                 }
                 if(_loc12_)
                 {
                    _loc6_=_loc3_;
                 }
                 else
                 {
                    _loc6_=Math.floor(Math.random()* _loc1_.length);
                 }
              }
              else
              {
                 _loc6_=Math.floor(Math.random()* _loc1_.length);
              }
              break;
           default:
              _loc6_=Math.floor(Math.random()* _loc1_.length);
        }
        _loc5_=fight.game.gameData.getCatalogCard(_loc1_[_loc6_]);
        _loc7_=false;
        if(costOfPickedCards + _loc5_.cost<=enemy.magicPower)
        {
           _loc7_=true;
        }
        if(_loc5_.damage>0)
        {
           _loc13_=calcHitChance(_loc5_,cardCounter);
           if(_loc13_<=GOOD_ATTACK_CHANCE)
           {
              _loc7_=false;
           }
        }
        if(_loc5_.moveDir !=0)
        {
           switch(_loc5_.moveDir)
           {
              case 1:
                 if(enemy.yPos==0)
                 {
                    _loc7_=false;
                 }
                 else
                 {
                    --yMoveAdd;
                 }
                 break;
              case 2:
                 if(enemy.xPos==3)
                 {
                    _loc7_=false;
                 }
                 else
                 {
                    ++xMoveAdd;
                 }
                 break;
              case 3:
                 if(enemy.yPos==2)
                 {
                    _loc7_=false;
                 }
                 else
                 {
                    ++yMoveAdd;
                 }
                 break;
              case 4:
                 if(enemy.xPos==0)
                 {
                    _loc7_=false;
                 }
                 else
                 {
                    --xMoveAdd;
                 }
           }
        }
        if(_loc5_.regenerateAmount !=0)
        {
           if(enemy.magicPower==enemy.maxMagic)
           {
              _loc7_=false;
           }
        }
        if(cardCounter==1 && _loc5_.id==5)
        {
           if(Math.abs(enemy.xPos - fight.me.xPos)>2 || Math.abs(enemy.yPos - fight.me.yPos)>1)
           {
              _loc7_=false;
           }
        }
        if(_loc7_)
        {
           _loc14_=_loc1_.splice(_loc6_,1);
           _loc4_.push(_loc14_);
           costOfPickedCards +=_loc5_.cost;
           ++cardCounter;
        }
        else
        {
           _loc1_.splice(_loc6_,1);
        }
     }
     return _loc4_;
  }
  
   function calcHitChance(param1:BambaCard, param2:Float):Float
  {
     var _loc3_:Dynamic=undefined;
     var _loc4_:Dynamic=undefined;
     var _loc5_:Dynamic=undefined;
     var _loc6_:Dynamic=undefined;
     var _loc7_:Array<Dynamic>=null;
     var _loc8_:Dynamic=undefined;
     var _loc9_:Dynamic=undefined;
     var _loc10_:Dynamic=undefined;
     var _loc11_:Dynamic=undefined;
     var _loc12_:Dynamic=undefined;
     var _loc13_:Dynamic=undefined;
     var _loc14_:Dynamic=undefined;
     _loc5_=0;
     _loc6_=[0,0,0,0,0,0,0,0,0,0,0,0];
     _loc8_=[[1,0],[0,1],[-1,0],[0,-1]];
     _loc6_[baby.xPos + 4 * baby.yPos]=1;
     _loc9_=0;
     while(_loc9_<param2)
     {
        _loc7_=[0,0,0,0,0,0,0,0,0,0,0,0];
        _loc4_=0;
        while(_loc4_<_loc6_.length)
        {
           if(_loc6_[_loc4_]>0)
           {
              _loc7_[_loc4_] +=_loc6_[_loc4_] *(1 - MOVE_CHANCE);
              _loc10_=0;
              _loc3_=0;
              while(_loc3_<_loc8_.length)
              {
                 _loc11_=_loc8_[_loc3_][0];
                 _loc12_=_loc8_[_loc3_][1];
                 _loc13_=_loc4_ % 4 + _loc11_;
                 _loc14_=Math.floor(_loc4_ / 4)+ _loc12_;
                 if(_loc13_>=0 && _loc13_<=3 && _loc14_>=0 && _loc14_<=2)
                 {
                    _loc10_++;
                 }
                 _loc3_++;
              }
              _loc3_=0;
              while(_loc3_<_loc8_.length)
              {
                 _loc11_=_loc8_[_loc3_][0];
                 _loc12_=_loc8_[_loc3_][1];
                 _loc13_=_loc4_ % 4 + _loc11_;
                 _loc14_=Math.floor(_loc4_ / 4)+ _loc12_;
                 if(_loc13_>=0 && _loc13_<=3 && _loc14_>=0 && _loc14_<=2)
                 {
                    _loc7_[_loc13_ + 4 * _loc14_] +=_loc6_[_loc4_] * MOVE_CHANCE / _loc10_;
                 }
                 _loc3_++;
              }
           }
           _loc4_++;
        }
        _loc4_=0;
        while(_loc4_<_loc6_.length)
        {
           _loc6_[_loc4_]=_loc7_[_loc4_];
           _loc4_++;
        }
        _loc9_++;
     }
     _loc3_=0;
     while(_loc3_<param1.attackString.length)
     {
        if(param1.attackString.charAt(_loc3_)=="1")
        {
           _loc11_=enemy.attackMatrix[_loc3_][0] * enemy.dir;
           _loc12_=enemy.attackMatrix[_loc3_][1];
           _loc13_=enemy.xPos + xMoveAdd + _loc11_;
           _loc14_=enemy.yPos + yMoveAdd + _loc12_;
           if(_loc13_>=0 && _loc13_<=3 && _loc14_>=0 && _loc14_<=2)
           {
              _loc5_ +=_loc7_[_loc13_ + 4 * _loc14_];
           }
        }
        _loc3_++;
     }
     return _loc5_;
  }
   }