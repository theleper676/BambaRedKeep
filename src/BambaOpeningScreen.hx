package;

import flash.display.*;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.net.SharedObject;
import flash.ui.Keyboard;
import general.ButtonUpdater;
import general.Heb;

class BambaOpeningScreen {
	var mc:MovieClip;

	var userPassSharedObject:SharedObject;

	public var currStage:Float;

	var game:MovieClip;

	public function new(param1:Dynamic) {
		super();
		game = param1;
		mc = BambaAssets.openingScreen();
		ButtonUpdater.setButton(mc.enterMC, enterClicked);
		ButtonUpdater.setButton(mc.newMC, newClicked);
		ButtonUpdater.setButton(mc.loginMC.forgetPassMC, forgetPassClicked);
		ButtonUpdater.setButton(mc.loginMC.backMC, loginBackClicked);
		ButtonUpdater.setButton(mc.forgetPassWinMC.sendMailMC, sendMailClicked);
		ButtonUpdater.setButton(mc.forgetPassWinMC.backMC, forgetBackClicked);
		mc.loginMC.passIT.displayAsPassword = true;
		game.stage.addEventListener(MouseEvent.CLICK, setFocusOnUser);
		mc.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
		setOnStart();
		if (!game.finishLoading) {
			mc.loadingBarMC.flareMC.x = 800;
			mc.loadingBarMC.maskMC.width = 0;
			mc.loadingBarMC.maskMC.x = 800;
			mc.loadingBarMC.msgDT.text = "";
			mc.loadingBarMC.loaderDT.text = "";
			mc.loginMC.errorDT.text = "";
		} else {
			hideLoadingBar();
		}
		userPassSharedObject = SharedObject.getLocal("BambaUserPass743");
		if (userPassSharedObject.data.SOName != "BambaUserPass743") {
			userPassSharedObject.data.SOName = "BambaUserPass743";
			userPassSharedObject.flush();
			game.autoLogin = false;
		} else if (userPassSharedObject.data.user != null) {
			mc.loginMC.userIT.text = userPassSharedObject.data.user;
			mc.loginMC.passIT.text = userPassSharedObject.data.pass;
			if (!game.autoLogin) {}
		} else {
			game.autoLogin = false;
		}
	}

	function setFocusOnUser(param1:MouseEvent):Dynamic {
		game.stage.removeEventListener(MouseEvent.CLICK, setFocusOnUser);
		game.stage.focus = mc.loginMC.userIT;
	}

	function keyPressedDown(param1:KeyboardEvent):Void {
		var _loc2_:Int = 0;
		if (game.msgShown == false) {
			_loc2_ = param1.keyCode;
			switch (_loc2_) {
				case Keyboard.ENTER:
					enterGame();
			}
		}
	}

	function setOnStart():Dynamic {
		currStage = 1;
		mc.gotoAndStop("start");
	}

	function showPassSendMsg():Dynamic {
		currStage = 2;
		mc.gotoAndStop("login");
		Heb.setText(mc.loginMC.errorDT, "שם המשתמש והסיסמה נשלחו לכתובת המייל איתה נרשמת");
	}

	function forgetBackClicked(param1:MouseEvent):Void {
		if (game.msgShown == false) {
			currStage = 2;
			mc.gotoAndStop("login");
		}
	}

	function sendMailClicked(param1:MouseEvent):Void {
		if (game.msgShown == false) {
			game.gameLoader.forgetPass(mc.forgetPassWinMC.mailIT.text);
			Heb.setText(mc.forgetPassWinMC.errorDT, "כתובת המייל בבדיקה");
		}
	}

	function hideLoadingBar():Dynamic {
		mc.loadingBarMC.visible = false;
	}

	function loginBackClicked(param1:MouseEvent):Void {
		if (game.msgShown == false) {
			currStage = 1;
			mc.gotoAndStop("start");
		}
	}

	function newClicked(param1:MouseEvent):Void {
		if (game.finishLoading) {
			if (game.msgShown == false) {
				game.innerCount(12);
				game.initGeneral();
				game.movie.loadAndShow();
			}
		} else {
			Heb.setText(mc.loadingBarMC.msgDT, "רגע... עוד לא סיימנו לטעון");
		}
	}

	public function saveUserPass(param1:Dynamic, param2:Dynamic):Dynamic {
		userPassSharedObject.data.user = param1;
		userPassSharedObject.data.pass = param2;
	}

	function forgetPassClicked(param1:MouseEvent):Void {
		if (game.msgShown == false) {
			currStage = 3;
			mc.gotoAndStop("forgetPass");
		}
	}

	function enterGame():Dynamic {
		if (!game.didLogin) {
			saveUserPass(mc.loginMC.userIT.text, mc.loginMC.passIT.text);
			userPassSharedObject.flush();
			game.gameLoader.loadPlayerData(mc.loginMC.userIT.text, mc.loginMC.passIT.text);
			Heb.setText(mc.loadingBarMC.msgDT, "בודק את שם המשתמש והסיסמה");
		} else {
			Heb.setText(mc.loadingBarMC.msgDT, "רגע... עוד לא סיימנו לטעון");
		}
	}

	function enterClicked(param1:MouseEvent):Void {
		if (game.msgShown == false) {
			trace("currStage:" + currStage);
			switch (currStage) {
				case 1:
					if (game.autoLogin) {
						enterGame();
					} else {
						currStage = 2;
						mc.gotoAndStop("login");
					}
					break;
				case 2:
					enterGame();
			}
		}
	}

	function showForgetPassErrorMsg(param1:Float):Dynamic {
		switch (param1) {
			case 1:
				Heb.setText(mc.forgetPassWinMC.errorDT, "כתובת המייל לא נמצאה, האם זו הכתובת איתה נרשמת למשחק?");
				break;
			case 2:
				Heb.setText(mc.forgetPassWinMC.errorDT, "כתובת המייל אינה חוקית");
		}
	}

	function showErrorMsg(param1:Float):Dynamic {
		switch (param1) {
			case 1:
				currStage = 2;
				mc.gotoAndStop("login");
				Heb.setText(mc.loginMC.errorDT, "שם המשתמש אינו קיים");
				break;
			case 2:
				currStage = 2;
				mc.gotoAndStop("login");
				Heb.setText(mc.loginMC.errorDT, "טעית בהקשת הסיסמה. נסה שוב");
		}
	}
}
