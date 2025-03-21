package erate;

import openfl.net.*;
import openfl.utils.Dictionary;
import openfl.display.DisplayObjectContainer;

class ERate extends DisplayObjectContainer {
	public static var allowMultipleShowEvent:Bool = false;

	private static var params_dic:Dictionary<Dynamic, Dynamic> = new Dictionary<Dynamic,Dynamic>(true);

	public function new() {
		super();
	}

	public static function getParam(param1:String):String {
		return params_dic[param1];
	}

	public static function sendEvent(param1:String, param2:Float):Void {
		var variables:URLVariables = null;
		var request:URLRequest = null;
		var erateID:String = param1;
		var eventType:Float = param2;
		if (erateID == "" || Math.isNaN(eventType) == true) {
			return;
		}
		if (getParam("erateFlag_" + erateID) == null && eventType == 1 || allowMultipleShowEvent || eventType != 1) {
			if (eventType == 1) {
				setParam("erateFlag_" + erateID, "exposed");
			}
			variables = new URLVariables();
			variables.toolId = erateID;
			variables.eventType = eventType;
			request = new URLRequest("http://213.8.137.51/Erate/eventreport.asp");
			request.data = variables;
			request.method = URLRequestMethod.POST;
			try {
				//sendToURL(request);
			} catch (e:Dynamic) {
				trace("error sending erate:" + e);
			}
		}
	}

	public static function setParam(param1:String, param2:String):Void {
		params_dic[param1] = param2;
	}
}
