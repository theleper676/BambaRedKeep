package;

import haxe.Timer;
import openfl.display.*;
import openfl.events.*;
import openfl.external.ExternalInterface;
import openfl.media.SoundTransform;
import openfl.net.URLRequest;
import general.ButtonUpdater;
import general.MsgBox;

class BambaMovie {
	var continueLoadingIntervalTimer: Timer = null;
	var movieMC:Dynamic;
	//var continueLoadingInterval:Dynamic;	
	var skipButton:MovieClip;

	
	var loader:Loader;

	
	var continueTime:Dynamic;

	
	var lastLoadingCounter:Dynamic;

	
	var loadingCounter:Dynamic;

	
	var game:BambaMain;

	
	var assetFileName:Dynamic;

	public function new(mainGame:BambaMain) {
		game = mainGame;
	}

	
	function checkEnd(param1:Event):Void {
		if (skipButton != null) {
			movieMC.setChildIndex(skipButton, movieMC.numChildren - 1);
		}
		if (movieMC.currentFrame == movieMC.totalFrames) {
			stopMovie();
			game.endMovie(movieMC);
		} else {
			movieMC.soundTransform = game.sound.musicTransform;
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

	
	function loadAndShowComplete(param1:Event):Void {
		finishContinueLoading();
		MsgBox.closeWaitBox();
		skipButton = BambaAssets.skipButton();
		skipButton.x = 380;
		skipButton.y = 480;
		movieMC.addChild(skipButton);
		ButtonUpdater.setButton(skipButton, skipButtonClicked);
		game.showMovie(movieMC);
		movieMC.play();
	}

	public function stopMovie():Void {
		var _loc1_:SoundTransform = null;
		if (movieMC != null) {
			movieMC.gotoAndStop(movieMC.totalFrames);
			movieMC.removeEventListener(Event.ENTER_FRAME, checkEnd);
			_loc1_ = new SoundTransform();
			_loc1_.volume = 0;
			movieMC.soundTransform = _loc1_;
		}
	}

	
	function setContinueLoading():Void {
		lastLoadingCounter = -1;
		loadingCounter = 0;
		continueTime = 3000;
		continueLoadingIntervalTimer = new Timer(continueTime);
		continueLoadingIntervalTimer.run = chackContinueLoadingNeeded;
		// continueLoadingInterval = setInterval(chackContinueLoadingNeeded, continueTime);
	}

	
	function continueLoading():Void {
		try {
			ExternalInterface.call("console.log", {
				"fb_loadingCounter": loadingCounter,
				"fb_continueTime": continueTime
			});
		} catch (error:Dynamic) {}
		continueLoadingIntervalTimer.stop();
		// clearInterval(continueLoadingInterval);
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadAndShowComplete);
		loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadAndShowProgress);
		loader.contentLoaderInfo.removeEventListener(Event.INIT, loadAndShowInit);
		continueTime += 500;
		continueLoadingIntervalTimer = new Timer(continueTime);
		continueLoadingIntervalTimer.run = chackContinueLoadingNeeded;
		// continueLoadingInterval = setInterval(chackContinueLoadingNeeded, continueTime);
		loadAndShow();
	}

	
	function skipButtonClicked(param1:MouseEvent):Void {
		movieMC.gotoAndPlay(movieMC.totalFrames);
	}

	
	function loadAndShowInit(param1:Event):Void {
		movieMC = loader.content;
		movieMC.addEventListener(Event.ENTER_FRAME, checkEnd);
		movieMC.soundTransform = game.sound.musicTransform;
		movieMC.stop();
	}

	
	public function setMovieAsset(param1:Dynamic):Void {
		assetFileName = param1;
	}

	
	function finishContinueLoading():Void {
		continueLoadingIntervalTimer.stop();
		// clearInterval(continueLoadingInterval);
	}

	
	function loadAndShow():Void {
		var _loc1_:URLRequest = null;
		setContinueLoading();
		loader = new Loader();
		_loc1_ = new URLRequest(assetFileName);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadAndShowComplete);
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadAndShowProgress);
		loader.contentLoaderInfo.addEventListener(Event.INIT, loadAndShowInit);
		loader.load(_loc1_);
		MsgBox.showWaitBox(game.gameData.dictionary.LOADING_MOVIE_MSG);
	}

	
	function loadAndShowProgress(param1:ProgressEvent):Void {
		var _loc2_:Float = null;
		_loc2_ = Math.floor(param1.bytesLoaded / param1.bytesTotal * 100);
		++loadingCounter;
		MsgBox.updateWaitBox(_loc2_);
	}
}
