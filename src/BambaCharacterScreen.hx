package;

import openfl.display.*;
import openfl.events.MouseEvent;
import general.ButtonUpdater;
import general.PlayerDataUpdater;

class BambaCharacterScreen {
	public var screenType:Float;

	var game:Dynamic;

	public var mc:Dynamic;

	public function new(param1:Dynamic) {
		var _loc2_:MovieClip = null;
		game = param1;
		mc = BambaAssets.characterScreen;
		mc.orgWidth = mc.width;
		mc.orgHeight = mc.height;
		ButtonUpdater.setButton(mc.exitMC, closeWin);
		mc.exitMC.buttonMode = true;
		mc.exitMC.tabEnabled = false;
		_loc2_ = new MovieClip();
		mc.itemsSP.setStyle("upSkin", _loc2_);
		screenType = 1;
		update();
	}

	public function setCards():Void {
		var _loc1_:Dynamic = null;
		var _loc2_:Null<Int> = null;
		var _loc3_:Dynamic = null;
		_loc1_ = game.gameData.playerData.cards;
		while (mc.cardsMC.numChildren > 0) {
			mc.cardsMC.removeChildAt(0);
		}
		_loc2_ = 0;
		while (_loc2_ < _loc1_.length) {
			_loc3_ = game.gameData.getCatalogCard(_loc1_[_loc2_]);
			_loc3_.generateMC();
			mc.cardsMC.addChild(_loc3_.mc);
			_loc3_.addPopupEvents(this);
			_loc3_.mc.scaleX = 1;
			_loc3_.mc.scaleY = 1;
			_loc3_.mc.x = 216 - _loc2_ % 4 * 72;
			_loc3_.mc.y = Math.floor(_loc2_ / 4) * 95;
			_loc3_.mc.gotoAndStop("front");
			_loc3_.mc.frontMC.gotoAndStop("reg");
			_loc3_.setCardDir(-1);
			_loc2_++;
		}
	}

	function update():Void {
		setCards();
		PlayerDataUpdater.setBaby(mc.babyMC, this);
		PlayerDataUpdater.setItems(mc.itemsMC, mc.itemsSP, this, screenType);
		PlayerDataUpdater.updateBasicData(mc.basicDataMC);
		PlayerDataUpdater.updateProgressData(mc.progressMC);
		PlayerDataUpdater.updateMoneyData(mc.moneyMC);
	}

	public function closeWin(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			game.hideCharacter();
		}
	}

	public function itemClickedOnBaby(param1:Dynamic):Void {
		game.gameData.playerData.removItem(param1);
		PlayerDataUpdater.setBaby(mc.babyMC, this);
		PlayerDataUpdater.setItems(mc.itemsMC, mc.itemsSP, this, screenType);
		PlayerDataUpdater.updateProgressData(mc.progressMC);
	}

	public function itemClicked(param1:Dynamic, param2:Dynamic):Void {
		var _loc3_:Dynamic = null;
		var _loc4_:Null<Bool> = null;
		var _loc5_:Dynamic = null;
		var _loc6_:Dynamic = null;
		_loc3_ = game.gameData.getCatalogItem(param1);
		if (_loc3_.minLevel <= game.gameData.playerData.level) {
			_loc4_ = false;
			_loc5_ = game.gameData.playerData.itemsInUse;
			_loc6_ = 0;
			while (_loc6_ < _loc5_.length) {
				if (param1 == _loc5_[_loc6_]) {
					_loc4_ = true;
				}
				_loc6_++;
			}
			if (!_loc4_) {
				game.sound.playEffect("GENERAL_EQUIP");
				game.gameData.playerData.changeItem(param1);
				PlayerDataUpdater.setBaby(mc.babyMC, this);
				PlayerDataUpdater.setItems(mc.itemsMC, mc.itemsSP, this, screenType);
				PlayerDataUpdater.updateProgressData(mc.progressMC);
			}
		}
	}
}
