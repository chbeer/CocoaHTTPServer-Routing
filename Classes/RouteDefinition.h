//
//  RouteDefinition.h
//  iVocabulary
//
//  Created by Christian Beer on 29.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteDefinition : NSObject

@property (nonatomic, copy)     NSString              *path;
@property (nonatomic, strong)   NSRegularExpression   *compiledPath;

@property (nonatomic, copy)     NSArray               *captureNames;


- (id) initWithPath:(NSString*)path error:(NSError**)outError;

- (BOOL) match:(NSString*)path;
- (NSDictionary*) parsePathParametersFromPath:(NSString*)path;

@end
