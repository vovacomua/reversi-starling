package engine.tileStates
{
	import engine.FrameSprite;
	
	import starling.core.Starling;
	
	public class StateContext
	{
		
		private var emptyState:EmptyState;
		private var hintState:HintState;
		private var blackState:BlackState;
		private var whiteState:WhiteState;
		
		private var state:State;
		
		private var player:FrameSprite;
		
		public function StateContext(player:FrameSprite)
		{
			this.player = player;
			
			emptyState = new EmptyState(this);
			hintState  = new HintState(this);
			blackState = new BlackState(this);
			whiteState = new WhiteState(this);
			
			state = emptyState;
		}
		
		//
		
		public function setEmpty(delay:Number):void{
			//state.setEmply(player);
			Starling.juggler.delayCall(state.setEmply, delay, player);
		}
		
		public function setHint(delay:Number):void{
			//state.setHint(player);
			Starling.juggler.delayCall(state.setHint, delay, player);
		}
		
		public function setBlack(delay:Number):void{
			//state.setBlack(player);
			Starling.juggler.delayCall(state.setBlack, delay, player);
		}
		
		public function setWhite(delay:Number):void{
			//state.setWhite(player);
			Starling.juggler.delayCall(state.setWhite, delay, player);
		}
		
		//set new current state
		
		public function setState(state:State):void{
			this.state = state;
		}
		
		//get state for current state's request to set NEW current state
		
		public function getEmptyState():State{
			return this.emptyState;
		}
		
		public function getHintState():State{
			return this.hintState;
		}
		
		public function getBlackState():State{
			return this.blackState;
		}
		
		public function getWhiteState():State{
			
			return this.whiteState;
			
		}
	}
}