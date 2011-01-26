//
//  Ayat.m
//  SurahMY
//
//  Created by Sumardi Shukor on 1/27/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import "Ayat.h"


@implementation Ayat

@synthesize index, surahIndex, folder, title, title_eng, image;

-(id) initWithIndex:(NSNumber *)i surah:(NSNumber *)s folder:(NSString *)f title:(NSString *)t eng:(NSString *)e image:(NSString *)m {
	self.index = i;
	self.surahIndex = s;
	self.folder = f;
	self.title = t;
	self.title_eng = e;
	self.image = m;
	return self;
}

@end
