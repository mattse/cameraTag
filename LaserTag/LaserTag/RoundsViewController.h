//
//  RoundsViewController.h
//  LaserTag
//
//  Created by Matthew on 11/16/13.
//  Copyright (c) 2013 Andrew Shim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"

@interface RoundsViewController : UIViewController <SocketIODelegate, UINavigationControllerDelegate>
+ (SocketIO*) socketIO;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) UINavigationController *navController;

@end
