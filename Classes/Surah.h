//
//  Surah.h
//  SurahMY
//
//  Created by Sumardi Shukor on 1/27/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Surah : NSObject {
	NSString *title;
}

@property (nonatomic, retain) NSString *title;

-(id)initWithTitle:(NSString *)t;

@end
