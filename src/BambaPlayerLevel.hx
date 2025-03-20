package;

   import flash.display.*;
   
   class BambaPlayerLevel
   {
  public var maxLife:Float;
  
  public var level:Float;
  
  public var missionIngredientsIncreasePrc:Float;
  
  public var missionMoneyIncreasePrc:Float;
  
  public var fightIngredientsIncreasePrc:Float;
  
  public var missionExIncreasePrc:Float;
  
  public var nextLevelEx:Float;
  
  public var fightMoneyIncreasePrc:Float;
  
  public var maxMagic:Float;
  
  public var treasureIngredientsIncreasePrc:Float;
  
  public var treasureMoneyIncreasePrc:Float;
  
  public var roundRegeneration:Float;
  
  public function new(param1:Xml)
  {
     super();
     level=param1.level;
     nextLevelEx=param1.nextLevelEx;
     maxLife=param1.maxLife;
     maxMagic=param1.maxMagic;
     roundRegeneration=param1.roundRegeneration;
     missionExIncreasePrc=param1.missionExIncreasePrc;
     missionMoneyIncreasePrc=param1.missionMoneyIncreasePrc;
     missionIngredientsIncreasePrc=param1.missionIngredientsIncreasePrc;
     fightMoneyIncreasePrc=param1.fightMoneyIncreasePrc;
     fightIngredientsIncreasePrc=param1.fightIngredientsIncreasePrc;
     treasureMoneyIncreasePrc=param1.treasureMoneyIncreasePrc;
     treasureIngredientsIncreasePrc=param1.treasureIngredientsIncreasePrc;
  }
   }