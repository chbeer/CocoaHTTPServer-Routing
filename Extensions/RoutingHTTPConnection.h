//
//  RoutingHTTPConnection.h
//  iVocabulary
//
//  Created by Christian Beer on 12.12.11.
//  Copyright (c) 2011 Christian Beer. All rights reserved.
//

#import "HTTPConnection.h"

@interface RoutingHTTPConnection : HTTPConnection

@property (strong, nonatomic, readonly) NSData            *requestContentBody;

@property (strong, nonatomic, readonly) NSString          *requestContentFileName;
@property (strong, nonatomic, readonly) NSOutputStream    *requestContentStream;

@end
