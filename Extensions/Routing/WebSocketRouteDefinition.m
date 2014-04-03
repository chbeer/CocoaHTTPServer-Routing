//
//  WebSocketRouteDefinition.m
//  iVocabulary
//
//  Created by Christian Beer on 29.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "WebSocketRouteDefinition.h"

#import "CocoaHTTPServer.h"
#import "WebSocket.h"

@interface BlockBasedWebSocket : WebSocket
@property (nonatomic, copy) WebSocketDidOpenHandler didOpenHandler;
@property (nonatomic, copy) WebSocketDidCloseHandler didCloseHandler;
@property (nonatomic, copy) WebSocketDidReceiveMessageHandler didReceiveMessageHandler;
@end


@interface WebSocketRouteDefinition ()
@end

@implementation WebSocketRouteDefinition

@synthesize didOpenHandler = _didOpenHandler;
@synthesize didCloseHandler = _didCloseHandler;
@synthesize didReceiveMessageHandler = _didReceiveMessageHandler;


- (id) initWithPath:(NSString *)path error:(NSError **)outError
     didOpenHandler:(WebSocketDidOpenHandler)openHandler didReceiveMessageHandler:(WebSocketDidReceiveMessageHandler)messageHandler
    didCloseHandler:(WebSocketDidCloseHandler)closeHandler
{
    self = [super initWithPath:path error:outError];
    if (!self) return nil;

    self.didOpenHandler = openHandler;
    self.didReceiveMessageHandler = messageHandler;
    self.didCloseHandler = closeHandler;

    return self;
}


#pragma mark - 

- (WebSocket*) webSocketForRequest:(HTTPMessage *)aRequest socket:(GCDAsyncSocket *)socket
{
    BlockBasedWebSocket *webSocket = [[BlockBasedWebSocket alloc] initWithRequest:aRequest socket:socket];
    webSocket.didOpenHandler = self.didOpenHandler;
    webSocket.didCloseHandler = self.didCloseHandler;
    webSocket.didReceiveMessageHandler = self.didReceiveMessageHandler;
    return webSocket;
}

@end


@implementation BlockBasedWebSocket

@synthesize didOpenHandler = _didOpenHandler;
@synthesize didCloseHandler = _didCloseHandler;
@synthesize didReceiveMessageHandler = _didReceiveMessageHandler;


#pragma mark -

- (void)didOpen
{
    [super didOpen];

    if (self.didOpenHandler) {
        self.didOpenHandler(self);
    }
}

- (void)didReceiveMessage:(NSString *)msg
{
    [super didReceiveMessage:msg];

    if (self.didReceiveMessageHandler) {
        self.didReceiveMessageHandler(self, msg);
    }
}

- (void)didClose
{
    if (self.didCloseHandler) {
        self.didCloseHandler(self);
    }
    
    [super didClose];
}

@end