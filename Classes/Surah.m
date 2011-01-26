//
//  Surah.m
//  SurahMY
//
//  Created by Sumardi Shukor on 1/27/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import "Surah.h"


@implementation Surah

@synthesize title, index;

-(id)initWithIndex:(NSNumber *)i title:(NSString *)t {
	self.index = i;
	self.title = t;
	return self;
}

@end
