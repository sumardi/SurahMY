//
//  SurahMYAppDelegate.m
//  SurahMY
//
//  Created by Sumardi Shukor on 1/26/11.
//  Copyright 2011 Software Machine Development. All rights reserved.
//

#import "SurahMYAppDelegate.h"
#import "MainViewController.h"
#import "Surah.h"
#import "Ayat.h"

@implementation SurahMYAppDelegate

@synthesize window, mainViewController, surahs, ayats;


#pragma mark -
#pragma mark Application lifecycle

// Create a new connection to the database.
- (void) newDatabaseConnection {
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	success = [fileManager fileExistsAtPath:dbPath];
	
	if(success) return;
	
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
	
	[fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
	[fileManager release];
}

// Read and store surah from the database.
- (void) readSurahs {
	sqlite3 *database;
	
	surahs = [[NSMutableArray alloc] init];
	
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStr = [NSString stringWithFormat:@"select * from surahs"];
		const char *sqlStatement = [sqlStr UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSNumber *sIndex = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 1)];
				NSString *sTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				Surah *s = [[Surah alloc] initWithIndex:sIndex title:sTitle];
				[surahs addObject:s];
				[s release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
}

// Read and store ayat from the database.
- (void) readAyats {
	sqlite3 *database;
	
	ayats = [[NSMutableArray alloc] init];
	
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		NSString *sqlStr = [NSString stringWithFormat:@"select * from ayats"];
		const char *sqlStatement = [sqlStr UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSNumber *aIndex = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 0)];
				NSNumber *aSurahIndex = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 1)];
				NSString *aFolder = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *aTitleEng = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *aImage = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				Ayat *a = [[Ayat alloc] initWithIndex:aIndex surah:aSurahIndex folder:aFolder title:aTitle eng:aTitleEng image:aImage];
				[ayats addObject:a];
				[a release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    dbName = @"alquran_db.sqlite";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	dbPath = [documentsDir stringByAppendingPathComponent:dbName];
	
	[self newDatabaseConnection];    
	[self readSurahs];
	[self readAyats];
	
	[self.window makeKeyAndVisible];
	[self.window addSubview:mainViewController.view];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[mainViewController release];
	[surahs release];
	[ayats release];
    [super dealloc];
}


@end
