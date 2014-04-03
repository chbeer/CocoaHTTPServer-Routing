//
//  WebSocketRouteDefinition.h
//  iVocabulary
//
//  Created by Christian Beer on 29.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RouteDefinition.h"

@class WebSocket;
@class HTTPMessage;
@class GCDAsyncSocket;

typedef void(^WebSocketDidOpenHandler)(WebSocket *socket);
typedef void(^WebSocketDidCloseHandler)(WebSocket *socket);
typedef void(^WebSocketDidReceiveMessageHandler)(WebSocket *socket, NSString *message);


@interface WebSocketRouteDefinition : RouteDefinition

@property (nonatomic, copy) WebSocketDidOpenHandler didOpenHandler;
@property (nonatomic, copy) WebSocketDidCloseHandler didCloseHandler;
@property (nonatomic, copy) WebSocketDidReceiveMessageHandler didReceiveMessageHandler;

- (id) initWithPath:(NSString *)path error:(NSError **)outError
     didOpenHandler:(WebSocketDidOpenHandler)openHandler didReceiveMessageHandler:(WebSocketDidReceiveMessageHandler)messageHandler
    didCloseHandler:(WebSocketDidCloseHandler)closeHandler;

- (WebSocket*) webSocketForRequest:(HTTPMessage *)aRequest socket:(GCDAsyncSocket *)socket;

@end
