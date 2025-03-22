package;

import haxe.Timer;
import haxe.DynamicAccess;
import openfl.display.*;
import openfl.errors.*;
import openfl.events.*;
import openfl.external.ExternalInterface;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLVariables;
import openfl.utils.*;
import general.Heb;
import general.MsgBox;

class BambaLoader extends EventDispatcher {
	private var generalDataFileName:String;

	private var openingAssets:Array<Dynamic>;

	var continueTime:Float;

	var xmlFilesIndex:Int;

	public var game:BambaMain;

	public var loadingCounter:Float;

	private var playerDataSource:String;

	private var updatePlayerDataSource:String;

	var assetsIndex:Int;

	private var sendPassSource:String;

	var msgCounter:Int;

	private var assetsPath:String;

	private var forgetPassSource:String;

	var lastLoadingCounter:Float;

	var currBytes:Float;

	private var dungeonAssetsNames:String;

	var loadingMsgs:Array<Dynamic>;

	var fileSizes:Array<Dynamic>;

	var xmlFunctionNames:Array<Dynamic>;

	var continueLoadingIntervalTimer: Timer = null;
	//var continueLoadingInterval:Float;

	var currFileName:String;

	var assets:Array<Dynamic>;

	var totalBytes:Float;

	public var soundsPath:String;

	private var soundsFileName:String;

	var xmlFiles:Array<Dynamic>;

	private var paramFile:String = "params.xml";

	var tempMail:String;

	public var currFunctionName:String;

	private var xmlPath:String;

	private var dictionaryFileName:String;

	var currAsset:Array<Dynamic>;

	var currLoadXMLFunctionName:String;

	private var enemyAssetsNames:String;

	private var newPlayerDataSource:String;

	var currLoader:Dynamic;

	public function new(mainGame:BambaMain) {
		paramFile = "params.xml";
		super();
		game = mainGame;
		xmlFilesIndex = 0;
		assetsIndex = 0;
		msgCounter = 0;
		loadParams();
	}

	function loadAssets():Void {
		var tempCurrAssetString:Null<Dynamic> = null;
		var loader:Loader = null;
		var request:URLRequest = null;
		currFunctionName = "loadAssets";
		++loadingCounter;
		if (assetsIndex < assets.length) {
			tempCurrAssetString = assets[assetsIndex];
			currAsset = tempCurrAssetString.split(",");
			try {
				ExternalInterface.call("console.log", {
					"fb_msgCounter": msgCounter,
					"fb_currAsset": currAsset[0]
				});
			} catch (error:Dynamic) {}
			Heb.setText(game.opening.mc.loadingBarMC.loaderDT, loadingMsgs[msgCounter]);
			loader = new Loader();
			request = new URLRequest(assetsPath + "/" + currAsset[0]);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAssetsComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadAssetsProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, showIOError);
			currLoader = loader;
			try {
				loader.load(request);
			} catch (error:Dynamic) {
				trace("loading asset error occured:" + error.message);
				//game.errorDT.text = error.errorID + ":" + error.name + ":" + error.message;
			}
		} else {
			loadSoundsData();
		}
	}

	function loadPlayerDataComplete(param1:Event):Void {
		var _loc2_:Null<Dynamic> = null;
		_loc2_ = Xml.parse(param1.target.data);
		if (_loc2_.errorCode == 0) {
			game.innerCount(14);
			game.gameData.loadPlayerData(_loc2_);
			game.finishLoadPlayerData();
		} else {
			game.opening.showErrorMsg(_loc2_.errorCode);
		}
	}

	function loadParams():Void {
		var request:URLRequest = null;
		var loader:URLLoader = null;
		currFunctionName = "loadParams";
		request = new URLRequest(paramFile);
		loader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, loadParamsComplete, false, 0, true);
		try {
			loader.load(request);
		} catch (error:ArgumentError) {
			trace("An ArgumentError has occurred.");
		} catch (error:SecurityError) {
			trace("A SecurityError has occurred.");
		}
	}

	function chackContinueLoadingNeeded():Void {
		trace("loadingCounter:" + loadingCounter);
		if (lastLoadingCounter == loadingCounter) {
			continueLoading();
		} else {
			lastLoadingCounter = loadingCounter;
		}
	}

	function loadOpeningAssetsComplete(param1:Event):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		_loc2_ = 1;
		while (_loc2_ < openingAssets.length) {
			_loc3_ = openingAssets[_loc2_];
			game.gameAssets.defineAsset(_loc3_, param1.target.applicationDomain.getDefinition(_loc3_));
			_loc2_++;
		}
		game.showOpeningScreen();
		loadDictionary();
	}

	function loadDictionary():Void {
		var _loc1_:URLRequest = null;
		var _loc2_:URLLoader = null;
		currFunctionName = "loadDictionary";
		Heb.setText(game.opening.mc.loadingBarMC.loaderDT, "טוען מילון נתונים");
		_loc1_ = new URLRequest(xmlPath + "/" + dictionaryFileName);
		_loc2_ = new URLLoader();
		_loc2_.addEventListener(Event.COMPLETE, loadDictionaryComplete);
		currLoader = _loc2_;
		_loc2_.load(_loc1_);
	}

	public function sendNewPlayerData(param1:Dynamic, param2:Dynamic, param3:Dynamic, param4:Dynamic):Void {
		var _loc5_:URLRequest = null;
		var _loc6_:URLLoader = null;
		var _loc7_:URLVariables = null;
		game.gameData.playerData.setUserPass(param1, param2);
		_loc5_ = new URLRequest(newPlayerDataSource);
		if (_loc5_.url != "xmls/newPlayerAnswer.xml") {
			(_loc7_ = new URLVariables()).PlayerName = param1;
			_loc7_.Password = param2;
			_loc7_.Mail = param3;
			_loc7_.Age = param4;
			_loc7_.dummy = Std.string(Math.random());
			//_loc7_.dummy = Std.string(getTimer()) + Std.string(Math.random());
			_loc5_.data = _loc7_;
		}
		_loc6_ = new URLLoader();
		_loc6_.addEventListener(Event.COMPLETE, sendNewPlayerDataComplete, false, 0, true);
		_loc6_.load(_loc5_);
		MsgBox.showWaitBox("יוצר משתמש חדש");
	}

	function loadGeneralDataComplete(param1:Event):Void {
		var _loc2_:Xml = null;
		currBytes += Std.parseFloat(fileSizes[msgCounter]);
		setLoaderGraphics(currBytes / totalBytes);
		++msgCounter;
		++loadingCounter;
		_loc2_ = Xml.parse(param1.target.data);
		game.gameData.loadGeneralData(_loc2_);
		loadXMLFile();
	}

	function loadAssetsProgress(param1:ProgressEvent):Void {
		var _loc2_:Float = Math.NaN;
		var _loc3_:Float = Math.NaN;
		_loc2_ = param1.bytesLoaded / param1.bytesTotal;
		_loc3_ = Math.floor(_loc2_ * 100);
		Heb.setText(game.opening.mc.loadingBarMC.loaderDT, loadingMsgs[msgCounter] + " %" + _loc3_);
		setLoaderGraphics((currBytes + _loc2_ * Std.parseFloat(fileSizes[msgCounter])) / totalBytes);
		++loadingCounter;
	}

	public function loadDungeonAsset():Void {
		var _loc1_:Loader = null;
		var _loc2_:URLRequest = null;
		currFunctionName = "loadDungeonAsset";
		++loadingCounter;
		_loc1_ = new Loader();
		_loc2_ = new URLRequest(assetsPath + "/" + currFileName);
		_loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, loadDungeonAssetsComplete, false, 0, true);
		_loc1_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadDungeonAssetsProgress, false, 0, true);
		_loc1_.load(_loc2_);
		currLoader = _loc1_;
		MsgBox.showWaitBox(game.gameData.dictionary.LOADING_DUNGEON_MSG);
	}

	public function loadEnemyAssetStart(param1:Dynamic):Void {
		currFileName = param1;
		loadEnemyAsset();
	}

	function loadAssetsComplete(param1:Event):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		++loadingCounter;
		currBytes += Std.parseFloat(fileSizes[msgCounter]);
		setLoaderGraphics(currBytes / totalBytes);
		++msgCounter;
		_loc2_ = 1;
		while (_loc2_ < currAsset.length) {
			_loc3_ = currAsset[_loc2_];
			game.gameAssets.defineAsset(_loc3_, param1.target.applicationDomain.getDefinition(_loc3_));
			_loc2_++;
		}
		++assetsIndex;
		loadAssets();
	}

	function loadParamsComplete(param1:Event):Void {
		var _loc2_:Null<Dynamic> = null;
		var _loc3_:Null<Dynamic> = null;
		var _loc4_:Null<Dynamic> = null;
		var _loc5_:Null<Dynamic> = null;
		var _loc6_:Null<Dynamic> = null;
		var _loc7_:Null<Dynamic> = null;
		var _loc8_:Null<Dynamic> = null;
		var _loc9_:Null<Dynamic> = null;
		var _loc10_:Null<Dynamic> = null;
		var _loc11_:Null<Dynamic> = null;
		var _loc12_:Null<Dynamic> = null;
		var _loc13_:Null<Dynamic> = null;
		var _loc14_:Null<Dynamic> = null;
		var _loc15_:Null<Dynamic> = null;
		var _loc16_:Null<Dynamic> = null;
		var _loc17_:Null<Dynamic> = null;
		var _loc18_:Null<Dynamic> = null;
		var _loc19_:Null<Dynamic> = null;
		var _loc20_:Null<Dynamic> = null;
		var _loc21_:Null<Dynamic> = null;
		var _loc22_:Null<Dynamic> = null;
		var _loc23_:Null<Dynamic> = null;
		var _loc24_:Null<Dynamic> = null;
		var _loc25_:Null<Dynamic> = null;
		var _loc26_:Null<Dynamic> = null;
		trace("BambaLoader.loadParamsComplete");
		_loc2_ = Xml.parse(param1.target.data);
		dictionaryFileName = _loc2_.dictionaryFileName;
		generalDataFileName = _loc2_.generalDataFileName;
		soundsFileName = _loc2_.soundsFileName;
		playerDataSource = _loc2_.playerDataSource;
		newPlayerDataSource = _loc2_.newPlayerDataSource;
		updatePlayerDataSource = _loc2_.updatePlayerDataSource;
		forgetPassSource = _loc2_.forgetPassSource;
		sendPassSource = _loc2_.sendPassSource;
		openingAssets = _loc2_.openingAssets.split(",");
		xmlPath = _loc2_.xmlPath;
		assetsPath = _loc2_.assetsPath;
		soundsPath = _loc2_.soundsPath;
		_loc3_ = _loc2_.playerLevelsFileName;
		_loc4_ = _loc2_.magicBookFileName;
		_loc5_ = _loc2_.cardsFileName;
		_loc6_ = _loc2_.enemiesFileName;
		_loc7_ = _loc2_.enemiesLevelsFileName;
		_loc8_ = _loc2_.itemsBaseFileName;
		_loc9_ = _loc2_.itemsFileName;
		_loc10_ = _loc2_.storeItemsFileName;
		_loc11_ = _loc2_.prizesFileName;
		_loc12_ = _loc2_.surprisesFileName;
		_loc13_ = _loc2_.dungeonsDataFileName;
		_loc14_ = _loc2_.questsFileName;
		_loc15_ = _loc2_.helpFileName;
		xmlFiles = [
			_loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_
		];
		xmlFunctionNames = [
			"buildPlayerLevelsCatalog",
			"buildMagicCatalog",
			"buildCardsCatalog",
			"buildEnemiesCatalog",
			"buildEnemiesLevelsCatalog",
			"buildItemsBaseCatalog",
			"buildItemsCatalog",
			"buildStoreItemsCatalog",
			"buildPrizesCatalog",
			"buildSurprisesCatalog",
			"buildDungeonsDataCatalog",
			"buildQuestsCatalog",
			"buildHelpCatalog"
		];
		_loc16_ = _loc2_.generalAssets;
		_loc17_ = _loc2_.newPlayerAssets;
		_loc18_ = _loc2_.menuAssets;
		_loc19_ = _loc2_.cardsAssets;
		_loc20_ = _loc2_.itemsAssets;
		_loc21_ = _loc2_.babyAssets;
		_loc22_ = _loc2_.fightGraphicsAssets;
		_loc23_ = _loc2_.dungeonIconsAssets;
		_loc24_ = _loc2_.towerAssets;
		_loc25_ = _loc2_.mapAssets;
		_loc26_ = _loc2_.helpAssets;
		assets = [
			_loc16_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_, _loc23_, _loc24_, _loc25_, _loc26_
		];
		dungeonAssetsNames = _loc2_.dungeonAssetsNames;
		enemyAssetsNames = _loc2_.enemyAssetsNames;
		game.movie.setMovieAsset(assetsPath + "/" + _loc2_.movieAsset);
		loadOpeningAssets();
	}

	public function loadDungeonAssetStart(param1:Dynamic):Void {
		currFileName = param1;
		setContinueLoading();
		loadDungeonAsset();
	}

	function loadXMLFile():Void {
		var request:URLRequest = null;
		var loader:URLLoader = null;
		currFunctionName = "loadXMLFile";
		++loadingCounter;
		if (xmlFilesIndex < xmlFiles.length) {
			currFileName = xmlFiles[xmlFilesIndex];
			Heb.setText(game.opening.mc.loadingBarMC.loaderDT, loadingMsgs[msgCounter]);
			try {
				ExternalInterface.call("console.log", {
					"fb_msgCounter": msgCounter,
					"fb_currFileName": currFileName
				});
			} catch (error:Dynamic) {}
			currLoadXMLFunctionName = xmlFunctionNames[xmlFilesIndex];
			request = new URLRequest(xmlPath + "/" + currFileName);
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadXMLComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, showIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, showSecurityError);
			currLoader = loader;
			try {
				loader.load(request);
			} catch (error:Dynamic) {
				trace("XML load error: " + error.message);
				//game.errorDT.text = error.errorID + ":" + error.name + ":" + error.message;
			}
		} else {
			loadAssets();
		}
	}

	function loadDictionaryComplete(param1:Event):Void {
		var dataXML:Xml = null;
		var i:Dynamic = null;
		var event:Event = param1;
		try {
			ExternalInterface.call("console.log", {"fb_loadDictionaryComplete": loadingCounter});
		} catch (error:Dynamic) {}
		dataXML = Xml.parse(event.target.data);
		game.gameData.loadDictionary(dataXML);
		loadingMsgs = game.gameData.dictionary.LOADING_MSGS.split(",");
		fileSizes = game.gameData.dictionary.LOADING_FILE_SIZES.split(",");
		totalBytes = 0;
		i = 0;
		while (i < fileSizes.length) {
			totalBytes += Std.parseFloat(fileSizes[i]);
			i++;
		}
		currBytes = 0;
		setContinueLoading();
		loadGeneralData();
	}

	function loadFinished():Void {
		finishContinueLoading();
		Heb.setText(game.opening.mc.loadingBarMC.loaderDT, game.gameData.dictionary.LOADING_END_MSG);
		game.opening.mc.loadingBarMC.flareMC.stop();
		game.opening.mc.loadingBarMC.flareMC.visible = false;
		currFunctionName = "loadFinished";
		game.finishFilesLoad();
	}

	function finishContinueLoading():Void {
		continueLoadingIntervalTimer.stop();
		// clearInterval(continueLoadingInterval);
	}

	public function savePlayerData():Dynamic {
		var _loc1_:URLRequest = null;
		var _loc2_:URLVariables = null;
		var _loc3_:URLLoader = null;
		_loc1_ = new URLRequest(updatePlayerDataSource);
		_loc2_ = new URLVariables();
		_loc2_.PN = game.gameData.playerData.user;
		_loc2_.PW = game.gameData.playerData.pass;
		_loc2_.NN = game.gameData.playerData.pName;
		_loc2_.PL = game.gameData.playerData.level;
		_loc2_.OC = game.gameData.playerData.orderCode;
		_loc2_.MA = game.gameData.playerData.magic.toString();
		_loc2_.CA = game.gameData.playerData.cards.toString();
		_loc2_.EP = game.gameData.playerData.exPoints;
		_loc2_.IT = game.gameData.playerData.items.toString();
		_loc2_.MO = game.gameData.playerData.money;
		_loc2_.I1 = game.gameData.playerData.ingredient1;
		_loc2_.I2 = game.gameData.playerData.ingredient2;
		_loc2_.I3 = game.gameData.playerData.ingredient3;
		_loc2_.I4 = game.gameData.playerData.ingredient4;
		_loc2_.IIU = game.gameData.playerData.itemsInUse.toString();
		_loc2_.CQI = game.gameData.playerData.currentQuestId;
		_loc2_.PQI = game.gameData.playerData.pastQuestsIds.toString();
		_loc2_.PDI = game.gameData.playerData.pastDungeonsIds.toString();
		_loc2_.dummy = Std.string(getTimer()) + Std.string(Math.random());
		if (_loc1_.url != "local") {
			_loc1_.data = _loc2_;
			_loc3_ = new URLLoader();
			_loc3_.addEventListener(Event.COMPLETE, savePlayerDataComplete, false, 0, true);
			_loc3_.load(_loc1_);
		}
	}

	function loadSoundsData():Void {
		var _loc1_:URLRequest = null;
		var _loc2_:URLLoader = null;
		currFunctionName = "loadSoundsData";
		++loadingCounter;
		Heb.setText(game.opening.mc.loadingBarMC.loaderDT, loadingMsgs[msgCounter]);
		_loc1_ = new URLRequest(xmlPath + "/" + soundsFileName);
		_loc2_ = new URLLoader();
		_loc2_.addEventListener(Event.COMPLETE, loadSoundsDataComplete);
		currLoader = _loc2_;
		_loc2_.load(_loc1_);
	}

	function continueLoading():Void {
		var currCompleteFunctionName:Dynamic = null;
		try {
			ExternalInterface.call("console.log", {
				"fb_loadingCounter": loadingCounter,
				"fb_functionName": currFunctionName
			});
		} catch (error:Dynamic) {}
		trace("BambaLoader.continueLoading:" + currFunctionName);
		continueLoadingIntervalTimer.stop();
		//clearInterval(continueLoadingInterval);
		currCompleteFunctionName = currFunctionName + "Complete";
		currLoader.removeEventListener(Event.COMPLETE, this[currCompleteFunctionName]());
		continueTime += 500;
		continueLoadingIntervalTimer = new Timer(continueTime);
		continueLoadingIntervalTimer.run = chackContinueLoadingNeeded;
		// continueLoadingInterval = setInterval(chackContinueLoadingNeeded, continueTime);
		this[currFunctionName]();
	}

	function sendNewPlayerDataComplete(param1:Event):Void {
		var _loc2_:Xml = null;
		_loc2_ = Xml.parse(param1.target.data);
		var errorCode:String = _loc2_.get("errorCode");
		trace("2 sendNewPlayerDataComplete:" + _loc2_);
		MsgBox.closeWaitBox();
		if (errorCode == "0") {
			trace("sendNewPlayerDataComplete:A OK");
			game.showCharacterBuildAfterNewPlayer();
		} else {
			switch (Std.parseInt(errorCode)) {
				case 1:
					MsgBox.show(game.gameData.dictionary.NEW_PLAYER_NAME_EXISTING);
				case 2:
					MsgBox.show(game.gameData.dictionary.NEW_PLAYER_ILLEGAL_MAIL);
				case 3:
					MsgBox.show(game.gameData.dictionary.NEW_PLAYER_MAIL_EXISTING);
			}
		}
	}

	public function forgetPass(param1:Dynamic):Void {
		var _loc2_:URLRequest = null;
		var _loc3_:URLVariables = null;
		var _loc4_:URLLoader = null;
		tempMail = param1;
		_loc2_ = new URLRequest(forgetPassSource);
		_loc3_ = new URLVariables();
		_loc3_.Mail = param1;
		_loc3_.dummy = Std.string(Math.random());
		if (_loc2_.url != "local") {
			_loc2_.data = _loc3_;
			_loc4_ = new URLLoader();
			_loc4_.addEventListener(Event.COMPLETE, forgetPassComplete, false, 0, true);
			_loc4_.load(_loc2_);
		} else {
			game.opening.showPassSendMsg();
		}
	}

	function loadXMLComplete(param1:Event):Void {
		var _loc2_:Xml = null;
		++loadingCounter;
		currBytes += Std.parseFloat(fileSizes[msgCounter]);
		setLoaderGraphics(currBytes / totalBytes);
		++msgCounter;
		_loc2_ = Xml.parse(param1.target.data);
		game.gameData[currLoadXMLFunctionName](_loc2_.children());
		++xmlFilesIndex;
		loadXMLFile();
	}

	function loadOpeningAssets():Void {
		var _loc1_:Loader = null;
		var _loc2_:URLRequest = null;
		currFunctionName = "loadOpeningAssets";
		_loc1_ = new Loader();
		_loc2_ = new URLRequest(assetsPath + "/" + openingAssets[0]);
		_loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, loadOpeningAssetsComplete, false, 0, true);
		currLoader = _loc1_;
		_loc1_.load(_loc2_);
	}

	function loadEnemyAssetsComplete(param1:Event):Void {
		var _loc2_:Array<Dynamic> = null;
		var _loc3_:Dynamic = undefined;
		var _loc4_:Dynamic = undefined;
		++loadingCounter;
		_loc2_ = enemyAssetsNames.split(",");
		_loc3_ = 0;
		while (_loc3_ < _loc2_.length) {
			_loc4_ = _loc2_[_loc3_];
			game.gameAssets.defineAsset(_loc4_, param1.target.applicationDomain.getDefinition(_loc4_));
			_loc3_++;
		}
		finishContinueLoading();
		game.finishEnemyAssetLoad();
	}

	function setLoaderGraphics(param1:Float):Dynamic {
		game.opening.mc.loadingBarMC.flareMC.x = 800 - 800 * param1;
		game.opening.mc.loadingBarMC.maskMC.width = 800 * param1;
		game.opening.mc.loadingBarMC.maskMC.x = 800 - 800 * param1;
	}

	function showSecurityError(param1:SecurityErrorEvent):Void {
		game.errorDT.text = "SecurityErrorEvent";
	}

	public function loadPlayerData(param1:Dynamic, param2:Dynamic):Dynamic {
		var _loc3_:URLRequest = null;
		var _loc4_:URLLoader = null;
		var _loc5_:URLVariables = null;
		game.gameData.playerData.setUserPass(param1, param2);
		_loc3_ = new URLRequest(playerDataSource);
		if (_loc3_.url != "xmls/playerData.xml") {
			(_loc5_ = new URLVariables()).PlayerName = param1;
			_loc5_.Password = param2;
			_loc5_.dummy = Std.string(getTimer()) + Std.string(Math.random());
			_loc3_.data = _loc5_;
		}
		_loc4_ = new URLLoader();
		_loc4_.addEventListener(Event.COMPLETE, loadPlayerDataComplete, false, 0, true);
		_loc4_.load(_loc3_);
	}

	public function loadEnemyAsset():Void {
		var _loc1_:Loader = null;
		var _loc2_:URLRequest = null;
		currFunctionName = "loadEnemyAsset";
		++loadingCounter;
		_loc1_ = new Loader();
		_loc2_ = new URLRequest(assetsPath + "/" + currFileName);
		_loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE, loadEnemyAssetsComplete, false, 0, true);
		MsgBox.updateWaitBoxTxt(game.gameData.dictionary.LOADING_ENEMY_MSG);
		MsgBox.updateWaitBox(0);
		_loc1_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadEnemyAssetsProgress, false, 0, true);
		_loc1_.load(_loc2_);
		currLoader = _loc1_;
	}

	function setContinueLoading():Void {
		loadingCounter = 0;
		continueTime = 2000;
		continueLoadingIntervalTimer = new Timer(continueTime);
		continueLoadingIntervalTimer.run = chackContinueLoadingNeeded;
		// continueLoadingInterval = setInterval(chackContinueLoadingNeeded, continueTime);
	}

	function loadEnemyAssetsProgress(param1:ProgressEvent):Void {
		var _loc2_:Float = NaN;
		_loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
		++loadingCounter;
		MsgBox.updateWaitBox(_loc2_);
	}

	function savePlayerDataComplete(param1:Event):Void {
		var _loc2_:XML = null;
		_loc2_ = XML(param1.target.data);
		trace("3 savePlayerDataComplete:" + _loc2_);
		if (_loc2_.errorCode == 0) {
			trace("savePlayerDataComplete:A OK");
		} else {
			MsgBox.show(_loc2_.msg);
		}
	}

	function showIOError(param1:IOErrorEvent):Void {
		game.errorDT.text = "IOErrorEvent";
	}

	function loadGeneralData():Dynamic {
		var _loc1_:URLRequest = null;
		var _loc2_:URLLoader = null;
		currFunctionName = "loadGeneralData";
		++loadingCounter;
		Heb.setText(game.opening.mc.loadingBarMC.loaderDT, loadingMsgs[msgCounter]);
		_loc1_ = new URLRequest(xmlPath + "/" + generalDataFileName);
		_loc2_ = new URLLoader();
		_loc2_.addEventListener(Event.COMPLETE, loadGeneralDataComplete, false, 0, true);
		currLoader = _loc2_;
		_loc2_.load(_loc1_);
	}

	function loadSoundsDataComplete(param1:Event):Void {
		var _loc2_:XML = null;
		++loadingCounter;
		++msgCounter;
		_loc2_ = XML(param1.target.data);
		game.sound.loadSoundsStart(_loc2_);
		loadFinished();
	}

	function loadDungeonAssetsComplete(param1:Event):Void {
		var _loc2_:Array<Dynamic> = null;
		var _loc3_:Dynamic = undefined;
		var _loc4_:Dynamic = undefined;
		++loadingCounter;
		_loc2_ = dungeonAssetsNames.split(",");
		_loc3_ = 0;
		while (_loc3_ < _loc2_.length) {
			_loc4_ = _loc2_[_loc3_];
			game.gameAssets.defineAsset(_loc4_, param1.target.applicationDomain.getDefinition(_loc4_));
			_loc3_++;
		}
		game.finishDungeonAssetLoad();
	}

	function forgetPassComplete(param1:Event):Void {
		var _loc2_:Xml = null;
		var _loc3_:URLRequest = null;
		var _loc4_:URLVariables = null;
		var _loc5_:URLLoader = null;
		_loc2_ = Xml(param1.target.data);
		trace("forgetPassComplete:" + _loc2_);
		trace("forgetPassComplete:" + sendPassSource + ":" + tempMail);
		if (_loc2_.errorCode == 0) {
			_loc3_ = new URLRequest(sendPassSource);
			(_loc4_ = new URLVariables()).email = tempMail;
			_loc4_.user = _loc2_.playerName;
			_loc4_.pass = _loc2_.password;
			_loc4_.dummy = Std.string(getTimer()) + Std.string(Math.random());
			_loc3_.data = _loc4_;
			_loc5_ = new URLLoader();
			_loc5_.load(_loc3_);
			game.opening.showPassSendMsg();
		} else {
			game.opening.showForgetPassErrorMsg(_loc2_.errorCode);
		}
	}

	function loadDungeonAssetsProgress(param1:ProgressEvent):Void {
		var _loc2_:Float = NaN;
		_loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
		++loadingCounter;
		MsgBox.updateWaitBox(_loc2_);
	}
}
