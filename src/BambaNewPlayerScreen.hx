package;

import openfl.display.*;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;
import openfl.utils.*;
import general.ButtonUpdater;
import general.MsgBox;

class BambaNewPlayerScreen {
	var isIn:Bool;

	var game:MovieClip;

	var mc:MovieClip;

	var clickContInterval:Float;

	public function new(param1:Dynamic) {
		super();
		game = param1;
		mc = BambaAssets.newPlayerScreen();
		ButtonUpdater.setButton(mc.screenMC.enterMC, enterClicked);
		ButtonUpdater.setButton(mc.screenMC.backMC, backClicked);
		mc.screenMC.passIT.displayAsPassword = true;
		mc.screenMC.confirmPassIT.displayAsPassword = true;
		game.stage.addEventListener(MouseEvent.CLICK, setFocusOnUser);
		mc.screenMC.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
		mc.screenMC.userIT.tabIndex = 1;
		mc.screenMC.passIT.tabIndex = 2;
		mc.screenMC.confirmPassIT.tabIndex = 3;
		mc.screenMC.mailIT.tabIndex = 4;
		mc.screenMC.yearCB.tabIndex = 5;
		mc.screenMC.monthCB.tabIndex = 6;
		mc.screenMC.dayCB.tabIndex = 7;
		isIn = false;
	}

	function setFocusOnUser(param1:MouseEvent):Dynamic {
		game.stage.removeEventListener(MouseEvent.CLICK, setFocusOnUser);
		game.stage.focus = mc.screenMC.userIT;
	}

	function validateMailAddressChars(param1:String):Bool {
		var _loc2_:Bool = false;
		_loc2_ = true;
		if (param1.length <= 0) {
			_loc2_ = false;
		}
		if (param1.search("<") != -1) {
			_loc2_ = false;
		}
		if (param1.search(">") != -1) {
			_loc2_ = false;
		}
		if (param1.search("\\") != -1) {
			_loc2_ = false;
		}
		if (param1.search(";") != -1) {
			_loc2_ = false;
		}
		if (param1.search(":") != -1) {
			_loc2_ = false;
		}
		if (param1.search("]") != -1) {
			_loc2_ = false;
		}
		if (param1.search("(") != -1) {
			_loc2_ = false;
		}
		if (param1.search(")") != -1) {
			_loc2_ = false;
		}
		if (param1.search("[") != -1) {
			_loc2_ = false;
		}
		trace("Checked email address and it is:" + _loc2_.toString());
		return _loc2_;
	}

	function checkEnter():Dynamic {
		var _loc1_:Dynamic = undefined;
		if (!game.msgShown) {
			if (mc.screenMC.userIT.text.length < 3) {
				MsgBox.show(game.gameData.dictionary.NEW_PLAYER_MIN_NAME);
				return;
			}
			if (mc.screenMC.passIT.text.length < 3) {
				MsgBox.show(game.gameData.dictionary.NEW_PLAYER_MIN_PASS);
				return;
			}
			if (mc.screenMC.passIT.text != mc.screenMC.confirmPassIT.text) {
				MsgBox.show(game.gameData.dictionary.NEW_PLAYER_NO_IDENTIC_PASS);
				return;
			}
			if (!validateMailAddressChars(mc.screenMC.mailIT.text)) {
				MsgBox.show(game.gameData.dictionary.NEW_PLAYER_ILLEGAL_MAIL);
				return;
			}
			game.opening.saveUserPass(mc.screenMC.userIT.text, mc.screenMC.passIT.text);
			_loc1_ = mc.screenMC.yearCB.selectedLabel + mc.screenMC.monthCB.selectedLabel + mc.screenMC.dayCB.selectedLabel;
			game.gameLoader.sendNewPlayerData(mc.screenMC.userIT.text, mc.screenMC.passIT.text, mc.screenMC.mailIT.text, _loc1_);
		}
	}

	function keyPressedDown(param1:KeyboardEvent):Void {
		var _loc2_:Int = 0;
		if (!game.msgShown) {
			_loc2_ = param1.keyCode;
			switch (_loc2_) {
				case Keyboard.ENTER:
					checkEnter();
			}
		}
	}

	function slideOut():Dynamic {
		game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
		mc.gotoAndPlay("slideOut");
	}

	function backClicked(param1:MouseEvent):Void {
		slideOut();
		clickContInterval = setInterval(backClickedCont, 500);
	}

	function backClickedCont():Dynamic {
		clearInterval(clickContInterval);
		game.exitToOpeningScreen();
	}

	function enterClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			checkEnter();
		}
	}

	function slideIn():Dynamic {
		if (!isIn) {
			game.sound.playEffect("GENERAL_MENU_SLIDE_IN");
			mc.gotoAndPlay("slideIn");
			isIn = true;
		}
	}
}
