//
//  KinveyUploader.m
//  Safe Drive
//
//  Created by Andrew Roach on 4/28/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

#import "KinveyUploader.h"
@implementation KinveyUploader


-(void)uploadDefaultSettingsWithChildEmail:(NSString *)email {
    
    Settings *settingToUpload = [[Settings alloc] init];
    [settingToUpload setChildUserName:email];
    [settingToUpload setBacLimit:[NSNumber numberWithInt:0.0]];
    [settingToUpload setParentUserName:[KCSUser activeUser].username];
    [settingToUpload setConfirmedLink:[NSNumber numberWithBool:FALSE]];
    if (!settingToUpload.metadata) {
        settingToUpload.metadata = [[KCSMetadata alloc] init];
    }
    [settingToUpload.metadata setGloballyReadable:TRUE];
    [settingToUpload.metadata setGloballyWritable:TRUE];

    
    [self uploadSetting:settingToUpload];
    
}

-(void)uploadSetting:(Settings *)setting {

    KCSCollection* collection = [KCSCollection collectionFromString:@"Settings" ofClass:[Settings class]];
    KCSAppdataStore *store = [KCSAppdataStore storeWithCollection:collection options:nil];
    [store saveObject:setting withCompletionBlock:^(NSArray *objectsOrNil, NSError *errorOrNil) {
        if (errorOrNil != nil) {
            //save failed
            NSLog(@"Save failed, with error: %@", [errorOrNil description]);
        } else {
            //save was successful
            NSLog(@"Successfully saved event (id='%@').", [objectsOrNil[0] kinveyObjectId]);
        }
    } withProgressBlock:nil];
}





@end
