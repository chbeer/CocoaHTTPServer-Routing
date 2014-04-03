//
//  HTTPRouteDefinition.m
//  iVocabulary
//
//  Created by Christian Beer on 29.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "HTTPRouteDefinition.h"

#import "CocoaHTTPServer.h"


@interface HTTPRouteDefinition ()
@property (copy, nonatomic, readwrite) NSString                *method;
@property (copy, nonatomic, readwrite) HTTPRequestHandler       handler;
@property (copy, nonatomic, readwrite) Class                    connectionClass;
@end

@implementation HTTPRouteDefinition

@synthesize method              = _method;
@synthesize handler             = _handler;
@synthesize connectionClass     = _connectionClass;

@synthesize expectsRequestBodyCallback = _expectsRequestBodyCallback;

- (id) initWithMethod:(NSString*)method path:(NSString*)path error:(NSError**)outError handler:(HTTPRequestHandler)handler;
{
    self = [super initWithPath:path error:outError];
    if (!self) return nil;
    
    self.method = method;
    self.handler = handler;
    
    return self;
}
- (id) initWithMethod:(NSString*)method path:(NSString*)path error:(NSError**)outError connectionClass:(Class)connectionClass;
{
    self = [super initWithPath:path error:outError];
    if (!self) return nil;
    
    self.method = method;
    self.connectionClass = connectionClass;
    
    return self;
}

@end