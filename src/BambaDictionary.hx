package;

   import flash.display.*;
   
   class BambaDictionary
   {
  public var CHARACTER_NAME:String;
  
  public var CH_B_SECOND_LINE:String;
  
  public var STORE_BUY_ITEM:String;
  
  public var UPGRADE_LEVEL_TO_LOW:String;
  
  public var LEVEL_UP_MSG:String;
  
  public var MSG_WIN1:String;
  
  public var MIN_LEVEL:String;
  
  public var NEXT_LEVEL:String;
  
  public var MSG_WIN2:String;
  
  public var CH_B_TITLE:String;
  
  public var CH_B_TEXT:String;
  
  public var DUNGEON_DIFFICULTIES:String;
  
  public var PRICE:String;
  
  public var MENU_NEW_CHARACTER:String;
  
  public var INGREDIENT3_NAME:String;
  
  public var CH_B_CUSTOM_HEAD:String;
  
  public var CH_B_NAME_TITLE:String;
  
  public var CH_B_NAME_DESC:String;
  
  public var NEW_PLAYER_NAME_EXISTING:String;
  
  public var NEW_PLAYER_NO_IDENTIC_PASS:String;
  
  public var LOADING_MOVIE_MSG:String;
  
  public var CLOSE_DUNGEON_MSG:String;
  
  public var NEW_PLAYER_MIN_NAME:String;
  
  public var EXPOINTS:String;
  
  public var NEW_PLAYER_ILLEGAL_MAIL:String;
  
  public var STORE_NO_MONEY:String;
  
  public var LOADING_MSGS:String;
  
  public var AREAS:String;
  
  public var MAGIC_MUST_PICK_ONE:String;
  
  public var LOADING_DUNGEON_MUSIC_MSG:String;
  
  public var CH_B_NAME_QUES:String;
  
  public var COLORS:String;
  
  public var CH_B_TABS:String;
  
  public var CHARACTER_ORDER:String;
  
  public var DUNGEON_DIFFICULTY:String;
  
  public var INGREDIENT2_NAME:String;
  
  public var REGENERATION:String;
  
  public var MAGIC:String;
  
  public var FOUND_TREASURE_MSG:String;
  
  public var MAGIC_NOT_ENOUGH_MONEY:String;
  
  public var NEW_PLAYER_MAIL_EXISTING:String;
  
  public var LOADING_DUNGEON_MSG:String;
  
  public var UPGRADE_MUST_PICK_ONE:String;
  
  public var STORE_MUST_PICK_ONE:String;
  
  public var CH_B_NO_ORDER:String;
  
  public var PRICE_SELL:String;
  
  public var UPGRADE_CANT_UPGRADE_CARD:String;
  
  public var CHARACTER_LEVEL:String;
  
  public var FIGHT_MUST_PICK_3:String;
  
  public var LOADING_ENEMY_MSG:String;
  
  public var LOADING_END_MSG:String;
  
  public var UPGRADE_NO_INGREDIENTS:String;
  
  public var MONEY_NAME:String;
  
  public var LEVEL_UP_MSG_HEAD:String;
  
  public var WIN_FIGHT_MSG:String;
  
  public var INGREDIENT4_NAME:String;
  
  public var QUEST_MSG_HEAD:String;
  
  public var NEW_PLAYER_MIN_PASS:String;
  
  public var STORE_SELL_ITEM:String;
  
  public var INGREDIENT1_NAME:String;
  
  public var MENU_NO_CHARACTER:String;
  
  public var ORDERS:String;
  
  public var CH_B_MIN_NAME:String;
  
  public var CH_B_OREDER_PRE:String;
  
  public var LOADING_FILE_SIZES:String;
  
  public var CH_B_FIRST_LINE:String;
  
  public var LIFE:String;
  
  public var CH_B_ORDERS_DESCS:String;
  
  public function new()
  {
     super();
  }
  
   function load(param1:Xml):Dynamic
  {
     var _loc2_:Xml=null;
     var _loc3_:Dynamic=undefined;
     for(_loc2_ in param1.children())
     {
        _loc3_=_loc2_.name();
        this[_loc3_]=_loc2_;
     }
  }
   }