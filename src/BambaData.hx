package;

import flash.display.*;

class BambaData {
	public var questsCatalog:Array<Dynamic>;

	public var enemiesCatalog:Array<Dynamic>;

	public var surprisesCatalog:Array<Dynamic>;

	public var beenHitAnimName:String;

	public var enemiesLevelsCatalog:Array<Dynamic>;

	public var mapData:Dynamic;
	//TODO: public var mapData:BambaMapData;

	public var itemsBaseCatalog:Array<Dynamic>;

	public var playerData:Dynamic;
	//TODO: public var playerData:BambaPlayerData;

	public var characterCustomDefs:Array<Dynamic>;

	public var ordersStartDefs:Array<Dynamic>;

	public var cardsCatalog:Array<Dynamic>;

	public var fightBoardXY:Array<Dynamic>;

	public var prizesCatalog:Array<Dynamic>;

	public var itemsCatalog:Array<Dynamic>;

	public var winAnimName:String;

	public var playerLevelsCatalog:Array<Dynamic>;

	public var mapTimes:Array<Dynamic>;

	public var fightZsize:Array<Dynamic>;

	public var itemsLevels:Array<Dynamic>;

	public var minLevel:Float;

	public var winAnimLength:Float;

	public var dungeonsDataCatalog:Array<Dynamic>;

	public var maxEnemyLevel:Float;

	public var loseAnimName:String;

	public var dungeonDifficulties:Array<Dynamic>;

	public var defaultAnimLength:Float;

	public var defaultDungeonAnimLength:Float;

	public var maxLevel:Float;

	public var fightSmallBoardXY:Array<Dynamic>;

	public var dictionary:Dynamic;
	//TODO: public var dictionary:BambaDictionary;

	public var helpCatalog:Array<Dynamic>;

	public var mapTrails:Array<Dynamic>;

	public var magicCatalog:Array<Dynamic>;

	public var storeItemsCatalog:Array<Dynamic>;

	public var enemyId:Float;

	public var barAnimLength:Float;

	public var minEnemyLevel:Float;

	public var fightXoffset:Array<Dynamic>;

	public var enemyType:Float;

	public var sharedOrder:Float;

	public var game:BambaMain;

	public var mapTimeDef:Float;

	public function new(mainGame:BambaMain) {
		game = mainGame;
		dictionary = new BambaDictionary();
		playerData = new BambaPlayerData(game);
		playerLevelsCatalog = [];
		magicCatalog = [];
		cardsCatalog = [];
		enemiesCatalog = [];
		enemiesLevelsCatalog = [];
		itemsBaseCatalog = [];
		itemsCatalog = [];
		storeItemsCatalog = [];
		prizesCatalog = [];
		surprisesCatalog = [];
		dungeonsDataCatalog = [];
		questsCatalog = [];
		helpCatalog = [];
	}

	// Return type should be BambaSurprise
	function getCatalogSurprise(param1:Dynamic):Dynamic {
		var _loc2_:Null<Dynamic> = null;
		_loc2_ = 0;
		while (_loc2_ < surprisesCatalog.length) {
			if (surprisesCatalog[_loc2_].id == param1) {
				return surprisesCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function buildDungeonsDataCatalog(param1:Array<Xml>):Void {
		var _loc2_:Xml = null;
		var _loc3_:BambaDungeonData = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaDungeonData(_loc2_);
			_loc3_.setMinLevel(mapData.areas);
			dungeonsDataCatalog.push(_loc3_);
		}
	}

	function loadDictionary(param1:Xml):Void {
		dictionary.load(param1);
	}

	//TODO: RETURN TYPE SHOULD BE BambaEnemyLevel
	function getCatalogEnemyLevel(param1:Dynamic, param2:Dynamic):Dynamic {
		var _loc3_:Null<Dynamic> = null;
		_loc3_ = 0;
		while (_loc3_ < enemiesLevelsCatalog.length) {
			if (enemiesLevelsCatalog[_loc3_].level == param1 && enemiesLevelsCatalog[_loc3_].type == param2) {
				return enemiesLevelsCatalog[_loc3_];
			}
			_loc3_++;
		}
		return null;
	}

	function buildEnemiesCatalog(param1:Array<Xml>):Void {
		var _loc2_:Xml = null;
		var _loc3_:BambaEnemy = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaEnemy(_loc2_);
			enemiesCatalog.push(_loc3_);
		}
	}

	public function loadCharacterCustom(param1:Dynamic):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_: Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		var _loc8_:Null<Dynamic> = null;
		characterCustomDefs = [];
		var iterable:Array<Dynamic> = cast(param1, Array<Dynamic>);
		for (_loc2_ in iterable) {
			_loc3_ = [];
			_loc4_ = Std.string(_loc2_.line1).split(",");
			_loc3_.push(_loc4_);
			_loc3_.push(_loc2_.line2dep);
			if (_loc2_.line2dep == 0) {
				_loc5_ = Std.string(_loc2_.line2).split(",");
				_loc3_.push(_loc5_);
			} else {
				_loc6_ = 0;
				while (_loc6_ < 6) {
					_loc7_ = "line2-" + Std.string(_loc6_ + 1);
					if (_loc2_.hasOwnProperty(_loc7_)) {
						_loc8_ = _loc2_[_loc7_].split(",");
						_loc3_.push(_loc8_);
					}
					_loc6_++;
				}
			}
			characterCustomDefs.push(_loc3_);
		}
	}

	public function getCatalogPlayerLevel(param1:Dynamic):BambaPlayerLevel {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < playerLevelsCatalog.length) {
			if (playerLevelsCatalog[_loc2_].level == param1) {
				return playerLevelsCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function buildMagicCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaMagic = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaMagic(_loc2_);
			magicCatalog.push(_loc3_);
		}
	}

	function buildHelpCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaHelpPage = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaHelpPage(_loc2_);
			helpCatalog.push(_loc3_);
		}
	}

	function getSuitableItemId():Float {
		var _loc1_:Float = NaN;
		var _loc2_:Dynamic = undefined;
		var _loc3_:Array<Dynamic> = null;
		var _loc4_:Dynamic = undefined;
		_loc1_ = playerData.level + Std.parseFloat(itemsLevels[Math.floor(Math.random() * itemsLevels.length)]);
		if (_loc1_ < minLevel) {
			_loc1_ = minLevel;
		}
		if (_loc1_ > maxLevel) {
			_loc1_ = maxLevel;
		}
		_loc3_ = [];
		_loc2_ = 0;
		while (_loc2_ < itemsCatalog.length) {
			if (itemsCatalog[_loc2_].minLevel == _loc1_) {
				_loc3_.push(itemsCatalog[_loc2_].id);
			}
			_loc2_++;
		}
		if (_loc3_.length > 0) {
			_loc4_ = _loc3_[Math.floor(Math.random() * _loc3_.length)];
		} else {
			_loc2_ = 0;
			while (_loc2_ < itemsCatalog.length) {
				if (itemsCatalog[_loc2_].minLevel <= _loc1_) {
					_loc3_.push(itemsCatalog[_loc2_].id);
				}
				if (_loc3_.length > 0) {
					_loc4_ = _loc3_[Math.floor(Math.random() * _loc3_.length)];
				} else {
					_loc4_ = 0;
				}
				_loc2_++;
			}
		}
		return _loc4_;
	}

	function buildQuestsCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaQuest = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaQuest(_loc2_);
			questsCatalog.push(_loc3_);
		}
	}

	public function getCatalogEnemy(param1:Dynamic, param2:Dynamic):BambaEnemy {
		var _loc3_:Dynamic = undefined;
		_loc3_ = 0;
		while (_loc3_ < enemiesCatalog.length) {
			if (enemiesCatalog[_loc3_].id == param1 && enemiesCatalog[_loc3_].type == param2) {
				return enemiesCatalog[_loc3_];
			}
			_loc3_++;
		}
		return null;
	}

	function buildPrizesCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaPrize = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaPrize(_loc2_);
			prizesCatalog.push(_loc3_);
		}
	}

	public function getCatalogHelpPage(param1:Dynamic):BambaHelpPage {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < helpCatalog.length) {
			if (helpCatalog[_loc2_].id == param1) {
				return helpCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	public function getCatalogItemBase(param1:Dynamic):BambaItemBase {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < itemsBaseCatalog.length) {
			if (itemsBaseCatalog[_loc2_].id == param1) {
				return itemsBaseCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function getCatalogMagic(param1:Dynamic):BambaMagic {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < magicCatalog.length) {
			if (magicCatalog[_loc2_].id == param1) {
				return magicCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function getCatalogCard(param1:Dynamic):BambaCard {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < cardsCatalog.length) {
			if (cardsCatalog[_loc2_].id == param1) {
				return cardsCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function getNewCard(param1:Dynamic):BambaCard {
		var _loc2_:Dynamic = undefined;
		var _loc3_:BambaCard = null;
		var _loc4_:BambaCard = null;
		_loc2_ = 0;
		while (_loc2_ < cardsCatalog.length) {
			if (cardsCatalog[_loc2_].id == param1) {
				_loc3_ = cardsCatalog[_loc2_];
				_loc4_ = new BambaCard(_loc3_.xmlData);
				_loc4_.init(game);
				return _loc4_;
			}
			_loc2_++;
		}
		return null;
	}

	public function getCatalogDungeonData(param1:Dynamic):BambaDungeonData {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < dungeonsDataCatalog.length) {
			if (dungeonsDataCatalog[_loc2_].id == param1) {
				return dungeonsDataCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function getCatalogStoreItems(param1:Dynamic, param2:Dynamic):BambaStoreItems {
		var _loc3_:Dynamic = undefined;
		_loc3_ = 0;
		while (_loc3_ < storeItemsCatalog.length) {
			if (storeItemsCatalog[_loc3_].level == param1 && storeItemsCatalog[_loc3_].order == param2) {
				return storeItemsCatalog[_loc3_];
			}
			_loc3_++;
		}
		return null;
	}

	public function loadFightData(param1:String, param2:String, param3:String, param4:String):Dynamic {
		var _loc5_:Dynamic = undefined;
		var _loc6_:Dynamic = undefined;
		var _loc7_:Array<Dynamic> = null;
		var _loc8_:Array<Dynamic> = null;
		var _loc9_:Array<Dynamic> = null;
		var _loc10_:Dynamic = undefined;
		var _loc11_:Array<Dynamic> = null;
		var _loc12_:Array<Dynamic> = null;
		var _loc13_:Dynamic = undefined;
		var _loc14_:Array<Dynamic> = null;
		fightBoardXY = [];
		_loc7_ = param1.split("*");
		_loc5_ = 0;
		while (_loc5_ < _loc7_.length) {
			_loc9_ = _loc7_[_loc5_].split(":");
			_loc10_ = [];
			_loc6_ = 0;
			while (_loc6_ < _loc9_.length) {
				_loc11_ = _loc9_[_loc6_].split(",");
				_loc10_.push(_loc11_);
				_loc6_++;
			}
			fightBoardXY.push(_loc10_);
			_loc5_++;
		}
		fightXoffset = param2.split(",");
		fightZsize = param3.split(",");
		fightSmallBoardXY = [];
		_loc8_ = param4.split("*");
		_loc5_ = 0;
		while (_loc5_ < _loc8_.length) {
			_loc12_ = _loc8_[_loc5_].split(":");
			_loc13_ = [];
			_loc6_ = 0;
			while (_loc6_ < _loc12_.length) {
				_loc14_ = _loc12_[_loc6_].split(",");
				_loc13_.push(_loc14_);
				_loc6_++;
			}
			fightSmallBoardXY.push(_loc13_);
			_loc5_++;
		}
	}

	public function getCatalogItem(param1:Dynamic):BambaItem {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < itemsCatalog.length) {
			if (itemsCatalog[_loc2_].id == param1) {
				return itemsCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	public function loadDungeonDifficulties(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:Dynamic = undefined;
		var _loc4_:Dynamic = undefined;
		var _loc5_:Dynamic = undefined;
		var _loc6_:Dynamic = undefined;
		dungeonDifficulties = [];
		for (_loc2_ in param1) {
			_loc3_ = [];
			_loc4_ = Std.string(_loc2_.enemyLevels).split(",");
			_loc5_ = Std.string(_loc2_.bossLevels).split(",");
			_loc6_ = _loc2_.prizePrc;
			_loc3_.push(_loc4_);
			_loc3_.push(_loc5_);
			_loc3_.push(_loc6_);
			dungeonDifficulties.push(_loc3_);
		}
	}

	function loadPlayerData(param1:Xml):Dynamic {
		playerData.updatePlayerData(param1);
	}

	function buildEnemiesLevelsCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaEnemyLevel = null;
		minEnemyLevel = 99;
		maxEnemyLevel = -99;
		for (_loc2_ in param1) {
			_loc3_ = new BambaEnemyLevel(_loc2_);
			enemiesLevelsCatalog.push(_loc3_);
			if (minEnemyLevel > _loc3_.level) {
				minEnemyLevel = _loc3_.level;
			}
			if (maxEnemyLevel < _loc3_.level) {
				maxEnemyLevel = _loc3_.level;
			}
		}
	}

	function buildSurprisesCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaSurprise = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaSurprise(_loc2_);
			surprisesCatalog.push(_loc3_);
		}
	}

	function buildItemsBaseCatalog(param1:Array<Xml>):Dynamic {
		var _loc2_:Xml = null;
		var _loc3_:BambaItemBase = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaItemBase(_loc2_);
			itemsBaseCatalog.push(_loc3_);
		}
	}

	public function getCatalogQuest(param1:Dynamic):BambaQuest {
		var _loc2_:Dynamic = undefined;
		_loc2_ = 0;
		while (_loc2_ < questsCatalog.length) {
			if (questsCatalog[_loc2_].id == param1) {
				return questsCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function buildItemsCatalog(param1:Array<Xml>):Void {
		var _loc2_:Xml = null;
		var _loc3_:BambaItem = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaItem(_loc2_);
			_loc3_.init(game);
			itemsCatalog.push(_loc3_);
		}
	}

	function buildCardsCatalog(param1:Array<Xml>):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaCard(_loc2_);
			_loc3_.init(game);
			cardsCatalog.push(_loc3_);
		}
	}

	public function loadOrdersStartDef(param1:Null<Dynamic>):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		ordersStartDefs = [];

		if(param1 != null) {
			var iterable:Array<Dynamic> = cast(param1, Array<Dynamic>);
			for (_loc2_ in iterable) {
				_loc3_ = [];
				_loc4_ = Std.string(_loc2_.magic).split(",");
				_loc5_ = Std.string(_loc2_.cards).split(",");
				_loc6_ = Std.string(_loc2_.items).split(",");
				_loc3_.push(_loc4_);
				_loc3_.push(_loc5_);
				_loc3_.push(_loc6_);
				ordersStartDefs.push(_loc3_);
			}
		}
		/* for (_loc2_ in param1) {
			_loc3_ = [];
			_loc4_ = Std.string(_loc2_.magic).split(",");
			_loc5_ = Std.string(_loc2_.cards).split(",");
			_loc6_ = Std.string().split(",");
			_loc3_.push(_loc4_);
			_loc3_.push(_loc5_);
			_loc3_.push(_loc6_);
			ordersStartDefs.push(_loc3_);
		} */
	}

	function loadGeneralData(param1:Dynamic):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		var _loc8_:Null<Dynamic> = null;
		var _loc9_:Null<Dynamic> = null;
		_loc2_ = param1.fightBoard;
		_loc3_ = _loc2_.fightBoardXY;
		_loc4_ = _loc2_.fightXoffset;
		_loc5_ = _loc2_.fightZsize;
		_loc6_ = _loc2_.fightSmallBoardXY;
		loadFightData(_loc3_, _loc4_, _loc5_, _loc6_);
		loadDungeonDifficulties(param1.dungeonDifficulties.children());
		itemsLevels = Std.string(param1.itemsLevels).split(",");
		defaultAnimLength = param1.defaultAnimLength;
		defaultDungeonAnimLength = param1.defaultDungeonAnimLength;
		winAnimLength = param1.winAnimLength;
		barAnimLength = param1.barAnimLength;
		beenHitAnimName = param1.beenHitAnimName;
		winAnimName = param1.winAnimName;
		loseAnimName = param1.loseAnimName;
		sharedOrder = param1.sharedOrder;
		mapData = new BambaMapData(param1.mainMap);
		loadOrdersStartDef(param1.ordersStartDef.children());
		loadCharacterCustom(param1.characterCustom.children());
		mapTrails = param1.mapTrails.split(",");
		mapTimeDef = param1.mapTimeDef;
		mapTimes = [];
		_loc7_ = param1.mapTimes.split(",");
		_loc8_ = 0;
		while (_loc8_ < _loc7_.length) {
			_loc9_ = _loc7_[_loc8_].split("%");
			mapTimes.push(_loc9_);
			_loc8_++;
		}
	}

	//TODO: type should be BambaPrize
	function getCatalogPrize(param1:Dynamic):Dynamic {
		var _loc2_:Null<Dynamic> = null;
		_loc2_ = 0;
		while (_loc2_ < prizesCatalog.length) {
			if (prizesCatalog[_loc2_].id == param1) {
				return prizesCatalog[_loc2_];
			}
			_loc2_++;
		}
		return null;
	}

	function buildStoreItemsCatalog(param1:Array<Xml>):Void {
		var _loc2_:Xml = null;
		var _loc3_:BambaStoreItems = null;
		for (_loc2_ in param1) {
			_loc3_ = new BambaStoreItems(_loc2_);
			storeItemsCatalog.push(_loc3_);
		}
	}

	function buildPlayerLevelsCatalog(param1:Array<Xml>):Void {
		var _loc2_:Xml = null;
		var _loc3_:BambaPlayerLevel = null;
		minLevel = 99;
		maxLevel = -99;
		for (_loc2_ in param1) {
			_loc3_ = new BambaPlayerLevel(_loc2_);
			playerLevelsCatalog.push(_loc3_);
			if (minLevel > _loc3_.level) {
				minLevel = _loc3_.level;
			}
			if (maxLevel < _loc3_.level) {
				maxLevel = _loc3_.level;
			}
		}
	}
}
