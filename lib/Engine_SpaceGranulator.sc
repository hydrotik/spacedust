/*
hydrotik
*/

Engine_SpaceGranulator : CroneEngine {

	var <synths;

	*new { arg context, doneCallback;
		^super.new(context, doneCallback);
	}
	
	
	free {
		synths.free;
	}
}