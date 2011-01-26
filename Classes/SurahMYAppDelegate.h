//
//  SurahMYAppDelegate.h
//  SurahMY
//
//  Created by Sumardi Shukor on 1/26/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurahMYAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *mainViewController;

@end

