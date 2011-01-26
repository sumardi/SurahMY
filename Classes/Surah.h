//
//  Surah.h
//  SurahMY
//
//  Created by Sumardi Shukor on 1/27/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Surah : NSObject {
	NSNumber *index;
	NSString *title;
}

@property (nonatomic, retain) NSNumber *index;
@property (nonatomic, retain) NSString *title;

-(id)initWithIndex:(NSNumber *)i title:(NSString *)t;

@end
