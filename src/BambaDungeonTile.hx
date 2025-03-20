package;

   class BambaDungeonTile
   {
  public var links:Array<Dynamic>;
  
  public var level:Float;
  
  public var jump:Float;
  
  public var x:Float;
  
  public var y:Float;
  
  public var id:Float;
  
  public function new(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic, param5:Dynamic)
  {
     super();
     id=param1;
     x=param2;
     y=param3;
     links=param4.split(",");
     jump=param5;
     level=1;
  }
   }