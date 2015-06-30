//
//  ConiferXML.h
//  Conifer XML
//
//  Created by Alex Wulff on 6/29/15.
//  Copyright (c) 2015 Conifer Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConiferXML : NSObject

-(NSMutableArray *)parseXMLWithURL: (NSString *)urlString objectTag:(NSString *)objectTag;

@end
