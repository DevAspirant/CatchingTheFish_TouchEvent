//
//  ViewController.m
//  CatchingTheFish
//
//  Created by ammar falmban on 10/22/13.
//  Copyright (c) 2013 SDKaizen.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize fish1;
@synthesize fish2;
@synthesize fish3;
@synthesize fish4;
@synthesize fish5;
@synthesize fish6;
@synthesize fish7;
@synthesize fish8;
@synthesize fish9;
@synthesize fish10;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //
    fishArray = [NSArray arrayWithObjects:self.fish1,self.fish2,self.fish3,self.fish4,self.fish5,
                 self.fish6,self.fish7,self.fish8,self.fish9,self.fish10, nil];
    
    // calling initGame method
    [self initGame];
    
    // Until 0.05 sec begin the game
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(mailloop)
                                   userInfo:nil repeats:YES];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// initGame method & that method it,s depends on begining the Game
-(void)initGame{
    
    stopCounter = 0;
    
    // beginning the all fish moving
    for(int i  =0 ;i<fishArray.count;i++){
        UIImageView *w_fish =[fishArray objectAtIndex:i];
        
        // every fish give it number as tag
        w_fish.tag = i;
        
        // calling the initFish method
        [self initFish:w_fish];
    }
}

// initFish method & that method,s making the fish movement
-(void)initFish:(UIImageView *)w_fish{
    
    // search the fish tag number
    int wid = w_fish.tag;
    
    // make the fish place Randomlly
    int x = arc4random() % 280 + 20;
    int y = arc4random() % 400 + 40;
    w_fish.center = CGPointMake(x, y);
    
    // make the fish speed Randomlly , and finding the number & save it
    float spd   = arc4random() % 12 + 1;
    float angle = arc4random() % 360;
    float rad   = angle * M_PI / 180;
    
    //
    vx[wid]= cos(rad) * spd;
    vy[wid]= sin(rad) * spd;
    angles[wid] = angle;

    w_fish.transform = CGAffineTransformMakeRotation(angle * M_PI / 180.0);
    
    //
    w_fish.alpha = 0.05;

}

// looping method on the Gaming
-(void)mailloop{
    if(stopCounter == 0){
        // search the fish moving slowly
        for (int i = 0; i<fishArray.count; i++)
        {
            UIImageView *w_fish = [fishArray objectAtIndex:i];
            
            // search the tag number & the Speed ( vx , vy ) , and the slow movement
            float wx = w_fish.center.x + vx[w_fish.tag];
            float wy = w_fish.center.y + vy[w_fish.tag];
            
            // ?
            if(340 < wx ){
                wx = -10;
            }
            if( wx < -20 ){
                wx = 330;
            }
            if(550 < wy ){
                wy = -10;
            }
            if(wy < -20 ){
               wy = 490;
            }
            // make the fish place & movement
            w_fish.center = CGPointMake(wx, wy);
        }
    }else if (0 < stopCounter){
        stopCounter--;
        
        // if the user catched the fish change the size bigger
        if(stopCounter == 0){
            for (int i = 0; i<getFish.count; i++) {
                UIImageView *w_fish = [getFish objectAtIndex:i];
                w_fish.transform = CGAffineTransformIdentity;
                [self initFish:w_fish];
            }
            self.POI.transform = CGAffineTransformIdentity;
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // search the user touch
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    // calling touch begine
    [super touchesBegan:touches withEvent:event];
    
    // if the application is not stop then back
    if(0 < stopCounter){
        return;
    }
    
    //
    self.POI.center = CGPointMake(location.x - 50 , location.y - 50);
    
    // setting another imaged when the user catched a fish
    [self.POI setImage:[UIImage imageNamed:@"poi2.png"]];
    
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    // search the user touch
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    // calling touch Moved 
    [super touchesMoved:touches withEvent:event];

    // if the application is not stop then back
    if(0 < stopCounter){
        return;
    }
     self.POI.center = CGPointMake(location.x - 50 , location.y - 50);
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // calling touch Moved
    [super touchesEnded:touches withEvent:event];
    
    // if the application is not stop then back
    if(0 < stopCounter){
        return;
    }
    
    // Searching the fishs
    getFish = [NSMutableArray array];
    for (int i = 0; i<fishArray.count; i++) {
        UIImageView *w_fish = [fishArray objectAtIndex:i];
        
        // searching the distance between the poi and fish
        float dx   = abs(w_fish.center.x - self.POI.center.x);
        float dy   = abs(w_fish.center.y - self.POI.center.y);
        float dist = sqrt(dx * dx + dy * dy);
        
        // when the distance will be < 40
        if(dist < 40){
            [getFish addObject:w_fish];
            
            w_fish.alpha = 1.0;
            CGAffineTransform tf = w_fish.transform;
            w_fish.transform = CGAffineTransformScale(tf, 2, 2);
        }
        
    }
    [self.POI setImage:[UIImage imageNamed:@"poi1.png"]];
    self.POI.transform = CGAffineTransformMakeScale(1.5, 1.5);
    
    //
    stopCounter = 30;
}
@end
