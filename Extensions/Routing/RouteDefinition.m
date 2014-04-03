//
//  RouteDefinition.m
//  iVocabulary
//
//  Created by Christian Beer on 29.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "RouteDefinition.h"

@interface RouteDefinition ()

- (BOOL) compilePath:(NSString*)path error:(NSError**)error;

@end

@implementation RouteDefinition

@synthesize path            = _path;
@synthesize compiledPath    = _compiledPath;
@synthesize captureNames    = _captureNames;


- (id) initWithPath:(NSString*)path error:(NSError**)outError
{
    self = [super init];
    if (!self) return nil;
    
    if (![self compilePath:path error:outError]) {
        return nil;
    }
    
    return self;
}


#pragma mark -

- (BOOL) match:(NSString*)path;
{
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    
    int matches = [self.compiledPath numberOfMatchesInString:path options:0 range:NSMakeRange(0, path.length)];
    return matches == 1;
}

- (BOOL) compilePath:(NSString*)path error:(NSError**)outError
{
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    NSArray *components = [path pathComponents];
    
    NSMutableString *pattern = [NSMutableString string];
    NSMutableArray  *captureNames = [NSMutableArray array];
    
    [pattern appendString:@"^"];
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx > 0) {
            [pattern appendString:@"\\/"];
        }
        
        if ([obj hasPrefix:@":"]) {
            // taken from http://www.ietf.org/rfc/rfc1738.txt (loalpha | hialpha | digit | safe ($-_.+) | extra (!*'(),) | 
            // . and $ can not be used in [...]
            [pattern appendString:@"((?:[a-zA-Z0-9-_+!*'(),]|\\.|\\$|%\\d{2})+)"];
            
            NSString *name = [obj substringFromIndex:1];
            [captureNames addObject:name];
            
        } else if ([@"*" isEqual:obj]) {
            [pattern appendString:@"(.*)"];
            
            [captureNames addObject:@"*"];
            
            *stop = YES;  // * must be the last element in path
        } else {
            [pattern appendFormat:@"%@", obj];
        }
    }];
    [pattern appendString:@"\\/?$"];
    
    self.captureNames = captureNames;
    self.compiledPath = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:outError];
    
    return (self.compiledPath != nil);
}

- (NSDictionary*) parsePathParametersFromPath:(NSString*)path
{
    
    if ([path hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    
    NSRange questionMarkRange = [path rangeOfString:@"?"];
    if (questionMarkRange.location != NSNotFound) {
        path = [path substringToIndex:questionMarkRange.location];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSArray *matches = [self.compiledPath matchesInString:path options:NSMatchingRequiredEnd range:NSMakeRange(0, path.length)];
    
    if (matches.count != 1) return nil;
    
    NSTextCheckingResult *result = [matches lastObject];
    
    if ([result numberOfRanges] > 1) {
        for (int i = 1; i < [result numberOfRanges]; i++) { // range #0 = complete string
            NSRange range = [result rangeAtIndex:i];
            NSString *name = [self.captureNames objectAtIndex:i - 1];
            
            [parameters setObject:[path substringWithRange:range] forKey:name];
        }
    }
    
    return parameters;
}

@end
