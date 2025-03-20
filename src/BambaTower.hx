package;

import openfl.display.*;
import openfl.events.Event;
import openfl.events.MouseEvent;
import general.ButtonUpdater;

class BambaTower {
	var layer1:Array<Dynamic>;

	var layer4:Array<Dynamic>;

	var layer2:Array<Dynamic>;

	var layer3:Array<Dynamic>;

	var layer2movment:Dynamic = 4.8;

	var mc:MovieClip;

	var layer4movment:Dynamic = 3.5;

	var movingRight:Bool;

	var layer3movment:Dynamic = 4.2;

	var game:MovieClip;

	var layer1Pos:Float;

	var movingLeft:Bool;

	var layer1movment:Dynamic = 5;

	public function new(param1:Dynamic) {
		layer1movment = 5;
		layer2movment = 4.8;
		layer3movment = 4.2;
		layer4movment = 3.5;
		super();
		game = param1;
		mc = BambaAssets.towerScreen();
		mc.rightArrowMC.gotoAndStop(1);
		mc.leftArrowMC.gotoAndStop(1);
		ButtonUpdater.setButton(mc.exitMC, exitClicked);
		ButtonUpdater.setButton(mc.questMC, questClicked);
		ButtonUpdater.setButton(mc.magicMC, magicClicked);
		ButtonUpdater.setButton(mc.upgradeMC, upgradeClicked);
		ButtonUpdater.setButton(mc.storeMC, storeClicked);
		mc.characterMC.addEventListener(MouseEvent.CLICK, characterClicked);
		mc.characterMC.buttonMode = true;
		mc.characterMC.tabEnabled = false;
		layer1 = [mc.towerBackMC, mc.exitMC];
		layer2 = [mc.upgradeMC, mc.storeMC];
		layer3 = [mc.columnsMC];
		layer4 = [mc.questMC, mc.magicMC];
		movingLeft = false;
		movingRight = false;
		layer1Pos = 0;
		mc.moveRightMC.addEventListener(MouseEvent.ROLL_OVER, setMoveRightOn);
		mc.moveRightMC.addEventListener(MouseEvent.ROLL_OUT, setMoveRightOff);
		mc.moveRightMC.addEventListener(Event.ENTER_FRAME, moveRight);
		mc.moveLeftMC.addEventListener(MouseEvent.ROLL_OVER, setMoveLeftOn);
		mc.moveLeftMC.addEventListener(MouseEvent.ROLL_OUT, setMoveLeftOff);
		mc.moveLeftMC.addEventListener(Event.ENTER_FRAME, moveLeft);
		updateQuestIcon();
	}

	function updateQuestIcon():Dynamic {
		mc.exitMC.specialMC.gotoAndStop("reg");
		mc.questMC.specialMC.gotoAndStop("reg");
		if (game.questManager != null) {
			if (game.questManager.currQuestId != 0) {
				mc.exitMC.specialMC.gotoAndPlay("special");
			} else {
				mc.questMC.specialMC.gotoAndStop("special");
			}
		}
	}

	function moveRight(param1:Event):Void {
		var _loc2_:Dynamic = undefined;
		if (movingRight) {
			if (layer1Pos > -750) {
				_loc2_ = 0;
				while (_loc2_ < layer1.length) {
					layer1[_loc2_].x -= mc.moveRightMC.mouseX / layer1movment;
					_loc2_++;
				}
				_loc2_ = 0;
				while (_loc2_ < layer2.length) {
					layer2[_loc2_].x -= mc.moveRightMC.mouseX / layer2movment;
					_loc2_++;
				}
				_loc2_ = 0;
				while (_loc2_ < layer3.length) {
					layer3[_loc2_].x -= mc.moveRightMC.mouseX / layer3movment;
					_loc2_++;
				}
				_loc2_ = 0;
				while (_loc2_ < layer4.length) {
					layer4[_loc2_].x -= mc.moveRightMC.mouseX / layer4movment;
					_loc2_++;
				}
				layer1Pos -= mc.moveRightMC.mouseX / layer1movment;
			}
		}
	}

	function upgradeClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.showUpgradeCrads();
		}
	}

	function magicClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.showMagicBook();
		}
	}

	function setMoveLeftOff(param1:MouseEvent):Void {
		movingLeft = false;
		mc.leftArrowMC.gotoAndStop(1);
	}

	function setMoveRightOn(param1:MouseEvent):Void {
		if (!game.msgShown) {
			movingRight = true;
			mc.rightArrowMC.gotoAndStop(2);
		}
	}

	function setMoveLeftOn(param1:MouseEvent):Void {
		if (!game.msgShown) {
			movingLeft = true;
			mc.leftArrowMC.gotoAndStop(2);
		}
	}

	function setMoveRightOff(param1:MouseEvent):Void {
		movingRight = false;
		mc.rightArrowMC.gotoAndStop(1);
	}

	function exitClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.showMap();
		}
	}

	function moveLeft(param1:Event):Void {
		var _loc2_:Dynamic = undefined;
		if (movingLeft) {
			if (layer1Pos < 0) {
				_loc2_ = 0;
				while (_loc2_ < layer1.length) {
					layer1[_loc2_].x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer1movment;
					_loc2_++;
				}
				_loc2_ = 0;
				while (_loc2_ < layer2.length) {
					layer2[_loc2_].x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer2movment;
					_loc2_++;
				}
				_loc2_ = 0;
				while (_loc2_ < layer3.length) {
					layer3[_loc2_].x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer3movment;
					_loc2_++;
				}
				_loc2_ = 0;
				while (_loc2_ < layer4.length) {
					layer4[_loc2_].x += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer4movment;
					_loc2_++;
				}
				layer1Pos += (mc.moveLeftMC.width - mc.moveLeftMC.mouseX) / layer1movment;
			}
		}
	}

	function questClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.showQuestManager();
		}
	}

	function characterClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			game.showCharacter();
		}
	}

	function storeClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.showStore();
		}
	}
}
