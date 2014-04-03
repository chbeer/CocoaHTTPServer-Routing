//
//  RoutingHTTPManager.m
//  iVocabulary
//
//  Created by Christian Beer on 12.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "HTTPRouteMapping.h"

#import "HTTPRouteDefinition.h"
#import "WebSocketRouteDefinition.h"

@interface HTTPRouteMapping ()

@property (strong, nonatomic, readwrite) NSMutableArray      *routes;
@property (strong, nonatomic, readwrite) NSMutableArray      *webSocketRoutes;

@end


@implementation HTTPRouteMapping

@synthesize routes = _routes;
@synthesize webSocketRoutes = _webSocketRoutes;

@synthesize defaultHandler = _defaultHandler;

+ (HTTPRouteMapping*) sharedInstance
{
    static HTTPRouteMapping *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[[self class] alloc] init];
    }
    return sharedInstance;
}

#pragma mark -

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    _routes = [[NSMutableArray alloc] init];
    _webSocketRoutes = [[NSMutableArray alloc] init];
    
    return self;
}


#pragma mark - Route Management

- (HTTPRouteDefinition*) routeDefinitionForMethod:(NSString*)method path:(NSString *)path
{
    __block HTTPRouteDefinition *definition = nil;
    [_routes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (([@"*" isEqual:[obj method]] || [method isEqual:[obj method]]) && [obj match:path]) {
            definition = obj;
            *stop = YES;
        }
    }];
    
    return definition;
}
- (WebSocketRouteDefinition*) webSocketRouteDefinitionForPath:(NSString *)path
{
    __block WebSocketRouteDefinition *definition = nil;
    [_webSocketRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj match:path]) {
            definition = obj;
            *stop = YES;
        }
    }];

    return definition;
}

- (HTTPRouteDefinition*) addHandlerForMethod:(NSString*)method withPath:(NSString*)path handler:(HTTPRequestHandler)handler;
{
    NSError *error = nil;
    HTTPRouteDefinition *definition = [[HTTPRouteDefinition alloc] initWithMethod:method path:path error:&error handler:handler];
    NSAssert1(definition, @"Invalid handler path: %@", error);
    [_routes addObject:definition];
    return definition;
}

- (HTTPRouteDefinition*) addHandlerForGetWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
{
    return [self addHandlerForMethod:@"GET" withPath:path handler:handler];
}
- (HTTPRouteDefinition*) addHandlerForPostWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
{
    return [self addHandlerForMethod:@"POST" withPath:path handler:handler];
}
- (HTTPRouteDefinition*) addHandlerForPutWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
{
    return [self addHandlerForMethod:@"PUT" withPath:path handler:handler];
}
- (HTTPRouteDefinition*) addHandlerForDeleteWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
{
    return [self addHandlerForMethod:@"DELETE" withPath:path handler:handler];
}

- (WebSocketRouteDefinition*) addWebSocketHandlerForPath:(NSString*)path receivedMessageHandler:(WebSocketDidReceiveMessageHandler)handler;
{
    NSError *error = nil;
    WebSocketRouteDefinition *definition = [[WebSocketRouteDefinition alloc] initWithPath:path error:&error didOpenHandler:nil didReceiveMessageHandler:handler
                                                                          didCloseHandler:nil];
    NSAssert1(definition, @"Invalid handler path: %@", error);
    [self.webSocketRoutes addObject:definition];
    return definition;
}

@end
