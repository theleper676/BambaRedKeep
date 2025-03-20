package;

   import flash.display.*;
   
   class BambaStoreItems
   {
  public var items:Array<Dynamic>;
  
  public var level:Float;
  
  public var order:Float;
  
  public function new(param1:Xml)
  {
     super();
     level=param1.level;
     order=param1.order;
     items=param1.items.split(",");
  }
   }