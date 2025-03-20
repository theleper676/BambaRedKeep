package;

   import flash.display.*;
   
   class BambaSurprise
   {
  public var sDesc:String;
  
  public var prizesIds:Array<Dynamic>;
  
  public var type:Float;
  
  public var id:Float;
  
  public var sName:String;
  
  public function new(param1:Xml)
  {
     super();
     id=param1.id;
     sName=param1.name;
     sDesc=param1.desc;
     type=param1.type;
     if(param1.hasOwnProperty("prizesIds"))
     {
        prizesIds=param1.prizesIds.split(",");
     }
     else
     {
        prizesIds=[];
     }
  }
   }