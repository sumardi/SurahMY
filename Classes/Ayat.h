//
//  Ayat.h
//  SurahMY
//
//  Created by Sumardi Shukor on 1/27/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Ayat : NSObject {
	NSNumber *index;
	NSNumber *surahIndex;
	NSString *folder;
	NSString *title;
	NSString *title_eng;
	NSString *image;
}

@property (nonatomic, retain) NSNumber *index;
@property (nonatomic, retain) NSNumber *surahIndex;
@property (nonatomic, retain) NSString *folder;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *title_eng;
@property (nonatomic, retain) NSString *image;

-(id) initWithIndex:(NSNumber *)i surah:(NSNumber *)s folder:(NSString *)f title:(NSString *)t eng:(NSString *)e image:(NSString *)m;

@end
