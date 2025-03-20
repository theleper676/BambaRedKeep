package;

   import flash.display.*;
   
   class BambaHelpPage
   {
  public var texts:Array<Dynamic>;
  
  public var pics:Array<Dynamic>;
  
  public var links:Array<Dynamic>;
  
  public var template:String;
  
  public var id:Float;
  
  public function new(param1:Xml)
  {
     var _loc2_:Float=NaN;
     var _loc3_:Array<Dynamic>=null;
     var _loc4_:String=null;
     var _loc5_:String=null;
     var _loc6_:Array<Dynamic>=null;
     super();
     id=param1.id;
     template=param1.template;
     texts=[];
     _loc2_=1;
     while(_loc2_<=10)
     {
        _loc3_=[];
        _loc4_="P" + _loc2_;
        if(param1.texts.hasOwnProperty(_loc4_))
        {
           _loc3_.push(_loc4_);
           _loc3_.push(param1.texts[_loc4_]);
           texts.push(_loc3_);
        }
        _loc2_++;
     }
     pics=[];
     _loc2_=1;
     while(_loc2_<=10)
     {
        _loc3_=[];
        _loc4_="PIC" + _loc2_;
        if(param1.pics.hasOwnProperty(_loc4_))
        {
           _loc3_.push(_loc4_);
           _loc3_.push(param1.pics[_loc4_]);
           pics.push(_loc3_);
        }
        _loc2_++;
     }
     links=[];
     _loc2_=1;
     while(_loc2_<=10)
     {
        _loc3_=[];
        _loc4_="L" + _loc2_;
        if(param1.links.hasOwnProperty(_loc4_))
        {
           _loc3_.push(_loc4_);
           _loc5_=param1.links[_loc4_];
           _loc6_=_loc5_.split("*");
           _loc3_.push(_loc6_[0]);
           _loc3_.push(_loc6_[1]);
           links.push(_loc3_);
        }
        _loc2_++;
     }
  }
   }