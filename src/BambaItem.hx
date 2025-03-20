package;

import flash.display.*;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import general.Heb;

class BambaItem {
	public var addMagic:Float;

	public var iName:String;

	public var mc:MovieClip;

	public var sellPrice:Float;

	public var iDesc:String;

	public var id:Float;

	public var addRoundRegeneration:Float;

	public var graphicsName:String;

	public var iType:Int;

	public var addLife:Float;

	public var popupMC:Dynamic;

	public var frameMC:MovieClip;

	public var screenType:Float;

	public var base:Float;

	public var minLevel:Float;

	public var xmlData:Dynamic;

	public var buyPrice:Float;

	public var indexInScreen:Dynamic;

	public var game:Dynamic;

	public var line:Dynamic;

	public var screen:Dynamic;

	public function new(param1:Dynamic) {
		xmlData = param1;
		id = param1.id;
		base = param1.base;
		iName = param1.name;
		iDesc = param1.desc;
		iType = param1.type;
		buyPrice = param1.buyPrice;
		sellPrice = param1.sellPrice;
		minLevel = param1.minLevel;
		addLife = param1.addLife;
		addMagic = param1.addMagic;
		addRoundRegeneration = param1.addRoundRegeneration;
		graphicsName = param1.graphicsName;
	}

	function itemClickedOnBaby(param1:MouseEvent):Void {
		if (!game.msgShown) {
			screen.itemClickedOnBaby(id);
		}
	}

	public function init(param1:Dynamic):Void {
		var _loc2_:Dynamic = null;
		game = param1;
		if (base != 0) {
			_loc2_ = game.gameData.getCatalogItemBase(base);
			setItemBaseData(_loc2_);
		}
	}

	function itemRolledOverInMsg(param1:MouseEvent):Void {
		setBasicPopupText();
		popupMC.PRICE.text = "";
		popupMC.priceDT.text = "";
		popupMC.x = screen.prizesMC.x + mc.x + mc.width;
		popupMC.y = screen.prizesMC.y + mc.y + mc.height / 2;
		screen.addChild(popupMC);
	}

	function itemClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			screen.itemClicked(id, indexInScreen);
		}
	}

	function charecterBuildClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			screen.itemClicked(id, line, indexInScreen);
		}
	}

	public function addClickEventOnBaby(param1:Dynamic):Void {
		screen = param1;
		frameMC.gotoAndStop("onBaby");
		mc.addEventListener(MouseEvent.CLICK, itemClickedOnBaby);
		mc.buttonMode = true;
		mc.tabEnabled = false;
		mc.addEventListener(MouseEvent.ROLL_OVER, itemRolledOverOnBaby);
		mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOut);
	}

	function itemStoreClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			screen.itemStoreClicked(id, indexInScreen);
		}
	}

	public function generateMC():Void {
		if (mc == null) {
			switch (iType) {
				case 1:
					mc = BambaAssets.hatMC;
				case 2:
					mc = BambaAssets.capeMC;
				case 3:
					mc = BambaAssets.beltMC;
				case 4:
					mc = BambaAssets.shoesMC;
				case 5:
					mc = BambaAssets.stickMC;
				case 6:
					mc = BambaAssets.hairMC;
				case 7:
					mc = BambaAssets.eyesMC;
				case 8:
					mc = BambaAssets.daiperMC;
			}
			mc.gotoAndStop(graphicsName);
			frameMC = BambaAssets.itemFrame;
			mc.itemId = id;
			mc.addChild(frameMC);
			mc.setChildIndex(frameMC, 0);
			popupMC = BambaAssets.itemPopup();
		}
	}

	function setItemBaseData(param1:BambaItemBase):Void {
		if (iName == "") {
			iName = param1.iName;
		}
		if (iDesc == "") {
			iDesc = param1.iDesc;
		}
		if (iType == 0) {
			iType = param1.iType;
		}
		if (buyPrice == 0) {
			buyPrice = param1.buyPrice;
		}
		if (sellPrice == 0) {
			sellPrice = param1.sellPrice;
		}
		if (minLevel == 0) {
			minLevel = param1.minLevel;
		}
		if (addLife == 0) {
			addLife = param1.addLife;
		}
		if (addMagic == 0) {
			addMagic = param1.addMagic;
		}
		if (addRoundRegeneration == 0) {
			addRoundRegeneration = param1.addRoundRegeneration;
		}
	}

	public function addCharecterBuildClickEvent(param1:Dynamic, param2:Dynamic, param3:Dynamic):Void {
		mc.addEventListener(MouseEvent.CLICK, charecterBuildClicked);
		mc.buttonMode = true;
		mc.tabEnabled = false;
		screen = param1;
		indexInScreen = param3;
		line = param2;
		frameMC.gotoAndStop("reg");
	}

	public function addStoreClickEvent(param1:Dynamic, param2:Dynamic):Dynamic {
		mc.addEventListener(MouseEvent.CLICK, itemStoreClicked);
		mc.buttonMode = true;
		mc.tabEnabled = false;
		screen = param1;
		indexInScreen = param2;
		if (minLevel <= screen.game.gameData.playerData.level) {
			frameMC.gotoAndStop("reg");
			frameMC.backMC.gotoAndStop(2);
			mc.disabled = false;
		} else {
			frameMC.gotoAndStop("disable");
			frameMC.backMC.gotoAndStop(2);
			mc.disabled = true;
		}
		mc.addEventListener(MouseEvent.ROLL_OVER, itemStoreRolledOver);
		mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOut);
	}

	function itemRolledOver(param1:MouseEvent):Void {
		if (!game.msgShown) {
			setBasicPopupText();
			if (screenType == 1) {
				popupMC.PRICE.text = "";
				popupMC.priceDT.text = "";
			} else {
				Heb.setText(popupMC.PRICE, game.gameData.dictionary.PRICE_SELL + ":");
				popupMC.priceDT.text = sellPrice;
			}
			popupMC.x = screen.mc.itemsSP.x + mc.x + frameMC.width;
			popupMC.y = screen.mc.itemsSP.y + mc.y + frameMC.height / 2 - screen.mc.itemsSP.verticalScrollPosition;
			screen.mc.addChild(popupMC);
		}
	}

	function itemRolledOutInMsg(param1:MouseEvent):Void {
		if (screen.contains(popupMC)) {
			screen.removeChild(popupMC);
		}
	}

	public function addPopupInMsg(param1:Dynamic):Dynamic {
		screen = param1;
		frameMC.gotoAndStop("noBack");
		mc.addEventListener(MouseEvent.ROLL_OVER, itemRolledOverInMsg);
		mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOutInMsg);
	}

	function setColorAndText(param1:Dynamic, param2:Dynamic):Dynamic {
		var _loc3_:Dynamic = undefined;
		var _loc4_:Dynamic = undefined;
		var _loc5_:TextFormat = null;
		var _loc6_:TextFormat = null;
		var _loc7_:TextFormat = null;
		_loc3_ = game.gameData.playerData.itemsInUse[iType - 1];
		if (_loc3_ > 0) {
			_loc4_ = game.gameData.getCatalogItem(_loc3_)[param2];
		} else {
			_loc4_ = 0;
		}
		param1.text = "+" + this[param2];
		if (_loc4_ < this[param2]) {
			(_loc5_ = new TextFormat()).color = "0x2ED51C";
			_loc5_.bold = true;
			param1.setTextFormat(_loc5_);
		} else if (_loc4_ > this[param2]) {
			(_loc6_ = new TextFormat()).color = "0xFF6372";
			_loc6_.bold = true;
			param1.setTextFormat(_loc6_);
		} else {
			(_loc7_ = new TextFormat()).color = "0xFFE696";
			_loc7_.bold = false;
			param1.setTextFormat(_loc7_);
		}
	}

	function setBasicPopupText():Dynamic {
		var _loc1_:TextFormat = null;
		Heb.setText(popupMC.NAME, iName);
		Heb.setText(popupMC.DESC, iDesc);
		Heb.setText(popupMC.LIFE, game.gameData.dictionary.LIFE + ":");
		Heb.setText(popupMC.MAGIC, game.gameData.dictionary.MAGIC + ":");
		Heb.setText(popupMC.REGENERATION, game.gameData.dictionary.REGENERATION + ":");
		Heb.setText(popupMC.MIN_LEVEL, game.gameData.dictionary.MIN_LEVEL + ":");
		setColorAndText(popupMC.lifeDT, "addLife");
		setColorAndText(popupMC.magicDT, "addMagic");
		setColorAndText(popupMC.regenerationDT, "addRoundRegeneration");
		popupMC.minLevelDT.text = minLevel;
		if (minLevel > game.gameData.playerData.level) {
			_loc1_ = new TextFormat();
			_loc1_.color = "0xF35454";
			_loc1_.bold = true;
			popupMC.minLevelDT.setTextFormat(_loc1_);
			popupMC.MIN_LEVEL.setTextFormat(_loc1_);
		}
	}

	public function addClickEvent(param1:Dynamic, param2:Dynamic, param3:Dynamic):Dynamic {
		mc.addEventListener(MouseEvent.CLICK, itemClicked);
		mc.buttonMode = true;
		mc.tabEnabled = false;
		screen = param1;
		screenType = param3;
		indexInScreen = param2;
		if (minLevel <= screen.game.gameData.playerData.level) {
			frameMC.gotoAndStop("reg");
			mc.disabled = false;
		} else {
			frameMC.gotoAndStop("disable");
			mc.disabled = true;
		}
		mc.addEventListener(MouseEvent.ROLL_OVER, itemRolledOver);
		mc.addEventListener(MouseEvent.ROLL_OUT, itemRolledOut);
	}

	function itemRolledOverOnBaby(param1:MouseEvent):Void {
		var _loc2_:Dynamic = undefined;
		if (!game.msgShown) {
			setBasicPopupText();
			popupMC.PRICE.text = "";
			popupMC.priceDT.text = "";
			_loc2_ = ["hatMC", "capeMC", "beltMC", "shoesMC", "stickMC"];
			popupMC.backMC.gotoAndStop(2);
			popupMC.x = screen.mc.babyMC[_loc2_[iType - 1]].x + screen.mc.babyMC.x - popupMC.backMC.width;
			popupMC.y = screen.mc.babyMC[_loc2_[iType - 1]].y + screen.mc.babyMC.y + frameMC.height / 2;
			screen.mc.addChild(popupMC);
		}
	}

	function itemStoreRolledOver(param1:MouseEvent):Void {
		if (!game.msgShown) {
			setBasicPopupText();
			Heb.setText(popupMC.PRICE, game.gameData.dictionary.PRICE + ":");
			popupMC.priceDT.text = buyPrice;
			popupMC.x = screen.mc.storeItemsSP.x + mc.x + frameMC.width;
			popupMC.y = screen.mc.storeItemsSP.y + mc.y + frameMC.height / 2 - screen.mc.storeItemsSP.verticalScrollPosition;
			screen.mc.addChild(popupMC);
		}
	}

	function itemRolledOut(param1:MouseEvent):Void {
		if (screen.mc.contains(popupMC)) {
			screen.mc.removeChild(popupMC);
		}
	}
}
