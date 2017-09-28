package engine.tileStates
{
	
	import engine.FrameSprite;
	
	public interface State
	{
		
		function setEmply (player:FrameSprite):void;
		function setHint  (player:FrameSprite):void;
		function setBlack (player:FrameSprite):void;
		function setWhite (player:FrameSprite):void;
		
	}
}