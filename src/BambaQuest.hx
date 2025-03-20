package;

import openfl.display.*;

class BambaQuest extends DisplayObject {
	public var tutorialCode:Float;

	public var minLevel:Float;

	public var questsPossibleDungeonsIds:Array<Dynamic>;

	public var prizesIds:Array<Dynamic>;

	public var id:Float;

	public var qGraphics:Float;

	public var dungeonIds:Array<Dynamic>;

	public var qDesc:String;

	public var qName:String;

	public var endMsg:String;

	public var enemiesIds:Array<Dynamic>;

	public var dungeonDifficulties:Array<Dynamic>;

	public var type:Float;

	public var exPoints:Float;

	public function new(param1:Xml) {
		super();
		id = param1.id;
		qName = param1.name;
		qDesc = param1.desc;
		type = param1.type;
		dungeonIds = param1.dungeonIds.split(",");
		dungeonDifficulties = param1.dungeonDifficulties.split(",");
		if (param1.enemiesIds != "") {
			enemiesIds = param1.enemiesIds.split(",");
		} else {
			enemiesIds = [];
		}
		prizesIds = param1.prizesIds.split(",");
		exPoints = param1.exPoints;
		minLevel = param1.minLevel;
		qGraphics = param1.qGraphics;
		endMsg = param1.endMsg;
		tutorialCode = param1.tutorialCode;
		questsPossibleDungeonsIds = [];
	}
}
