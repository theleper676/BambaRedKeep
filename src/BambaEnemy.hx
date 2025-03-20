package;

import flash.display.*;

class BambaEnemy {
	public var AIType:String;

	public var cards:Array<Dynamic>;

	public var eName:String;

	public var assetFileName:String;

	public var prizesIds:Array<Dynamic>;

	public var type:Float;

	public var id:Float;

	public var eDesc:String;

	public var levelCards:Array<Dynamic>;

	public function new(param1:Dynamic) {
		var _loc2_:Dynamic = null;
		var _loc3_:Dynamic = null;
		id = param1.id;
		type = param1.type;
		eName = param1.name;
		eDesc = param1.desc;
		assetFileName = param1.assetFileName;
		AIType = param1.AIType;
		if (param1.hasOwnProperty("cards")) {
			cards = param1.cards.split(",");
		} else {
			cards = [];
		}
		if (param1.hasOwnProperty("levelCards")) {
			levelCards = [];
			for (_loc2_ in param1.levelCards.children()) {
				_loc3_ = _loc2_.split(",");
				levelCards.push(_loc3_);
			}
		} else {
			levelCards = [];
		}
		prizesIds = param1.prizesIds.split(",");
	}
}
