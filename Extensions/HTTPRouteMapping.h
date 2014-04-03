//
//  HTTPRouteMapping.h
//  iVocabulary
//
//  Created by Christian Beer on 12.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "CocoaHTTPServer.h"

#import "WebSocketRouteDefinition.h"

typedef NSObject<HTTPResponse>* (^HTTPRequestHandler)(HTTPConnection* connection, NSString *method, NSString *path, NSDictionary *pathParameters, NSDictionary *requestParameters);
typedef BOOL (^HTTPRequestExpectsBodyCallback)(NSString *method, NSString *path, HTTPMessage *request);

@class HTTPRouteDefinition;


@interface HTTPRouteMapping : NSObject

@property (strong, nonatomic, readonly) NSMutableArray      *routes;
@property (strong, nonatomic, readonly) NSMutableArray      *webSocketRoutes;

@property (nonatomic, copy)     HTTPRequestHandler  defaultHandler;

+ (HTTPRouteMapping*) sharedInstance;

- (HTTPRouteDefinition*) routeDefinitionForMethod:(NSString*)method path:(NSString *)path;
- (WebSocketRouteDefinition*) webSocketRouteDefinitionForPath:(NSString *)path;

- (HTTPRouteDefinition*) addHandlerForMethod:(NSString*)method withPath:(NSString*)path handler:(HTTPRequestHandler)handler;
- (HTTPRouteDefinition*) addHandlerForGetWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
- (HTTPRouteDefinition*) addHandlerForPostWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
- (HTTPRouteDefinition*) addHandlerForPutWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;
- (HTTPRouteDefinition*) addHandlerForDeleteWithPath:(NSString*)path handler:(HTTPRequestHandler)handler;

- (WebSocketRouteDefinition*) addWebSocketHandlerForPath:(NSString*)path receivedMessageHandler:(WebSocketDidReceiveMessageHandler)handler;

@end
