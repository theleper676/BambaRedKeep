package;

import erate.ERate;
import openfl.display.*;
import openfl.net.SharedObject;
import openfl.events.*;
import openfl.external.*;
import openfl.system.*;
import openfl.utils.*;
import general.ButtonUpdater;
import general.Heb;
import general.MsgBox;
import general.PlayerDataUpdater;

class BambaMain extends MovieClip {
	var currDungeonDifficulty:Float;
	var gameMap:BambaMap;

	public var msgShown:Bool;

	var gameAssets:BambaAssets;

	public var soundTimingInterval:Float;

	var currDongeonId:Float;

	var magicBook:BambaMagicBook;

	var currEnemyId:Float;

	public var didLogin:Bool;

	var questManager:BambaQuestManager;

	var newPlayer:BambaNewPlayerScreen;

	var gameLoader:BambaLoader;

	var eventTypeNames:Dynamic;

	public var gameData:BambaData;

	var characterBuild:BambaCharacterBuildScreen;

	public var ToolID:Dynamic;

	var store:BambaStore;

	public var autoLogin:Bool;

	var tower:BambaTower;

	var aDungeon:BambaDungeon;

	public var sound:BambaSoundManager;

	var character:BambaCharacterScreen;

	var movie:BambaMovie;

	public var finishLoading:Bool;

	var help:BambaHelp;

	var opening:BambaOpeningScreen;

	var menu:BambaMenuScreen;

	var upgradeSystem:BambaUpgradeSystem;

	public var userSharedObject:SharedObject;

	var showCharacterBuildInteval:Float;

	var eventTypeCodes:Dynamic;

	var frameMC:MovieClip;

	var dungeonMC:MovieClip;

	public function new() {
		eventTypeCodes = [1, 3, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28];
		eventTypeNames = [
			"hasifa",
			"lead",
			"enter game",
			"uniq",
			"new user enter",
			"new user game enter",
			"user game enter",
			"game enter",
			"movie",
			"new character",
			"exit",
			"start mission1",
			"start mission2",
			"start mission3",
			"start mission4",
			"end mission1",
			"end mission2",
			"end mission3",
			"end mission4",
			"help",
			"main"
		];
		getHTMLvars();
		//checkUser();
		gameData = new BambaData(this);
		gameAssets = new BambaAssets(this);
		sound = new BambaSoundManager(this);
		movie = new BambaMovie(this);
		gameLoader = new BambaLoader(this);
		help = new BambaHelp(this);
		msgShown = false;
		finishLoading = false;
		didLogin = false;
		autoLogin = true;
	}

	function hideCharacter():Dynamic {
		if (character != null) {
			if (this.contains(character.mc)) {
				help.showTutorial(11);
				this.removeChild(character.mc);
			}
		}
	}

	function showQuestManager():Dynamic {
		this.addChild(questManager.mc);
		questManager.update();
		questManager.showFog();
		sound.playLoopEffect("TOWER_CRYSTAL_MUSIC");
		help.showTutorial(3);
		centerScreen(questManager.mc);
	}

	function innerCountIOError(param1:Event):Void {
		trace("innerCountIOError:" + param1);
	}

	function showTower():Dynamic {
		var _loc1_:Dynamic = undefined;
		hideMap();
		hideMenuScreen();
		this.addChild(tower.mc);
		tower.updateQuestIcon();
		sound.playMusic("TOWER_MUSIC");
		_loc1_ = help.showTutorial(2);
		if (!_loc1_) {
			_loc1_ = help.showTutorial(9);
			if (!_loc1_) {
				_loc1_ = help.showTutorial(19);
			}
		}
		if (frameMC != null) {
			this.setChildIndex(frameMC, this.numChildren - 1);
		}
	}

	function showNewPlayer():Dynamic {
		hideOpeningScreen();
		newPlayer = new BambaNewPlayerScreen(this);
		this.addChild(newPlayer.mc);
		cornerScreen(newPlayer.mc);
		newPlayer.slideIn();
		sound.playMusic("MAP_MUSIC");
		frameMC.holesMC.gotoAndStop("no_order");
	}

	function exitToOpeningScreen():Dynamic {
		autoLogin = false;
		showOpeningScreen();
		opening.setOnStart();
	}

	function startNewPlayer():Dynamic {
		if (finishLoading) {
			if (didLogin) {
				showCharacterBuild();
			} else {
				showNewPlayer();
			}
		} else {
			Heb.setText(opening.mc.loadingBarMC.msgDT, "ממתין לסיום טעינת נתונים");
		}
	}

	function innerCount(param1:Dynamic):Dynamic {
		var _loc2_:Dynamic = undefined;
		var _loc3_:Dynamic = undefined;
		var _loc4_:Dynamic = undefined;
		ERate.sendEvent(ToolID, param1);
		_loc2_ = "edcount";
		_loc3_ = eventTypeCodes.indexOf(param1);
		_loc4_ = eventTypeNames[_loc3_];
		fscommand(_loc2_, _loc4_);
	}

	public function makeFullScreen(param1:MouseEvent):Void {
		var event:MouseEvent = param1;
		if (stage.displayState == StageDisplayState.NORMAL) {
			try {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			} catch (e:SecurityError) {
				trace("an error has occured. please modify the html file to allow fullscreen mode");
			}
		}
	}

	public function mainMenuClicked(param1:MouseEvent):Void {
		if (!msgShown) {
			sound.playEffect("GENERAL_WARNING");
			MsgBox.showYesNoBox("האם אתה בטוח שאתה רוצה לצאת מהמשחק?", showMainMenu);
		}
	}

	public function showMovie(param1:Dynamic):Dynamic {
		hideAllScreens();
		this.addChild(param1);
		param1.x = 30;
		param1.y = 72;
		addFrame();
		this.setChildIndex(frameMC, this.numChildren - 1);
		sound.stopAll();
	}

	function hideCharacterBuild():Dynamic {
		if (characterBuild != null) {
			if (this.contains(characterBuild.mc)) {
				this.removeChild(characterBuild.mc);
			}
		}
	}

	public function openHelp(param1:MouseEvent):Void {
		if (!msgShown) {
			innerCount(27);
			help.showPage(1);
		}
	}

	function showCharacter():Dynamic {
		this.addChild(character.mc);
		help.showTutorial(10);
		centerScreen(character.mc);
		character.update();
	}

	function finishFilesLoad():Dynamic {
		finishLoading = true;
		opening.hideLoadingBar();
		trace("BambaMain.finishFilesLoad");
		if (didLogin) {
			startGame();
		}
	}

	function innerCountComplete(param1:Event):Void {
		trace("innerCountComplete");
	}

	function hideMap():Dynamic {
		if (gameMap != null) {
			if (this.contains(gameMap.mc)) {
				this.removeChild(gameMap.mc);
			}
		}
	}

	function hideStore():Dynamic {
		if (store != null) {
			if (this.contains(store.mc)) {
				help.showTutorial(14);
				this.removeChild(store.mc);
			}
		}
	}

	function finishEnemyAssetLoad():Dynamic {
		sound.setLoadDungeonMusic([
			gameData.getCatalogDungeonData(currDongeonId).music,
			gameData.getCatalogDungeonData(currDongeonId).fightMusic
		]);
	}

	function showUpgradeCrads():Dynamic {
		this.addChild(upgradeSystem.mc);
		upgradeSystem.update();
		help.showTutorial(22);
		sound.playLoopEffect("TOWER_ALCHEMY_MUSIC");
		centerScreen(upgradeSystem.mc);
	}

	function hideQuestManager():Dynamic {
		var _loc1_:Bool = false;
		if (questManager != null) {
			if (this.contains(questManager.mc)) {
				if (gameData.playerData.currentQuestId != 0) {
					_loc1_ = help.showTutorial(4);
					if (!_loc1_) {
						_loc1_ = help.showTutorial(15);
					}
				}
				this.removeChild(questManager.mc);
			}
		}
	}

	public function showMainMenu():Dynamic {
		innerCount(28);
		hideMovie();
		if (didLogin) {
			hideAllScreens();
			sound.stopAll();
			if (gameMap != null) {
				gameMap.setBabyAtTower();
			}
			showMenuScreen();
		} else {
			showOpeningScreen();
		}
	}

	function showMapContinue():Dynamic {
		clearInterval(soundTimingInterval);
		hideTower();
		this.addChild(gameMap.mc);
		gameMap.setMap();
		centerScreen(gameMap.mc);
		sound.playMusic("MAP_MUSIC");
		msgShown = false;
	}

	function hideTower():Dynamic {
		if (tower != null) {
			if (this.contains(tower.mc)) {
				this.removeChild(tower.mc);
			}
		}
	}

	function checkUser():Dynamic {
		innerCount(1);
		userSharedObject = SharedObject.getLocal("Rlofe54836");
		if (userSharedObject.data.Rlofe54836 != 78512963482) {
			userSharedObject.data.Rlofe54836 = 78512963482;
			userSharedObject.flush();
			innerCount(11);
		}
		innerCount(10);
	}

	function showDungeon():Dynamic {
		var _loc1_:Dynamic = undefined;
		clearInterval(soundTimingInterval);
		MsgBox.closeWaitBox();
		hideAllScreens(false);
		aDungeon.MC.visible = true;
		aDungeon.playDungeonMusic();
		_loc1_ = help.showTutorial(6);
		if (!_loc1_) {
			_loc1_ = help.showTutorial(16);
		}
	}

	public function hideMovie():Dynamic {
		movie.stopMovie();
	}

	function hideMagicBook():Dynamic {
		if (magicBook != null) {
			if (this.contains(magicBook.mc)) {
				this.removeChild(magicBook.mc);
			}
		}
	}

	public function endMovie(param1:Dynamic):Dynamic {
		this.removeChild(param1);
		if (didLogin) {
			showMainMenu();
		} else {
			startNewPlayer();
		}
	}

	function showCharacterBuild():Dynamic {
		if (!isNaN(showCharacterBuildInteval)) {
			clearInterval(showCharacterBuildInteval);
		}
		help.resetTutorial();
		frameMC.holesMC.gotoAndStop("no_order");
		hideNewPlayer();
		hideMenuScreen();
		if (characterBuild == null) {
			characterBuild = new BambaCharacterBuildScreen(this);
		} else {
			characterBuild.reset();
		}
		this.addChild(characterBuild.mc);
		cornerScreen(characterBuild.mc);
		characterBuild.slideIn();
	}

	function showMap():Dynamic {
		if (this.contains(tower.mc)) {
			sound.playEffect("TOWER_TO_MAP");
			msgShown = true;
			soundTimingInterval = setInterval(showMapContinue, 1500);
		} else {
			showMapContinue();
		}
	}

	function finishDungeonAssetLoad():Dynamic {
		var _loc1_:BambaDungeonData = null;
		var _loc2_:BambaEnemy = null;
		var _loc3_:Dynamic = undefined;
		_loc1_ = gameData.getCatalogDungeonData(currDongeonId);
		if (questManager.currQuestDungeonId == currDongeonId) {
			currEnemyId = questManager.currQuestEnemyId;
			currDungeonDifficulty = questManager.currQuestDungeonDifficulty;
		} else if (_loc1_.currEnemyId != 0) {
			currEnemyId = _loc1_.currEnemyId;
			currDungeonDifficulty = _loc1_.currDungeonDifficulty;
		} else {
			currEnemyId = _loc1_.enemiesIds[Math.floor(Math.random() * _loc1_.enemiesIds.length)];
			currDungeonDifficulty = Math.floor(Math.random() * 3) + 1;
		}
		if (isNaN(currEnemyId)) {
			finishEnemyAssetLoad();
		} else {
			_loc2_ = gameData.getCatalogEnemy(currEnemyId, 1);
			_loc3_ = _loc2_.assetFileName;
			gameLoader.loadEnemyAssetStart(_loc3_);
		}
	}

	function finishLoadPlayerData():Dynamic {
		didLogin = true;
		Heb.setText(opening.mc.loadingBarMC.msgDT, "...שם המשתמש נמצא. טוען משחק");
		trace("BambaMain.finishLoadPlayerData");
		if (finishLoading) {
			startGame();
		}
	}

	public function centerScreen(param1:Dynamic):Dynamic {
		if (frameMC != null) {
			this.setChildIndex(frameMC, this.numChildren - 1);
		}
		if (param1.orgWidth == undefined) {
			param1.x = (945 - param1.width) / 2;
			param1.y = (650 - param1.height) / 2;
		} else {
			param1.x = (945 - param1.orgWidth) / 2;
			param1.y = (650 - param1.orgHeight) / 2;
		}
	}

	public function cornerScreen(param1:Dynamic):Dynamic {
		if (frameMC != null) {
			this.setChildIndex(frameMC, this.numChildren - 1);
		}
		param1.x = 29;
		param1.y = 72;
	}

	function addFrame():Dynamic {
		if (frameMC == null) {
			frameMC = BambaAssets.generalFrame();
			ButtonUpdater.setButton(frameMC.helpMC, openHelp);
			ButtonUpdater.setButton(frameMC.mainMenuMC, mainMenuClicked);
			sound.setMusicVolumeBar(frameMC.musicVolumeMC);
			sound.setEffectsVolumeBar(frameMC.effectsVolumeMC);
			this.addChild(frameMC);
		} else {
			frameMC.visible = true;
		}
	}

	function hideFrame():Dynamic {
		if (frameMC != null) {
			frameMC.visible = false;
		}
	}

	function startGame():Dynamic {
		var _loc1_:Dynamic = undefined;
		if (finishLoading && didLogin) {
			if (gameData.playerData.pName == "") {
				startNewPlayer();
			} else {
				addFrame();
				MsgBox.init(this);
				PlayerDataUpdater.init(this);
				if (menu == null) {
					menu = new BambaMenuScreen(this);
				}
				tower = new BambaTower(this);
				questManager = new BambaQuestManager(this);
				magicBook = new BambaMagicBook(this);
				upgradeSystem = new BambaUpgradeSystem(this);
				gameMap = new BambaMap(this);
				character = new BambaCharacterScreen(this);
				store = new BambaStore(this);
				gameData.playerData.setLevelDependingData();
				_loc1_ = "order" + gameData.playerData.orderCode;
				frameMC.holesMC.gotoAndStop(_loc1_);
				hideCharacterBuild();
				hideOpeningScreen();
				showMenuScreen();
			}
		} else if (!finishLoading) {
			Heb.setText(opening.mc.loadingBarMC.msgDT.text, "רגע... עוד לא סיימנו לטעון");
		}
	}

	function hideNewPlayer():Dynamic {
		if (newPlayer != null) {
			if (this.contains(newPlayer.mc)) {
				this.removeChild(newPlayer.mc);
			}
		}
	}

	function hideUpgradeCrads():Dynamic {
		if (upgradeSystem != null) {
			if (this.contains(upgradeSystem.mc)) {
				this.removeChild(upgradeSystem.mc);
			}
		}
	}

	function showMenuScreen():Dynamic {
		hideCharacterBuild();
		hideMenuScreen();
		sound.playMusic("MAP_MUSIC");
		if (menu == null) {
			menu = new BambaMenuScreen(this);
		}
		this.addChild(menu.mc);
		menu.update();
		cornerScreen(menu.mc);
		menu.slideIn();
	}

	public function hideAllScreens(param1:Bool = true):Dynamic {
		if (param1) {
			if (aDungeon != null) {
				aDungeon.exitDungeon();
			}
		}
		hideMap();
		hideTower();
		hideStore();
		hideCharacter();
		hideUpgradeCrads();
		hideMagicBook();
		hideQuestManager();
		hideMenuScreen();
		hideOpeningScreen();
		hideCharacterBuild();
		hideNewPlayer();
	}

	function hideMenuScreen():Dynamic {
		if (menu != null) {
			if (this.contains(menu.mc)) {
				this.removeChild(menu.mc);
			}
		}
	}

	function closeDungeon():Dynamic {
		if (this.contains(dungeonMC)) {
			this.removeChild(dungeonMC);
			gameLoader.savePlayerData();
			showMap();
		}
		try {
			new LocalConnection().connect("foo");
			new LocalConnection().connect("foo");
		} catch (e:Dynamic) {}
	}

	public function getHTMLvars():Void {
		var _loc1_:Dynamic = null;
		_loc1_ = LoaderInfo(this.root.loaderInfo).parameters;
		ToolID = Std.string(_loc1_.ToolID);
		if (ToolID == "undefined") {
			ToolID = "SBCKOS";
		}
	}

	function showMagicBook():Dynamic {
		this.addChild(magicBook.mc);
		magicBook.update();
		help.showTutorial(20);
		sound.playLoopEffect("TOWER_BOOK_MUSIC");
		centerScreen(magicBook.mc);
	}

	function hideOpeningScreen():Dynamic {
		if (opening != null) {
			if (this.contains(opening.mc)) {
				this.removeChild(opening.mc);
			}
		}
	}

	function finishDungeonMusicLoad():Dynamic {
		if (aDungeon != null) {
			aDungeon.clearEvents();
		}
		dungeonMC = BambaAssets.dungeonMain();
		this.addChildAt(dungeonMC, 0);
		if (questManager.currQuestDungeonId == currDongeonId) {
			aDungeon = new BambaDungeon(this, dungeonMC, questManager.currQuestDungeonId, questManager.currQuestDungeonDifficulty,
				questManager.currQuestEnemyId, questManager.currSpecialEnemy, questManager.currMarkBoss, questManager.currMarkAllEnemies,
				questManager.currSpecialTreasure);
		} else {
			aDungeon = new BambaDungeon(this, dungeonMC, currDongeonId, currDungeonDifficulty, currEnemyId, false, false, false, false);
		}
		sound.playEffect("MAP_TO_MAZE");
		aDungeon.MC.visible = false;
		soundTimingInterval = setInterval(showDungeon, 1200);
	}

	public function initGeneral():Dynamic {
		MsgBox.init(this);
		PlayerDataUpdater.init(this);
	}

	function showStore():Dynamic {
		this.addChild(store.mc);
		help.showTutorial(12);
		centerScreen(store.mc);
		store.update();
		sound.playLoopEffect("TOWER_STORE_MUSIC");
	}

	function showOpeningScreen():Dynamic {
		sound.stopAll();
		didLogin = false;
		if (opening == null) {
			opening = new BambaOpeningScreen(this);
		}
		this.addChild(opening.mc);
	}

	function showCharacterBuildAfterNewPlayer():Dynamic {
		newPlayer.slideOut();
		showCharacterBuildInteval = setInterval(showCharacterBuild, 600);
	}

	function startDungeon(param1:Dynamic):Dynamic {
		var _loc2_:Float = NaN;
		var _loc3_:BambaDungeonData = null;
		_loc2_ = 100 + param1;
		currDongeonId = param1;
		_loc3_ = gameData.getCatalogDungeonData(currDongeonId);
		gameLoader.loadDungeonAssetStart(_loc3_.assetFileName);
	}
}
