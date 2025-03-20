package;

import flash.display.*;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextFormat;
import general.Heb;

class BambaCard {
	public var ingredient1:Float;

	public var ingredient4:Float;

	public var magicAnimDepth:Float;

	public var attackString:String;

	public var magicAnimName:String;

	public var disabled:Bool;

	public var cName:String;

	public var ingredient3:Float;

	public var cDesc:String;

	public var sound:String;

	public var fight:Dynamic;

	public var id:Float;

	public var mc:Dynamic;

	public var game:Dynamic;

	public var regenerateAmount:Float;

	public var picked:Bool;

	public var ingredient2:Float;

	public var ponAnimName:String;

	public var magicId:Float;

	public var upgradeTo:Float;

	public var defenseAmount:Float;

	public var graphicsName:String;

	public var upgradeLevel:String;

	public var fixedLocation:Array<Dynamic>;

	public var cost:Float;

	public var popupMC:Dynamic;

	public var minLevel:Float;

	public var upgradeDesc:String;

	public var animLength:Float;

	public var healAmount:Float;

	public var xmlData:Xml;

	public var color:Int;

	public var damage:Float;

	public var animDelay:Float;

	public var screen:Dynamic;

	public var orgX:Float;

	public var orgY:Float;

	public var moveDir:Float;

	public function new(param1:Dynamic) {
		xmlData = param1;
		id = param1.id;
		cName = param1.name;
		upgradeLevel = param1.upgradeLevel;
		graphicsName = param1.graphicsName;
		cDesc = param1.desc;
		cost = param1.cost;
		damage = param1.damage;
		moveDir = param1.moveDir;
		attackString = param1.attackString;
		defenseAmount = param1.defenseAmount;
		regenerateAmount = param1.regenerateAmount;
		healAmount = param1.healAmount;
		magicId = param1.magicId;
		color = param1.color;
		ponAnimName = param1.ponAnimName;
		magicAnimName = param1.magicAnimName;
		animLength = param1.animLength;
		animDelay = param1.animDelay;
		magicAnimDepth = param1.magicAnimDepth;
		sound = param1.sound;
		if (param1.hasOwnProperty("fixedLocation")) {
			fixedLocation = Std.string(param1.fixedLocation).split(",");
		} else {
			fixedLocation = [];
		}
		upgradeTo = param1.upgradeTo;
		upgradeDesc = param1.upgradeDesc;
		ingredient1 = param1.ingredient1;
		ingredient2 = param1.ingredient2;
		ingredient3 = param1.ingredient3;
		ingredient4 = param1.ingredient4;
		minLevel = param1.minLevel;
	}

	function setCardforUpgrade(param1:Dynamic):Void {
		screen = param1;
		mc.addEventListener(MouseEvent.CLICK, cardUpgradeClick);
		mc.buttonMode = true;
		mc.tabEnabled = false;
	}

	function addPopupEvents(param1:Dynamic):Void {
		screen = param1;
		mc.addEventListener(MouseEvent.ROLL_OVER, cardRolledOver);
		mc.addEventListener(MouseEvent.ROLL_OUT, cardRolledOut);
	}

	function cardUpgradeClick(param1:MouseEvent):Void {
		if (!game.msgShown) {
			screen.cardRollOver(id);
			screen.cardClicked(id);
		}
	}

	function setCardDir(param1:Dynamic):Void {
		mc.frontMC.shapeMC.scaleX = -param1;
	}

	function cardRolledOut(param1:MouseEvent):Void {
		screen.mc.removeChild(popupMC);
	}

	function init(param1:Dynamic):Void {
		var _loc2_:Dynamic = null;
		game = param1;
		if (magicId != 0) {
			_loc2_ = game.gameData.getCatalogMagic(magicId);
			setMagicData(_loc2_);
		}
		if (animLength == 0) {
			animLength = game.gameData.defaultAnimLength;
		}
	}

	function setMagicData(param1:BambaMagic):Void {
		if (graphicsName == "") {
			graphicsName = param1.graphicsName;
		}
		if (attackString == "") {
			attackString = param1.attackString;
		}
		if (color == 0) {
			color = param1.color;
		}
		if (ponAnimName == "") {
			ponAnimName = param1.ponAnimName;
		}
		if (magicAnimName == "") {
			magicAnimName = param1.magicAnimName;
		}
		if (animLength == 0) {
			animLength = param1.animLength;
		}
		if (animDelay == 0) {
			animDelay = param1.animDelay;
		}
		if (magicAnimDepth == 0) {
			magicAnimDepth = param1.magicAnimDepth;
		}
		if (fixedLocation.length == 0) {
			fixedLocation = param1.fixedLocation;
		}
		if (sound == "") {
			sound = param1.sound;
		}
	}

	function cardRolledOver(param1:MouseEvent):Void {
		Heb.setText(popupMC.NAME, cName);
		Heb.setText(popupMC.DESC, cDesc);
		popupMC.x = Std.int(screen.mc.cardsMC.x) + Std.int(mc.x) + Std.int(mc.width);
		popupMC.y = Std.int(screen.mc.cardsMC.y) + Std.int(mc.y) + Std.int(mc.height) / 2;
		screen.mc.addChild(popupMC);
	}

	function cardPickMC(param1:Float = 1):Void {
		var _loc2_:Dynamic = null;
		var _loc3_:TextFormat = null;
		var _loc4_:ColorTransform = null;
		var _loc5_:Dynamic = null;
		var _loc6_:Int = null;
		var _loc7_:Dynamic = null;
		if (mc == null) {
			mc = BambaAssets.cardBase();
			Heb.setText(mc.frontMC.nameDT, cName);
			mc.frontMC.damageDT.text = damage;
			mc.frontMC.costDT.text = cost;
			if (damage == 0 && healAmount > 0) {
				mc.frontMC.damageDT.text = "-" + healAmount;
			}
			_loc3_ = new TextFormat();
			_loc4_ = new ColorTransform();
			_loc5_ = game.gameData.dictionary.COLORS.split(",");
			_loc3_.color = _loc5_[color - 1];
			_loc4_.color = _loc5_[color - 1];
			mc.frontMC.nameDT.setTextFormat(_loc3_);
			mc.frontMC.damageDT.setTextFormat(_loc3_);
			mc.frontMC.costDT.setTextFormat(_loc3_);
			mc.frontMC.picMC.gotoAndStop(graphicsName);
			if (upgradeLevel == "") {
				mc.frontMC.upgradeMC.gotoAndStop(1);
			} else {
				mc.frontMC.upgradeMC.gotoAndStop(upgradeLevel);
			}
			_loc6_ = 0;
			while (_loc6_ < attackString.length) {
				if (attackString.charAt(_loc6_) == "1") {
					_loc7_ = "cube" + Std.string(_loc6_ + 1);
					mc.frontMC.shapeMC[_loc7_].transform.colorTransform = _loc4_;
				}
				_loc6_++;
			}
			setCardDir(param1);
		}
		popupMC = BambaAssets.cardPopup();
	}

	function pickCard(param1:MouseEvent):Void {
		var _loc2_:Int = null;
		var _loc3_:Int = null;
		if (!game.msgShown) {
			if (picked == false) {
				if (disabled == false) {
					if (fight.cardPickedByPlayer[0] * fight.cardPickedByPlayer[1] * fight.cardPickedByPlayer[2] == 0) {
						game.sound.playEffect("BATTLE_CARD_PICK");
						picked = true;
						orgX = mc.x;
						orgY = mc.y;
						_loc2_ = 0;
						while (_loc2_ < 3) {
							if (fight.cardPickedByPlayer[_loc2_] == 0) {
								fight.MC.cardPickMC.cardsPickBoardMC.removeChild(mc);
								fight.MC.cardPickMC.cardsPickedMC.addChild(mc);
								mc.scaleX = 1;
								mc.scaleY = 1;
								mc.x = fight.cardPicksLocation[_loc2_][0];
								mc.y = fight.cardPicksLocation[_loc2_][1];
								fight.cardPickedByPlayer[_loc2_] = id;
								fight.costOfPickedCards = Std.int(fight.costOfPickedCards) + Std.int(cost) - Std.int(regenerateAmount);
								fight.disableExpensiveCards();
								break;
							}
							_loc2_++;
						}
					}
				}
			} else {
				game.sound.playEffect("BATTLE_CARD_PICK");
				picked = false;
				fight.MC.cardPickMC.cardsPickedMC.removeChild(mc);
				fight.MC.cardPickMC.cardsPickBoardMC.addChild(mc);
				mc.scaleX = 1;
				mc.scaleY = 1;
				mc.x = orgX;
				mc.y = orgY;
				_loc3_ = 0;
				while (_loc3_ < 3) {
					if (fight.cardPickedByPlayer[_loc3_] == id) {
						fight.cardPickedByPlayer[_loc3_] = 0;
						fight.costOfPickedCards = Std.int(fight.costOfPickedCards) - Std.int(cost) + Std.int(regenerateAmount);
						fight.disableExpensiveCards();
						break;
					}
					_loc3_++;
				}
			}
		}
	}

	function addClickEvent(param1:Dynamic):Void {
		mc.addEventListener(MouseEvent.CLICK, pickCard);
		mc.buttonMode = true;
		mc.tabEnabled = false;
		picked = false;
		fight = param1;
	}
}
