package;

import haxe.Timer;
import openfl.display.DisplayObject;
import openfl.display.*;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.utils.*;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;

class BambaCharacterBuildScreen extends DisplayObject {
	var babyGraphics:MovieClip;

	var line2Picks:Array<Dynamic>;

	var mc:Dynamic;

	var currTabType:Float;

	var currTabIndex:Int;

	var currStage:Float;

	var game:BambaMain;

	var line1Picks:Array<Dynamic>;

	var playSlideInSoundTimer:Timer = null;
	//var playSlideInSoundInterval:Float;

	var ItemsIdPicked:Array<Dynamic>;

	var currOrder:Float;

	public function new(mainGame:BambaMain) {
		super();
		var _loc2_:Int = 0;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		var _loc8_:Null<Dynamic> = null;
		game = mainGame;
		mc = BambaAssets.characterBuildScreen();
		mc.stop();
		game.gameData.playerData.resetPlayerData();
		babyGraphics = BambaAssets.babyMain();
		mc.babyMC.addChild(babyGraphics);
		babyGraphics.scaleX = 1.8;
		babyGraphics.scaleY = 1.8;
		babyGraphics.x = 100;
		babyGraphics.y = 290;
		Heb.setText(mc.orderMC.CH_B_TITLE, game.gameData.dictionary.CH_B_TITLE);
		Heb.setText(mc.orderMC.CH_B_TEXT, game.gameData.dictionary.CH_B_TEXT);
		_loc2_ = 0;
		while (_loc2_ < 3) {
			_loc3_ = "order" + Std.string(_loc2_ + 1);
			_loc4_ = mc.orderMC[_loc3_];
			_loc4_.iconMC.gotoAndStop(_loc2_ + 1);
			_loc5_ = game.gameData.dictionary.CH_B_OREDER_PRE + Std.string(game.gameData.dictionary.ORDERS).split(",")[_loc2_];
			Heb.setText(_loc4_.ORDER_NAME, _loc5_);
			Heb.setText(_loc4_.ORDER_DESC, game.gameData.dictionary.CH_B_ORDERS_DESCS.split(",")[_loc2_]);
			_loc4_.orderCode = _loc2_ + 1;
			_loc4_.isPicked = false;
			_loc4_.addEventListener(MouseEvent.CLICK, orderClicked);
			_loc4_.addEventListener(MouseEvent.ROLL_OVER, orderRollOver);
			_loc4_.addEventListener(MouseEvent.ROLL_OUT, orderRollOut);
			_loc4_.buttonMode = true;
			_loc4_.tabEnabled = false;
			_loc4_.mouseChildren = false;
			_loc2_++;
		}
		ButtonUpdater.setButton(mc.orderMC.continueMC, continueClicked);
		ButtonUpdater.setButton(mc.orderMC.backMC, backClicked);
		line1Picks = [0, 0, 0, 0, 0, 0];
		line2Picks = [0, 0, -1, -1, -1, -1];
		_loc2_ = 0;
		while (_loc2_ < 6) {
			_loc6_ = "tab" + Std.string(_loc2_ + 1);
			(_loc7_ = mc.customMC[_loc6_]).tabIndex = _loc2_;
			_loc8_ = game.gameData.dictionary.CH_B_TABS.split(",")[_loc2_];
			Heb.setText(_loc7_.tabNameMC.TAB_NAME, _loc8_);
			_loc7_.addEventListener(MouseEvent.CLICK, tabClicked);
			_loc7_.buttonMode = true;
			_loc7_.tabEnabled = false;
			_loc2_++;
		}
		ButtonUpdater.setButton(mc.customMC.continueMC, continueClicked);
		ButtonUpdater.setButton(mc.customMC.backMC, backClicked);
		game.gameData.playerData.updateBabysLook(babyGraphics);
		Heb.setText(mc.customMC.CH_B_CUSTOM_HEAD, game.gameData.dictionary.CH_B_CUSTOM_HEAD);
		Heb.setText(mc.nameMC.CH_B_NAME_TITLE, game.gameData.dictionary.CH_B_NAME_TITLE);
		Heb.setText(mc.nameMC.CH_B_NAME_DESC, game.gameData.dictionary.CH_B_NAME_DESC);
		Heb.setText(mc.nameMC.CH_B_NAME_QUES, game.gameData.dictionary.CH_B_NAME_QUES);
		ButtonUpdater.setButton(mc.nameMC.continueMC, continueClicked);
		ButtonUpdater.setButton(mc.nameMC.backMC, backClicked);
		mc.nameMC.nameIT.addEventListener(Event.CHANGE, nameChanged);
		reset();
	}

	function orderClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			setOrder(param1.currentTarget.orderCode);
		}
	}

	function backClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			if (currStage >= 3 && currStage <= 8) {
				if (currStage == 8) {
					game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
					playSlideInSoundTimer = new Timer(600);
					playSlideInSoundTimer.run = playSlideInSound;
					//playSlideInSoundInterval = setInterval(playSlideInSound, 600);
					mc.gotoAndPlay("nameOut");
				}
				setTab(currStage - 3);
			}
			if (currStage == 2) {
				game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
				playSlideInSoundTimer = new Timer(600);
				playSlideInSoundTimer.run = playSlideInSound;
				// playSlideInSoundInterval = setInterval(playSlideInSound, 600);
				mc.gotoAndPlay("customOut");
			}
			if (currStage == 1) {
				game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
				playSlideInSoundTimer = new Timer(600);
				playSlideInSoundTimer.run = showMenuScreenCont;
				// playSlideInSoundInterval = setInterval(showMenuScreenCont, 600);
				mc.gotoAndPlay("schoolOut");
			}
			--currStage;
		}
	}

	function startGameCont():Void {
		playSlideInSoundTimer.stop();
		// clearInterval(playSlideInSoundInterval);
		game.innerCount(13);
		game.startGame();
	}

	function updateSecondLine():Void {
		var _loc1_:Null<Dynamic> = null;
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:BambaItem = null;
		while (mc.customMC.secondLineMC.numChildren > 0) {
			mc.customMC.secondLineMC.removeChildAt(0);
		}
		_loc1_ = true;
		switch (Std.int(currTabType)) {
			case 0:
				_loc2_ = game.gameData.characterCustomDefs[currTabIndex][2];
			case 1:
				if (line1Picks[currTabIndex] != -1) {
					_loc2_ = game.gameData.characterCustomDefs[currTabIndex][Std.int(line1Picks[currTabIndex]) + 2];
				} else {
					_loc1_ = false;
				}
			case 2:
				if (line1Picks[currTabIndex] != 0) {
					_loc2_ = game.gameData.characterCustomDefs[currTabIndex][Std.int(line1Picks[currTabIndex]) + 1];
				} else {
					_loc2_ = [];
					itemClicked(-1, 2, -1);
					_loc1_ = false;
				}
		}
		if (_loc1_) {
			_loc3_ = 0;
			_loc4_ = 0;
			while (_loc4_ < _loc2_.length) {
				_loc5_ = new BambaItem(game.gameData.getCatalogItem(_loc2_[_loc4_]).xmlData);
				_loc5_.init(game);
				if (_loc5_ != null) {
					_loc5_.generateMC();
					mc.customMC.secondLineMC.addChild(_loc5_.mc);
					_loc5_.mc.x = 340 - _loc3_ * 85;
					_loc5_.addCharecterBuildClickEvent(this, 2, _loc3_);
					_loc3_++;
				}
				_loc4_++;
			}
			itemClicked(_loc5_.id, 2, line2Picks[currTabIndex]);
		}
	}

	function setOrder(param1:Dynamic):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		currOrder = param1;
		_loc4_ = 0;
		while (_loc4_ < 3) {
			if (_loc4_ + 1 == param1) {
				_loc2_ = "order" + Std.string(_loc4_ + 1);
				_loc3_ = mc.orderMC[_loc2_];
				_loc3_.isPicked = true;
				_loc3_.gotoAndStop("pick");
			} else {
				_loc2_ = "order" + Std.string(_loc4_ + 1);
				_loc3_ = mc.orderMC[_loc2_];
				_loc3_.isPicked = false;
				_loc3_.gotoAndStop("reg");
			}
			_loc4_++;
		}
		game.gameData.playerData.resetPlayerData("", currOrder);
		game.gameData.playerData.updateBabysLook(babyGraphics);
		if (currOrder != 0) {
			_loc5_ = game.gameData.dictionary.CH_B_OREDER_PRE + Std.string(game.gameData.dictionary.ORDERS).split(",")[currOrder - 1];
			Heb.setText(mc.plateMC.orderDT, _loc5_);
			_loc6_ = "order" + currOrder;
			game.frameMC.holesMC.gotoAndStop(_loc6_);
		} else {
			mc.plateMC.orderDT.text = "";
		}
	}

	function playSlideInSound():Void {
		playSlideInSoundTimer.stop();
		// clearInterval(playSlideInSoundInterval);
		game.sound.playEffect("GENERAL_MENU_SLIDE_IN");
	}

	function tabClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			currStage = Std.int(param1.currentTarget.tabIndex) + 2;
			setTab(param1.currentTarget.tabIndex);
		}
	}

	function setTab(param1:Dynamic):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		currTabIndex = param1;
		currTabType = game.gameData.characterCustomDefs[currTabIndex][1];
		_loc2_ = 0;
		while (_loc2_ < 6) {
			_loc3_ = "tab" + Std.string(_loc2_ + 1);
			_loc4_ = mc.customMC[_loc3_];
			if (currTabIndex == _loc2_) {
				_loc4_.gotoAndStop("pick");
			} else {
				_loc4_.gotoAndStop("reg");
			}
			_loc2_++;
		}
		setTabData();
	}

	function showMenuScreenCont():Void {
		playSlideInSoundTimer.stop();
		// clearInterval(playSlideInSoundInterval);
		game.showMenuScreen();
	}

	function itemClicked(param1:Dynamic, param2:Dynamic, param3:Dynamic):Void {
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		if (param3 != -1) {
			_loc5_ = game.gameData.getCatalogItem(param1);
			if (param2 == 1) {
				line1Picks[currTabIndex] = param3;
				_loc6_ = 0;
				if (currTabType == 2) {
					mc.customMC.firstLineMC.getChildAt(0).gotoAndStop("empty");
					if (param3 == 0) {
						mc.customMC.firstLineMC.getChildAt(0).gotoAndStop("empty-pick");
					}
					_loc6_++;
				}
				_loc4_ = _loc6_;
				while (_loc4_ < mc.customMC.firstLineMC.numChildren) {
					mc.customMC.firstLineMC.getChildAt(_loc4_).getChildAt(0).gotoAndStop("reg");
					if (_loc4_ == param3) {
						mc.customMC.firstLineMC.getChildAt(_loc4_).getChildAt(0).gotoAndStop("pick");
					}
					_loc4_++;
				}
				_loc7_ = true;
				if (currTabType == 1 || currTabType == 2) {
					if (line2Picks[currTabIndex] == -1) {
						if (currTabType == 2 && line1Picks[currTabIndex] == 0) {
							line2Picks[currTabIndex] = -1;
						} else {
							line2Picks[currTabIndex] = 0;
						}
					}
					_loc7_ = false;
					updateSecondLine();
				}
				if (_loc7_) {
					ItemsIdPicked = getItemPicked();
					game.gameData.playerData.resetPlayerData("", currOrder, ItemsIdPicked);
					game.gameData.playerData.updateBabysLook(babyGraphics);
				}
			}
			if (param2 == 2) {
				line2Picks[currTabIndex] = -1;
				_loc4_ = 0;
				while (_loc4_ < mc.customMC.secondLineMC.numChildren) {
					mc.customMC.secondLineMC.getChildAt(_loc4_).getChildAt(0).gotoAndStop("reg");
					if (_loc4_ == param3) {
						mc.customMC.secondLineMC.getChildAt(_loc4_).getChildAt(0).gotoAndStop("pick");
						line2Picks[currTabIndex] = param3;
					}
					_loc4_++;
				}
				ItemsIdPicked = getItemPicked();
				game.gameData.playerData.resetPlayerData("", currOrder, ItemsIdPicked);
				game.gameData.playerData.updateBabysLook(babyGraphics);
			}
		} else if (currTabType == 2 && param2 == 2) {
			line2Picks[currTabIndex] = param3;
			ItemsIdPicked = getItemPicked();
			game.gameData.playerData.resetPlayerData("", currOrder, ItemsIdPicked);
			game.gameData.playerData.updateBabysLook(babyGraphics);
		}
	}

	function orderRollOver(param1:MouseEvent):Void {
		if (!game.msgShown) {
			if (param1.currentTarget.isPicked == false) {
				param1.currentTarget.gotoAndStop("rollover");
			}
		}
	}

	function emptyFramePicked():Void {
		itemClicked(-1, 1, 0);
	}

	function orderRollOut(param1:MouseEvent):Void {
		if (!game.msgShown) {
			if (param1.currentTarget.isPicked == false) {
				param1.currentTarget.gotoAndStop("reg");
			}
		}
	}

	function getItemPicked():Dynamic {
		var _loc1_:Array<Dynamic> = null;
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		_loc1_ = [];
		_loc3_ = 0;
		while (_loc3_ < 6) {
			_loc4_ = game.gameData.characterCustomDefs[_loc3_][1];
			if (_loc4_ == 0) {
				if (line1Picks[_loc3_] != -1) {
					_loc2_ = game.gameData.characterCustomDefs[_loc3_][0][line1Picks[_loc3_]];
					_loc1_.push(_loc2_);
				}
				if (line2Picks[_loc3_] != -1) {
					_loc2_ = game.gameData.characterCustomDefs[_loc3_][2][line2Picks[_loc3_]];
					_loc1_.push(_loc2_);
				}
			} else if (_loc4_ == 1) {
				if (line2Picks[_loc3_] != -1) {
					_loc2_ = game.gameData.characterCustomDefs[_loc3_][Std.int(line1Picks[_loc3_]) + 2][line2Picks[_loc3_]];
					_loc1_.push(_loc2_);
				}
			} else if (line2Picks[_loc3_] != -1) {
				_loc2_ = game.gameData.characterCustomDefs[_loc3_][Std.int(line1Picks[_loc3_]) + 1][line2Picks[_loc3_]];
				_loc1_.push(_loc2_);
			}
			_loc3_++;
		}
		return _loc1_;
	}

	function continueClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			if (currStage == 1) {
				if (currOrder == 0) {
					MsgBox.show(game.gameData.dictionary.CH_B_NO_ORDER);
					return;
				}
				game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
				playSlideInSoundTimer = new Timer(600);
				playSlideInSoundTimer.run = playSlideInSound;
				// playSlideInSoundInterval = setInterval(playSlideInSound, 600);
				mc.gotoAndPlay("customIn");
			}
			if (currStage >= 1 && currStage <= 6) {
				setTab(currStage - 1);
			}
			if (currStage == 7) {
				game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
				playSlideInSoundTimer = new Timer(600);
				playSlideInSoundTimer.run = playSlideInSound;
				// playSlideInSoundInterval = setInterval(playSlideInSound, 600);
				mc.gotoAndPlay("nameIn");
			}
			if (currStage == 8) {
				if (mc.nameMC.nameIT.text.length < 3) {
					MsgBox.show(game.gameData.dictionary.CH_B_MIN_NAME);
					return;
				}
				game.gameData.playerData.resetPlayerData(mc.nameMC.nameIT.text, currOrder, ItemsIdPicked);
				game.didLogin = true;
				game.gameLoader.savePlayerData();
				game.sound.playEffect("GENERAL_MENU_SLIDE_OUT");
				playSlideInSoundTimer = new Timer(600);
				playSlideInSoundTimer.run = startGameCont;
				// playSlideInSoundInterval = setInterval(statGameCont, 600);
				mc.gotoAndPlay("nameOutEnd");
				return;
			}
			++currStage;
		}
	}

	function emptyFrameClicked(param1:MouseEvent):Void {
		if (!game.msgShown) {
			game.sound.playEffect("GENERAL_MENU_CLICK");
			emptyFramePicked();
		}
	}

	function nameChanged(param1:Event):Void {
		Heb.setText(mc.plateMC.nameDT, mc.nameMC.nameIT.text);
	}

	function reset():Void {
		currStage = 1;
		line1Picks = [0, 0, 0, 0, 0, 0];
		line2Picks = [0, 0, -1, -1, -1, -1];
		mc.nameMC.nameIT.text = "";
		mc.plateMC.nameDT.text = "";
		setOrder(0);
		setTab(0);
	}

	function slideIn():Void {
		game.sound.playEffect("GENERAL_MENU_SLIDE_IN");
		mc.gotoAndPlay("schoolIn");
	}

	function setTabData():Void {
		var _loc1_:Null<Dynamic> = null;
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		var _loc8_:BambaItem = null;
		_loc1_ = game.gameData.dictionary.CH_B_FIRST_LINE.split(",")[currTabIndex];
		_loc2_ = game.gameData.dictionary.CH_B_SECOND_LINE.split(",")[currTabIndex];
		Heb.setText(mc.customMC.CH_B_FIRST_LINE, _loc1_);
		Heb.setText(mc.customMC.CH_B_SECOND_LINE, _loc2_);
		_loc3_ = game.gameData.characterCustomDefs[currTabIndex][0];
		while (mc.customMC.firstLineMC.numChildren > 0) {
			mc.customMC.firstLineMC.removeChildAt(0);
		}
		_loc4_ = 0;
		_loc5_ = 340;
		if (currTabType == 2) {
			_loc7_ = BambaAssets.itemFrame;
			mc.customMC.firstLineMC.addChild(_loc7_);
			_loc7_.x = _loc5_;
			_loc7_.addEventListener(MouseEvent.CLICK, emptyFrameClicked);
			_loc7_.buttonMode = true;
			_loc7_.tabEnabled = false;
			_loc7_.gotoAndStop("empty-pick");
			_loc4_++;
		}
		_loc6_ = 0;
		while (_loc6_ < _loc3_.length) {
			_loc8_ = new BambaItem(game.gameData.getCatalogItem(_loc3_[_loc6_]).xmlData);
			_loc8_.init(game);
			if (_loc8_ != null) {
				_loc8_.generateMC();
				mc.customMC.firstLineMC.addChild(_loc8_.mc);
				_loc8_.mc.x = _loc5_ - _loc4_ * 85;
				_loc8_.addCharecterBuildClickEvent(this, 1, _loc4_);
				_loc4_++;
			}
			_loc6_++;
		}
		itemClicked(_loc8_.id, 1, line1Picks[currTabIndex]);
		if (currTabType == 2) {
			if (line1Picks[currTabIndex] == 0) {
				emptyFramePicked();
			}
		} else {
			updateSecondLine();
		}
	}
}
