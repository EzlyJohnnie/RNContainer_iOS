//
//  AppDelegate.h
//  RNContainer_iOS
//
//  Created by Johnnie Cheng on 16/07/18.
//  Copyright © 2018 Johnnie Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

