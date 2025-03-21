package general;

import openfl.display.*;
import openfl.events.MouseEvent;

class MsgBox extends DisplayObject  {
	static var yesNoBoxLink:Null<Dynamic>;

	static var msgBoxCloseFunction:Null<Dynamic>;

	static var waitBoxCloseFunction:Null<Dynamic>;

	static var needToShowLevelBox:Bool;

	static var yesNoConfirmFunction:Null<Dynamic>;

	static var yesNoCancelFunction:Null<Dynamic>;

	static var game:Null<Dynamic>;

	static var waitBoxLink:Null<Dynamic>;

	static var msgBoxMCLink:Null<Dynamic>;

	public static var version:Float = 1;

	static var bambaAssets: Dynamic;

	public function new() {
		super();
		needToShowLevelBox = false;
	}

	public static function showYesNoBox(param1:String, param2:Dynamic = null, param3:Dynamic = null, param4:Float = -1):Void {
		var _loc5_:Dynamic = null;
		var _loc6_:Dynamic = null;
		_loc5_ = BambaAssets.yesNoBox();
		yesNoBoxLink = _loc5_;
		yesNoConfirmFunction = param2;
		yesNoCancelFunction = param3;
		game.addChild(_loc5_);
		game.msgShown = true;
		game.centerScreen(_loc5_);
		ButtonUpdater.setButton(_loc5_.confirmButton, yesNoConfirm);
		ButtonUpdater.setButton(_loc5_.cancelButton, yesNoCancel);
		Heb.setText(_loc5_.dt, param1);
		if (param4 >= 0) {
			_loc6_ = BambaAssets.prizeIcon();
			_loc5_.addChild(_loc6_);
			_loc6_.iconMC.gotoAndStop(1);
			_loc6_.DT.text = param4;
			_loc6_.x = 115;
			_loc6_.y = 95;
			_loc6_.scaleX = 1.5;
			_loc6_.scaleY = 1.5;
		}
	}

	public static function showLevelBox():Void {
		var _loc1_:Dynamic = null;
		var _loc2_:Dynamic = null;
		var _loc3_:Dynamic = null;
		var _loc4_:Dynamic = null;
		var _loc5_:Dynamic = null;
		var _loc6_:Dynamic = null;
		needToShowLevelBox = false;
		_loc1_ = BambaAssets.levelBox();
		msgBoxMCLink = _loc1_;
		game.addChild(_loc1_);
		game.msgShown = true;
		game.centerScreen(_loc1_);
		ButtonUpdater.setButton(_loc1_.exitButton, closeMsgBox);
		Heb.setText(_loc1_.headDT, game.gameData.dictionary.LEVEL_UP_MSG_HEAD);
		Heb.setText(_loc1_.dt, game.gameData.dictionary.LEVEL_UP_MSG);
		_loc1_.levelDT.text = game.gameData.playerData.level;
		Heb.setText(_loc1_.LIFE, game.gameData.dictionary.LIFE);
		Heb.setText(_loc1_.MAGIC, game.gameData.dictionary.MAGIC);
		Heb.setText(_loc1_.REGENERATION, game.gameData.dictionary.REGENERATION);
		_loc2_ = game.gameData.playerData.level - 1;
		_loc3_ = game.gameData.playerData.level;
		_loc4_ = game.gameData.getCatalogPlayerLevel(_loc3_).maxLife - game.gameData.getCatalogPlayerLevel(_loc2_).maxLife;
		_loc5_ = game.gameData.getCatalogPlayerLevel(_loc3_).maxMagic - game.gameData.getCatalogPlayerLevel(_loc2_).maxMagic;
		_loc6_ = game.gameData.getCatalogPlayerLevel(_loc3_).roundRegeneration - game.gameData.getCatalogPlayerLevel(_loc2_).roundRegeneration;
		_loc1_.lifeDT.text = "+" + _loc4_;
		_loc1_.magicDT.text = "+" + _loc5_;
		_loc1_.regenerationDT.text = "+" + _loc6_;
		game.sound.playEffect("GENERAL_LEVEL_UP");
	}

	public static function updateWaitBox(param1:Float):Void {
		waitBoxLink.prcMC.dt.text = param1 + "%";
		waitBoxLink.flareMC.x = 46 + 505 - 505 * param1 / 100;
		waitBoxLink.maskMC.width = 505 * param1 / 100;
		waitBoxLink.maskMC.x = 46 + 505 - 505 * param1 / 100;
	}

	public static function init(param1:Dynamic):Void {
		game = param1;
	}

	public static function showWaitBox(param1:String, param2:Dynamic = null):Void {
		var _loc3_:Dynamic = null;
		_loc3_ = BambaAssets.waitBox;
		waitBoxLink = _loc3_;
		waitBoxCloseFunction = param2;
		updateWaitBox(0);
		game.addChild(_loc3_);
		game.msgShown = true;
		Heb.setText(_loc3_.dt, param1);
		game.centerScreen(_loc3_);
	}

	static function yesNoConfirm(param1:MouseEvent):Void {
		game.sound.playEffect("GENERAL_MENU_CLICK");
		game.removeChild(yesNoBoxLink);
		game.msgShown = false;
		if (yesNoConfirmFunction != null) {
			yesNoConfirmFunction.call();
		}
	}

	public static function updateWaitBoxTxt(param1:String):Void {
		Heb.setText(waitBoxLink.dt, param1);
	}

	public static function showWin(param1:String, param2:Array<Dynamic>, param3:Dynamic = null, param4:Float = 1):Void {
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		var _loc8_:Null<Dynamic> = null;
		var _loc9_:Null<Dynamic> = null;
		var _loc10_:Null<Dynamic> = null;
		_loc5_ = BambaAssets.winBox;
		msgBoxMCLink = _loc5_;
		msgBoxCloseFunction = param3;
		game.addChild(_loc5_);
		game.msgShown = true;
		game.centerScreen(_loc5_);
		ButtonUpdater.setButton(_loc5_.exitButton, closeMsgBox);
		if (param2[0] != 0) {
			_loc8_ = game.gameData.dictionary.MSG_WIN1;
			_loc9_ = param2[0] + " " + game.gameData.dictionary.EXPOINTS;
			if (param2[1] > 0) {
				needToShowLevelBox = true;
			}
		} else {
			_loc8_ = "";
			_loc9_ = "";
		}
		Heb.setText(_loc5_.headDT, param1);
		Heb.setText(_loc5_.dt1, _loc8_);
		Heb.setText(_loc5_.dt2, _loc9_);
		_loc5_.iconMC.gotoAndStop(param4);
		if (param2[2] != null) {
			_loc6_ = 0;
			while (_loc6_ < param2[2].length) {
				_loc10_ = new BambaItem(game.gameData.getCatalogItem(param2[2][_loc6_]).xmlData);
				_loc10_.init(game);
				_loc10_.generateMC();
				_loc10_.addPopupInMsg(msgBoxMCLink);
				_loc5_.prizesMC.addChild(_loc10_.mc);
				_loc6_++;
			}
		}
		if (param2[3] != null) {
			if (param2[3] > 0) {
				_loc7_ = BambaAssets.prizeIcon();
				_loc5_.prizesMC.addChild(_loc7_);
				_loc7_.iconMC.gotoAndStop(1);
				_loc7_.DT.text = param2[3];
			}
		}
		switch (_loc5_.prizesMC.numChildren) {
			case 1:
				_loc5_.prizesMC.getChildAt(0).x = 60;
				_loc5_.prizesMC.getChildAt(0).y = 0;
				_loc5_.prizesMC.getChildAt(0).scaleX = 1.5;
				_loc5_.prizesMC.getChildAt(0).scaleY = 1.5;
			case 2:
				_loc5_.prizesMC.getChildAt(1).x = 0;
				_loc5_.prizesMC.getChildAt(1).y = 0;
				_loc5_.prizesMC.getChildAt(1).scaleX = 1.5;
				_loc5_.prizesMC.getChildAt(1).scaleY = 1.5;
				_loc5_.prizesMC.getChildAt(0).x = 120;
				_loc5_.prizesMC.getChildAt(0).y = 0;
				_loc5_.prizesMC.getChildAt(0).scaleX = 1.5;
				_loc5_.prizesMC.getChildAt(0).scaleY = 1.5;
		}
		_loc6_ = 0;
		while (_loc6_ < param2.length - 4) {
			if (param2[_loc6_ + 4] > 0) {
				_loc7_ = BambaAssets.prizeIcon();
				_loc5_.ingredientsMC.addChild(_loc7_);
				_loc7_.iconMC.gotoAndStop(_loc6_ + 2);
				_loc7_.DT.text = param2[_loc6_ + 4];
			}
			_loc6_++;
		}
		switch (_loc5_.ingredientsMC.numChildren) {
			case 1:
				_loc5_.ingredientsMC.getChildAt(0).x = 80;
				_loc5_.ingredientsMC.getChildAt(0).y = 20;
			case 2:
				_loc5_.ingredientsMC.getChildAt(1).x = 40;
				_loc5_.ingredientsMC.getChildAt(1).y = 20;
				_loc5_.ingredientsMC.getChildAt(0).x = 120;
				_loc5_.ingredientsMC.getChildAt(0).y = 20;
			case 3:
				_loc5_.ingredientsMC.getChildAt(2).x = 80;
				_loc5_.ingredientsMC.getChildAt(2).y = 45;
				_loc5_.ingredientsMC.getChildAt(1).x = 40;
				_loc5_.ingredientsMC.getChildAt(1).y = 0;
				_loc5_.ingredientsMC.getChildAt(0).x = 120;
				_loc5_.ingredientsMC.getChildAt(0).y = 0;
			case 4:
				_loc5_.ingredientsMC.getChildAt(3).x = 40;
				_loc5_.ingredientsMC.getChildAt(3).y = 45;
				_loc5_.ingredientsMC.getChildAt(2).x = 120;
				_loc5_.ingredientsMC.getChildAt(2).y = 45;
				_loc5_.ingredientsMC.getChildAt(1).x = 40;
				_loc5_.ingredientsMC.getChildAt(1).y = 0;
				_loc5_.ingredientsMC.getChildAt(0).x = 120;
				_loc5_.ingredientsMC.getChildAt(0).y = 0;
		}
	}

	static function closeMsgBox(param1:MouseEvent):Void {
		game.sound.playEffect("GENERAL_MENU_CLICK");
		game.removeChild(msgBoxMCLink);
		if (needToShowLevelBox) {
			showLevelBox();
		} else {
			game.msgShown = false;
			if (msgBoxCloseFunction != null) {
				msgBoxCloseFunction.call();
			}
		}
	}

	public static function showQuestBox(param1:String, param2:Float, param3:Array<Dynamic>, param4:Dynamic = null):Void {
		var _loc5_:Null<Dynamic> = null;
		_loc5_ = BambaAssets.questBox();
		msgBoxMCLink = _loc5_;
		msgBoxCloseFunction = param4;
		game.addChild(_loc5_);
		game.msgShown = true;
		game.centerScreen(_loc5_);
		ButtonUpdater.setButton(_loc5_.exitButton, closeMsgBox);
		if (param3[1] > 0) {
			needToShowLevelBox = true;
		}
		Heb.setText(_loc5_.headDT, game.gameData.dictionary.QUEST_MSG_HEAD);
		Heb.setText(_loc5_.dt, param1);
		Heb.setText(_loc5_.EXPOINTS, game.gameData.dictionary.EXPOINTS);
		_loc5_.exPointsDT.text = param3[0];
		_loc5_.prizeMC.DT.text = param3[3];
		_loc5_.questIconMC.gotoAndStop(param2);
		_loc5_.prizeMC.prizeIconMC.gotoAndStop(1);
		game.sound.playEffect("MAZE_QUEST_WIN");
	}

	static function yesNoCancel(param1:MouseEvent):Void {
		game.sound.playEffect("GENERAL_MENU_CLICK");
		game.removeChild(yesNoBoxLink);
		game.msgShown = false;
		if (yesNoCancelFunction != null) {
			yesNoCancelFunction.call();
		}
	}

	public static function show(param1:String, param2:Dynamic = null, param3:Float = 4):Void {
		var _loc4_:Null<Dynamic> = null;
		_loc4_ = BambaAssets.msgBox;
		msgBoxMCLink = _loc4_;
		msgBoxCloseFunction = param2;
		game.addChild(_loc4_);
		game.msgShown = true;
		game.centerScreen(_loc4_);
		ButtonUpdater.setButton(_loc4_.exitButton, closeMsgBox);
		Heb.setText(_loc4_.dt, param1);
		_loc4_.iconMC.gotoAndStop(param3);
	}

	public static function closeWaitBox():Void {
		game.msgShown = false;
		game.removeChild(waitBoxLink);
		if (waitBoxCloseFunction != null) {
			waitBoxCloseFunction.call();
		}
	}
}
