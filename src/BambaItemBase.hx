package;

class BambaItemBase {
	public var id:Float;

	public var iType:Int;

	public var buyPrice:Float;

	public var addMagic:Float;

	public var minLevel:Float;

	public var sellPrice:Float;

	public var iDesc:String;

	public var iName:String;

	public var addLife:Float;

	public var addRoundRegeneration:Float;

	public function new(param1:Dynamic) {
		id = param1.id;
		iName = param1.name;
		iDesc = param1.desc;
		iType = param1.type;
		buyPrice = param1.buyPrice;
		sellPrice = param1.sellPrice;
		minLevel = param1.minLevel;
		addLife = param1.addLife;
		addMagic = param1.addMagic;
		addRoundRegeneration = param1.addRoundRegeneration;
	}
}
