//
//  ViewController.h
//  CatchingTheFish
//
//  Created by ammar falmban on 10/22/13.
//  Copyright (c) 2013 SDKaizen.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    // fish count
    float vx[10];
    float vy[10];
    float angles[10];
    
    // When catching the fish stop the Game
    int stopCounter;
    
    // the fish list
    NSArray *fishArray;
    
    // catched fish
    NSMutableArray *getFish;
}
@property (weak, nonatomic) IBOutlet UIImageView *POI;
@property (weak, nonatomic) IBOutlet UIImageView *fish1;
@property (weak, nonatomic) IBOutlet UIImageView *fish2;
@property (weak, nonatomic) IBOutlet UIImageView *fish3;
@property (weak, nonatomic) IBOutlet UIImageView *fish4;
@property (weak, nonatomic) IBOutlet UIImageView *fish5;
@property (weak, nonatomic) IBOutlet UIImageView *fish6;
@property (weak, nonatomic) IBOutlet UIImageView *fish7;
@property (weak, nonatomic) IBOutlet UIImageView *fish8;
@property (weak, nonatomic) IBOutlet UIImageView *fish9;
@property (weak, nonatomic) IBOutlet UIImageView *fish10;


@end
