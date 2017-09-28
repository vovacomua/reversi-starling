package engine.tileStates
{
	import engine.FrameSprite;
	
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
		
		public function setEmpty():void{
			state.setEmply(player);
		}
		
		public function setHint():void{
			state.setHint(player);
		}
		
		public function setBlack():void{
			state.setBlack(player);
		}
		
		public function setWhite():void{
			state.setWhite(player);
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