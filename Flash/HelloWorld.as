package{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.events.Event;

	import flash.events.MouseEvent;
	import flash.display.Graphics;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.SimpleButton;
	

	 import flash.net.navigateToURL;
import flash.net.URLRequest;
	
	// Classes used in this example
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	
	import fl.transitions.Tween;
	import fl.transitions.*;
	
	import fl.transitions.easing.*;
	import fl.controls.Label;
	import flash.display.DisplayObject;
	
	
	public class HelloWorld extends Sprite{
		public var ballArray:Array;
		
		var counter:Number = 0;
		var time_count:Timer=new Timer(500);
		public var launch_index:Number = -1;
		public var scaleObject = 0.5;
        var largeWhiteFont:TextFormat;
		var pointsFont:TextFormat;
		var smallWhiteFont:TextFormat;
		var buttonFont:TextFormat;
		public var org_mob_x:Number = 20;
		public var org_mob_y:Number = 3;
		var pnlWinner:Sprite;
		var txtWinner:TextField;
		var buttonHeight:Number = 60;
		var buttonWidth:Number = 170;
		
		
        var totalScore:Number = 0;
		public var lblScore:Label;
        public var txtNOOO:TextField;

		function btnFire_Click(event:MouseEvent):void {
			fire();
   			trace('reload clicked');
		}
		
		
		
		
											
		
		function pnlWinner_Click(event:MouseEvent):void {
			//post to twitter
											//https://twitter.com/intent/tweet?text=Red+Elephant+Pizza+Party!
			
			
			var url:URLRequest = new URLRequest("https://twitter.com/intent/tweet?text=I+scored+" + String(totalScore) + " Points+in+Red+Elephant+Pizza+Party!+http://bit.ly/JPXh3i+via+@thejoebaldwin");
            navigateToURL(url, "_blank");
		}
		
		
		function btnRestart_Click(event:MouseEvent):void {
			restart();
   			trace('reload clicked');
		}
		
		function doIt(event:CollisionEvent):void {
			trace('event handled');
		}


         public function restart()
	{
		
		
		
		
		trace("Restart");
		for (var bb:b2Body = m_world.GetBodyList(); bb; bb = bb.GetNext()){
			if (bb.GetUserData() is Sprite){
				   
					var name:String = bb.GetUserData().name;
					
				    if (name != "m_world" && name != "m_boss")
                    {
					  bb.SetPosition(new b2Vec2(-100,0));
				    }
					else if (name == "m_boss")
					{
						bb.SetPosition(new b2Vec2(org_mob_x, org_mob_y));
						bb.SetAngle(0);
						bb.SetLinearVelocity(new b2Vec2(0,0));
						bb.SetAngularVelocity(0);
					}
				}
				//index += 1;
			}
		lblScore.text = "00000";
		totalScore = 0;
		txtNOOO.visible = false;
		pnlWinner.visible = false;
		txtWinner.visible = false;
		
		cleanPoints();
		cleanPoints();
		cleanPoints();
		
		
	}
	
		 public function cleanPoints()
		 {
			 
		for(var i=0; i<this.numChildren-1; i++)
		{
    			var temp:DisplayObject = this.getChildAt(i);
    			if (temp.name == "mytextfield")
				{
					//loop, then delete.
					this.removeChild(temp);
				}
		}
		 }

		public function fire()
		{
			var index:Number = 0;
			var isFound:Boolean = false;
			for (var bb:b2Body = m_world.GetBodyList(); bb; bb = bb.GetNext()){
				  if (bb.GetDefinition().userData != null)
				  {
					  var name:String = bb.GetDefinition().userData.name;
				      if (name != "m_world" && name != "m_boss")
					  {
						    if (launch_index == index)
							{
								var vec:b2Vec2 = new b2Vec2(2, 19);
				            	bb.SetPosition(vec);
								bb.GetDefinition().userData.hitCount = 0;
								//bb.SetAngularVelocity(10);
								bb.SetLinearVelocity(new b2Vec2(40, -20));
								launch_index += 1;
								isFound = true;
								break;
							}
					  }
				  }
			  index += 1;
			}
			if (!isFound)
			{
				launch_index = 0;
				fire();
			}
		}
		
		public function initControls()
		{
			
	       largeWhiteFont = new TextFormat();
		   largeWhiteFont.size = 40;
		   largeWhiteFont.color = "0xFFFFFF";
		   
		   pointsFont = new TextFormat();
		   pointsFont.size = 30;
		   pointsFont.color = "0xFFFFFF";
		   pointsFont.bold = true;
		   
		   buttonFont = new TextFormat();
		   buttonFont.size = 25;
		   buttonFont.color = "0xFFFFFF";
		   buttonFont.bold = true;
		   
		   
		   
		   
		    smallWhiteFont = new TextFormat();
		    smallWhiteFont.size = 20;
		    smallWhiteFont.color = "0xFFFFFF";
		    smallWhiteFont.font = "Calibri";
	        
	        var btnFire:Sprite = new Sprite();
			btnFire.graphics.beginFill(0xFFCC00);
			btnFire.graphics.drawRect(10, 10, buttonWidth, buttonHeight);
			btnFire.graphics.endFill();
			btnFire.addEventListener(MouseEvent.MOUSE_DOWN, btnFire_Click);
			this.addChild(btnFire);
			
			var txtFire:TextField = new TextField();  
			txtFire.text = "FIGHT!";  
			txtFire.width = buttonWidth;  
			txtFire.x = 10 + 10;  
			txtFire.y = 10 + 10;  
			txtFire.selectable = false;
			txtFire.addEventListener(MouseEvent.MOUSE_DOWN, btnFire_Click);
			txtFire.setTextFormat(buttonFont, -1, -1);
			addChild(txtFire);  
			
			
			var restart_x:Number = 200;
			var restart_y:Number = 10;
			
			var btnRestart:Sprite = new Sprite();
			btnRestart.graphics.beginFill(0xFFCC00);
			btnRestart.graphics.drawRect(restart_x, restart_y, buttonWidth, buttonHeight);
			btnRestart.graphics.endFill();
			btnRestart.addEventListener(MouseEvent.MOUSE_DOWN, btnRestart_Click);
			this.addChild(btnRestart);
			
			var txtRestart:TextField = new TextField();  
			txtRestart.text = "RESTART";  
			txtRestart.width = buttonWidth;  
			txtRestart.x = restart_x + 10;  
			txtRestart.y = restart_y + 10;  
			txtRestart.selectable = false;
			txtRestart.addEventListener(MouseEvent.MOUSE_DOWN, btnRestart_Click);
			txtRestart.setTextFormat(buttonFont, -1, -1);
			addChild(txtRestart);  
			
			
			
			
			
			var score_x:Number = 700;
			var score_y:Number = 10;
			
			var scoreBackdrop:Sprite = new Sprite();
			scoreBackdrop.graphics.beginFill(0x0000FF);
			scoreBackdrop.graphics.drawRect(score_x,score_y, buttonWidth, buttonHeight);
			scoreBackdrop.graphics.endFill();
			this.addChild(scoreBackdrop);
			
			lblScore = new Label();
			lblScore.x = score_x + 10; 
			lblScore.y = score_y + 10;
			lblScore.width = buttonWidth;
			lblScore.height = buttonHeight;
			lblScore.text = "00000";
			lblScore.setStyle("textFormat", buttonFont);
		    this.addChild(lblScore);
			
			
			
			
			
			txtNOOO = new TextField();  
			txtNOOO.text = "NOOOOOOOOOOOOO";  
			txtNOOO.width = 500;  
			txtNOOO.height = 50;
			txtNOOO.selectable = false;
			txtNOOO.visible = false;
			txtNOOO.setTextFormat(largeWhiteFont, -1, -1);
			addChild(txtNOOO);  

var winner_x:Number = 300;
											var winner_y:Number = 300;
											pnlWinner = new Sprite();
												pnlWinner.graphics.beginFill(0xFF0000);
											pnlWinner.graphics.drawRect(winner_x, winner_y, buttonWidth, buttonHeight);
											pnlWinner.graphics.endFill();
											pnlWinner.visible = false;
											pnlWinner.addEventListener(MouseEvent.MOUSE_DOWN, pnlWinner_Click);
											this.addChild(pnlWinner);
			
											txtWinner = new TextField();  
											txtWinner.text = "YOU WIN!!!!\nTweet This";  
											txtWinner.width = 300;  
											txtWinner.height = 120;
											txtWinner.x = winner_x;  
											txtWinner.y = winner_y;  
											txtWinner.selectable = false;
											txtWinner.visible = false;
											
			
											txtWinner.setTextFormat(buttonFont, -1, -1);
											
											txtWinner.addEventListener(MouseEvent.MOUSE_DOWN, pnlWinner_Click);
											addChild(txtWinner);  
											
											
											
											
											
											

		}
		
		public function HelloWorld(){
			
		    ballArray = new Array();
			var index:Number = 0;
			
			var mySound:superman = new superman();
                                 	mySound.play();
			
            initControls();
			
			// Add event for main loop
			addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			addEventListener(CollisionEvent.ON_COLLISION, doIt, false, 0, true);
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 20.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			m_world = new b2World( gravity, doSleep);
			
			var m_contactListener=new b2ContactListener();
			m_world.SetContactListener(m_contactListener);

			// set debug draw
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(this);
			debugDraw.SetDrawScale(30.0);
			debugDraw.SetFillAlpha(0.3);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			m_world.SetDebugDraw(debugDraw);
			m_world.DrawDebugData();
			
			// Vars used to create bodies
			var body:b2Body;
			var bodyDef:b2BodyDef;
			var boxShape:b2PolygonShape;
			var circleShape:b2CircleShape;
			
			// Add ground body
			bodyDef = new b2BodyDef();
			//bodyDef.position.Set(15, 19);
			bodyDef.position.Set(10, 25);
			
			//bodyDef.angle = 0.1;
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox(20, 5);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.1;
			fixtureDef.density = 0; // static bodies require zero density
			
			// Add sprite to body userData
			bodyDef.userData = new PhysGround();
			bodyDef.userData.width = 60 * 20; 
			bodyDef.userData.height = 60 * 5; 
			bodyDef.userData.name = "m_world";
			addChild(bodyDef.userData);
			body = m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);

            //add vertical wall
			bodyDef = new b2BodyDef();
			//bodyDef.position.Set(15, 19);
			//bodyDef.position.Set(20, 5);
			bodyDef.position.Set(org_mob_x, org_mob_y);
			//bodyDef.angle = 0.1;
			bodyDef.type = b2Body.b2_dynamicBody;
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox(3, 7);
			fixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.1;
			fixtureDef.density = 1; // static bodies require zero density
			
			bodyDef.userData = new PhysBox();
        	bodyDef.userData.width = 60 * 3; 
			bodyDef.userData.height = 60 * 7; 
			bodyDef.userData.name = "m_boss";
					
			addChild(bodyDef.userData)
			body = m_world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			// Add some objects
			for (var i:int = 1; i < 20; i++){
				bodyDef = new b2BodyDef();
				bodyDef.position.x =  -100; //Math.random() * 15 + 5;
				bodyDef.position.y = Math.random() * 10;
				bodyDef.type = b2Body.b2_dynamicBody;
				var rX:Number = Math.random() + 0.5;
				var rY:Number = Math.random() + 0.5;
				
				circleShape = new b2CircleShape(rX * scaleObject);
				fixtureDef.shape = circleShape;
				fixtureDef.density = 1.0;
				fixtureDef.friction = 0.5;
				fixtureDef.restitution = 0.2;
				bodyDef.userData = new PhysCircle();
				bodyDef.userData.width = rX * 60 * scaleObject; 
				bodyDef.userData.height = rX * 60 * scaleObject; 
				bodyDef.userData.name = "ammo";
				bodyDef.userData.hit = false; 
				bodyDef.userData.hitCount = 0;
				body = m_world.CreateBody(bodyDef);
				body.CreateFixture(fixtureDef);
				
				
				var tempBall:BallSymbol = new BallSymbol();
				tempBall.x = bodyDef.position.x * 60 * scaleObject;
				tempBall.y = bodyDef.position.y * 60 * scaleObject
				tempBall.width = rX * 60 * scaleObject;
				tempBall.height = rX * 60 * scaleObject;
				ballArray.push(tempBall);
				this.addChild(tempBall);
				
				addChild(bodyDef.userData);
			}
			
		}
		
		
		public function fadeIt(txt:TextField)
  		{
		var prop:String = "alpha"; 
		var from:Number = 100;
		var to:Number = 0;
		var duration:Number = 2;
		
		var tween:Tween = new Tween(txt, "alpha", Regular.easeOut, from, to, 1, true);
		var tween2:Tween = new Tween(txt, "x", Regular.easeOut, txt.x, txt.x - 20, 2, true);
		var tween3:Tween = new Tween(txt, "y", Regular.easeOut, txt.y, txt.y + 20, 2, true);
		//tween.addEventListener(TweenEvent.MOTION_CHANGE, null);
		//tween.addEventListener(TweenEvent.MOTION_FINISH, null);
		}
		
		public function Update(e:Event):void{
			
			m_world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			var index:Number = 0;
			
			// Go through body list and update sprite positions/rotations
			for (var bb:b2Body = m_world.GetBodyList(); bb; bb = bb.GetNext()){
			if (bb.GetUserData() is Sprite){
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * 30;
					sprite.y = bb.GetPosition().y * 30;
					sprite.rotation = bb.GetAngle() * (180/Math.PI);

		            var name:String = bb.GetDefinition().userData.name;
				    if (name != "m_world" && name != "m_boss")
                            {
								if (bb.GetUserData().hit == true && sprite.y < 570)
								{
									bb.GetUserData().hit = false;
									
									
									trace('collision|x:' + sprite.x + "||y" + sprite.y);
									var myTextField:TextField = new TextField();  
									bb.GetUserData().hitCount += 1;
									totalScore += 100 * bb.GetUserData().hitCount;
									
									myTextField.text = "+" + String(100 * bb.GetUserData().hitCount);  
									myTextField.width = 100;  
									myTextField.x = sprite.x;  
									myTextField.y = sprite.y;  
									myTextField.name = "mytextfield";
									myTextField.setTextFormat(pointsFont, -1, -1);
									var mySound:hit3 = new hit3();
                                 	mySound.play();
									fadeIt(myTextField);
									addChild(myTextField);  
									
									lblScore.text = String(totalScore);
									
									
								}
								
								
								sprite.visible = false; 
								var tempBall:BallSymbol = ballArray[index];
								if (tempBall != null)
								{
									tempBall.width = sprite.width;
									tempBall.height = sprite.height;
									tempBall.x = sprite.x;
									tempBall.y = sprite.y;
									tempBall.rotation = sprite.rotation;
								}
							}
							else if (name == "m_boss")
									 {
										 //trace(sprite.y);
										 if (sprite.rotation > 15)
										 {
									   
										 txtNOOO.visible = true;
										 txtNOOO.x = sprite.x - 400;
										 txtNOOO.y = sprite.y + 80;
										 }
										 
										 if (sprite.x > 1300)
										 {
											txtWinner.visible = true;
											pnlWinner.visible = true;
											 
										 }
									 }
				}
				index += 1;
			}
		}
		public var m_world:b2World;
		public var m_velocityIterations:int = 20;
		public var m_positionIterations:int = 20;
		public var m_timeStep:Number = 1.0/30.0;
	}

}