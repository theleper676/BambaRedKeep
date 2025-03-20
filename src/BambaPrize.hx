package;

   import flash.display.*;
   
   class BambaPrize
   {
  public var money:Float;
  
  public var ingredient3:Float;
  
  public var numOfItems:Float;
  
  public var ingredient1:Float;
  
  public var ingredient2:Float;
  
  public var ingredient4:Float;
  
  public var moneyChance:Float;
  
  public var ingredient4Chance:Float;
  
  public var ingredient1Chance:Float;
  
  public var ingredient2Chance:Float;
  
  public var ingredient3Chance:Float;
  
  public var id:Float;
  
  public var itemChance:Float;
  
  public var fixed:Float;
  
  public function new(param1:Xml)
  {
     super();
     id=param1.id;
     numOfItems=param1.numOfItems;
     itemChance=param1.itemChance;
     fixed=param1.fixed;
     money=param1.money;
     moneyChance=param1.moneyChance;
     ingredient1=param1.ingredient1;
     ingredient1Chance=param1.ingredient1Chance;
     ingredient2=param1.ingredient2;
     ingredient2Chance=param1.ingredient2Chance;
     ingredient3=param1.ingredient3;
     ingredient3Chance=param1.ingredient3Chance;
     ingredient4=param1.ingredient4;
     ingredient4Chance=param1.ingredient4Chance;
  }
   }