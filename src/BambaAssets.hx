package;

import openfl.display.DisplayObject;
import general.MsgBox;
import openfl.display.MovieClip;
import openfl.display.Sprite;
class BambaAssets extends DisplayObject {
	public static var cardBase:Dynamic;

	public static var help02:Dynamic;

	public static var mapIcon:Any;

	public static var cardsUpgradeScreen:Any;

	public static var help06:Dynamic;

	public static var help01:Dynamic;

	public static var help04:Dynamic;

	public static var help07:Dynamic;

	public static var kingdomMap:Any;

	public static var help03:Dynamic;

	public static var enemyBoss:Any;

	public static var waitBox:MsgBox;

	public static var fightBack:Any;

	public static var help08:Dynamic;

	public static var itemFrame:MovieClip;

	public static var magicBase:Dynamic;

	public static var help10:Dynamic;

	public static var stickMC:MovieClip;

	public static var help05:Dynamic;

	public static var help09:Dynamic;

	public static var hitMatrix:Any;

	public static var magicBookScreen:Dynamic;

	public static var hitAnim:Dynamic;

	public static var dungeonMap:Dynamic;

	public static var winBox:MsgBox;

	public static var dungeonIcon:Dynamic;

	public static var hitPoints:Dynamic;

	public static var itemPopup:Dynamic;

	public static var daiperMC:MovieClip;

	public static var generalFrame:Dynamic;

	public static var newPlayerScreen:Dynamic;

	public static var hatMC:MovieClip;

	public static var babyAttacks:Dynamic;

	public static var eyesMC:Dynamic;

	public static var questIcon:Dynamic;

	public static var cardPopup:Dynamic;

	public static var shoesMC:Dynamic;

	public static var enemyAttacks:Dynamic;

	public static var questBox:Dynamic;

	public static var msgBox:MsgBox;

	public static var skipButton:Dynamic;

	public static var dungeonMain:Dynamic;

	public static var characterBuildScreen:Dynamic;

	public static var fightScreen:Dynamic;

	public static var yesNoBox:Dynamic;

	public static var levelBox:Dynamic;

	public static var capeMC:MovieClip;

	public static var prizeIcon:Dynamic;

	public static var storeScreen:Dynamic;

	public static var babyMain:Dynamic;

	public static var menuScreen:Dynamic;

	public static var questManagerScreen:Dynamic;

	public static var towerScreen:Dynamic;

	public static var fighterIcon:Dynamic;

	public static var beltMC:MovieClip;

	public static var openingScreen:Dynamic;

	public static var possibleMove:Dynamic;

	public static var enemyReg:Dynamic;

	public static var enemyTip:Dynamic;

	public static var characterScreen:Dynamic;

	public static var hairMC:MovieClip;

	public static var emptyCard:Dynamic;

	public var game:BambaMain;

	public function new(mainGame:BambaMain) {
		super();
		game = mainGame;
	}

	function define_characterScreen(param1:Dynamic):Void {
		characterScreen = param1;
		/* if(Std.is(param1, Dynamic))
			characterScreen = param1;
		characterScreen = cast(param1, BambaCharacterScreen); */
	}

	function define_hairMC(param1:Dynamic):Void {
		hairMC = param1;
		//hairMC = cast(param1, MovieClip);
	}

	function define_cardBase(param1:Dynamic):Void  {
		cardBase = param1;
		//cardBase = cast(param1, BambaCard);
	}

	function define_help01(param1:Dynamic):Void  {
		help01 = param1;
		//help01 = cast(param1, Dynamic);
	}

	function define_help03(param1:Dynamic):Void  {
		help03 = param1;
		//help03 = cast(param1, Dynamic);
	}

	function define_cardsUpgradeScreen(param1:Dynamic):Void  {
		cardsUpgradeScreen = param1;
		//cardsUpgradeScreen = cast(param1, Dynamic);
	}

	function define_help05(param1:Dynamic):Void  {
		help05 = param1;
		//help05 = cast(param1, BambaHelp);
	}

	function define_help06(param1:Dynamic):Void  {
		help06 = param1;
		//help06 = cast(param1, BambaHelp);
	}

	function define_help07(param1:Dynamic):Void  {
		help07 = param1;
		//help07 = cast(param1, BambaHelp);
	}

	function define_questBox(param1:Dynamic):Void  {
		questBox = param1;
		// questBox = cast(param1, BambaQuest);
	}

	function define_msgBox(param1:Dynamic):Void  {
		msgBox = param1;
		msgBox = cast(param1, MsgBox);
	}

	function define_help04(param1:Dynamic):Void  {
		help04 = param1;
		//help04 = cast(param1, BambaHelp);
	}

	function define_enemyBoss(param1:Dynamic):Void  {
		enemyBoss = param1;
		//enemyBoss = cast(param1, Dynamic);
	}

	function define_waitBox(param1:Dynamic):Void  {
		waitBox = param1;
		//waitBox = cast(param1, Dynamic);
	}

	function define_mapIcon(param1:Dynamic):Void  {
		mapIcon = param1;
		//mapIcon = cast(param1, Dynamic);
	}

	function define_help08(param1:Dynamic):Void  {
		help08 = param1;
		//help08 = cast(param1, BambaHelp);
	}

	function define_skipButton(param1:Dynamic):Void  {
		skipButton = param1;
		//skipButton = cast(param1, Dynamic);
	}

	function define_itemFrame(param1:Dynamic):Void  {
		itemFrame = param1;
		// itemFrame = cast(param1, Dynamic);
	}

	function define_fightScreen(param1:Dynamic):Void  {
		fightScreen = param1;
		//fightScreen = cast(param1, Dynamic);
	}

	function define_magicBase(param1:Dynamic):Void  {
		magicBase = param1;
		//magicBase = cast(param1, BambaItem);
	}

	function define_characterBuildScreen(param1:Dynamic):Void {
		characterBuildScreen = param1;
		//characterBuildScreen = cast(param1, Dynamic);
	}

	function define_help09(param1:Dynamic):Void {
		help09 = param1;
		//help09 = cast(param1, Dynamic);
	}

	function define_dungeonMain(param1:Dynamic):Void  {
		dungeonMain = param1;
		//dungeonMain = cast(param1, Dynamic);
	}

	function define_help02(param1:Dynamic):Void  {
		help02 = param1;
		// help02 = cast(param1, Dynamic);
	}

	function define_stickMC(param1:Dynamic):Void  {
		stickMC = param1;
		//stickMC = cast(param1, Dynamic);
	}

	function define_kingdomMap(param1:Dynamic):Void  {
		kingdomMap = param1;
		//kingdomMap = cast(param1, Dynamic);
	}

	function define_prizeIcon(param1:Dynamic):Void  {
		prizeIcon = param1;
		//prizeIcon = cast(param1, Dynamic);
	}

	function define_storeScreen(param1:Dynamic):Void  {
		storeScreen = param1;
		//storeScreen = cast(param1, Dynamic);
	}

	function define_levelBox(param1:Dynamic):Void  {
		levelBox = param1;
		// levelBox = cast(param1, Dynamic);
	}

	function define_capeMC(param1:Dynamic):Void {
		capeMC = param1;
		//capeMC = cast(param1,MovieClip);
	}

	function define_yesNoBox(param1:Dynamic):Void  {
		yesNoBox = param1;
		//yesNoBox = cast(param1, Dynamic);
	}

	function define_menuScreen(param1:Dynamic):Void  {
		menuScreen = param1;
		// menuScreen = cast(param1, Dynamic);
	}

	function define_hitMatrix(param1:Dynamic):Void  {
		hitMatrix = param1;
		//hitMatrix = cast(param1, Dynamic);
	}

	function define_babyMain(param1:Dynamic):Void  {
		babyMain= param1;
		//babyMain = cast(param1, Dynamic);
	}

	function define_enemyAttacks(param1:Dynamic):Void  {
		enemyAttacks = param1;
		//enemyAttacks = cast(param1, Dynamic);
	}

	function define_fightBack(param1:Dynamic):Void  {
		fightBack = param1;
		// fightBack = cast(param1, Dynamic);
	}

	function define_questManagerScreen(param1:Dynamic):Void  {
		questManagerScreen = param1;
		//questManagerScreen = cast(param1, Dynamic);
	}

	function define_help10(param1:Dynamic):Void  {
		help10 = param1;
		//help10 = cast(param1, Dynamic);
	}

	function define_magicBookScreen(param1:Dynamic):Void  {
		magicBookScreen = param1;
		//magicBookScreen = cast(param1, Dynamic);
	}

	function define_hitAnim(param1:Dynamic):Void  {
		hitAnim = param1;
		//hitAnim = cast(param1, Dynamic);
	}

	function define_dungeonMap(param1:Dynamic):Void  {
		dungeonMap = param1;
		//dungeonMap = cast(param1, Dynamic);
	}

	function define_dungeonIcon(param1:Dynamic):Void  {
		dungeonIcon = param1;
		//dungeonIcon = cast(param1, Dynamic);
	}

	function define_towerScreen(param1:Dynamic):Void  {
		towerScreen = param1;
		// towerScreen = cast(param1, Dynamic);
	}

	function define_fighterIcon(param1:Dynamic):Void  {
		fighterIcon = param1;
		//fighterIcon = cast(param1, Dynamic);
	}

	function define_winBox(param1:Dynamic):Void  {
		winBox = param1;
		// winBox = cast(param1, Dynamic);
	}

	function define_itemPopup(param1:Dynamic):Void  {
		itemPopup = param1;
		// itemPopup = cast(param1, Dynamic);
	}

	function define_hitPoints(param1:Dynamic):Void  {
		hitPoints = param1;
		// hitPoints = cast(param1, Dynamic);
	}

	function define_openingScreen(param1:Dynamic):Void  {
		openingScreen = param1;
		// openingScreen = cast(param1, Dynamic);
	}

	function define_beltMC(param1:Dynamic):Void {
		beltMC = param1;
		// beltMC = cast(param1, MovieClip);
	}

	function define_possibleMove(param1:Dynamic):Void  {
		possibleMove = param1;
		// possibleMove = cast(param1, Dynamic);
	}

	function define_newPlayerScreen(param1:Dynamic):Void  {
		newPlayerScreen = param1;
		// newPlayerScreen = cast(param1, MovieClip);
	}

	function define_daiperMC(param1:Dynamic):Void  {
		daiperMC = param1;
		//daiperMC = cast(param1, Dynamic);
	}

	function define_hatMC(param1:Dynamic):Void {
		hatMC = param1;
		// hatMC = cast(param1, MovieClip);
	}

	function define_generalFrame(param1:Dynamic):Void  {
		generalFrame = param1;
		// generalFrame = cast(param1, Dynamic);
	}

	function define_babyAttacks(param1:Dynamic):Void  {
		babyAttacks = param1;
		// babyAttacks = cast(param1, Dynamic);
	}

	/**
	 * Needed to write a new function to check if a function in define exists
	 * and to call it with the param2
	 * @param param1 
	 * @param param2 
	 */
	public function defineAsset(param1:String, param2:Dynamic):Void {
		var _loc3_:String = "define_" + param1;
		var method = Reflect.field(this, _loc3_);

		if(method != null && Reflect.isFunction(method)) {
			Reflect.callMethod(this, method, [param2]);
		} else {
			trace("define asset error" + _loc3_ + "method not found in instance0");
		}
	}

	/* function defineAsset(param1:String, param2:Dynamic):Void  {
		var _loc3_:Null<Dynamic>  = null ;
		_loc3_ = "define_" + param1;
		this[_loc3_](param2);
	} */

	function define_questIcon(param1:Dynamic):Void  {
		questIcon = param1;
		//questIcon = cast(param1, MovieClip);
	}

	function define_cardPopup(param1:Dynamic):Void  {
		cardPopup = param1;
		// cardPopup = cast(param1, MovieClip);
	}

	function define_emptyCard(param1:Dynamic):Void  {
		emptyCard = param1;
		// emptyCard = cast(param1, BambaCard);
	}

	function define_shoesMC(param1:Dynamic):Void  {
		shoesMC = param1;
		// shoesMC = cast(param1, MovieClip);
	}

	function define_eyesMC(param1:Dynamic):Void  {
		eyesMC = param1;
		// eyesMC = cast(param1, MovieClip);
	}

	function define_enemyTip(param1:Dynamic):Void  {
		enemyTip = param1;
		// enemyTip = cast(param1, MovieClip);
	}

	function define_enemyReg(param1:Dynamic):Void  {
		enemyReg = param1;
		// enemyReg = cast(param1, MovieClip);
	}
}
