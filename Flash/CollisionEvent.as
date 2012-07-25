package  {
	import flash.events.Event;
	public class CollisionEvent extends Event {

			// constructor code
	  public static const CUSTOM:String = "custom";
	  public var _message:String = "";
      public var arg:*;
	  
	  
	  public static const ON_COLLISION:String = "onCollision";

	  
      public function CollisionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) : void {
      	  super(type, bubbles, cancelable);
          //this.arg = customArg;
		  trace("loggin' it");
      }
        
           
   
			
			
		

	}
	
}
