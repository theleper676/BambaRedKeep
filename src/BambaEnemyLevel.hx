package;

   import flash.display.*;
   
   class BambaEnemyLevel
   {
  public var maxLife:Float;
  
  public var level:Float;
  
  public var maxMagic:Float;
  
  public var exPoints:Float;
  
  public var roundRegeneration:Float;
  
  public var type:Float;
  
  public function new(param1:Xml)
  {
     super();
     level=param1.level;
     type=param1.type;
     maxLife=param1.maxLife;
     maxMagic=param1.maxMagic;
     roundRegeneration=param1.roundRegeneration;
     exPoints=param1.exPoints;
  }
   }