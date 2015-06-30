//
//  ConiferXML.m
//  Conifer XML
//
//  Created by Alex Wulff on 6/29/15.
//  Copyright (c) 2015 Conifer Apps. All rights reserved.
//

#import "ConiferXML.h"

@implementation ConiferXML

-(NSMutableArray *)parseXMLWithURL: (NSString *)urlString objectTag:(NSString *)objectTag {
    NSError *error;
    
    NSData *raw = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingUncached error:&error];
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
        return nil;
    }
    
    NSString *xml = [[NSString alloc] initWithData:raw encoding:NSUTF8StringEncoding];
    NSMutableArray *rawData = [[NSMutableArray alloc] init];
    
    NSString *tagStart = [NSString stringWithFormat:@"<%@>",objectTag];
    NSString *tagEnd = [NSString stringWithFormat:@"</%@>",objectTag];
    
    rawData = [self stringsBetweenString:tagStart andString:tagEnd andText:xml];
    
    NSArray *infoTags = [self stringsBetweenString:@"<" andString:@">" andText:[rawData firstObject]];
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [rawData count]; i++) {
        NSMutableDictionary *toAdd = [[NSMutableDictionary alloc] init];
        
        NSString *rawObject = [rawData objectAtIndex:i];
        
        for (int j = 0; j < [infoTags count]; j++) {
            NSString *currentTag = [infoTags objectAtIndex:j];
            NSArray *dataForKey = [[NSArray alloc] init];
            
            NSString *tagStart = [NSString stringWithFormat:@"<%@>",currentTag];
            NSString *tagEnd = [NSString stringWithFormat:@"</%@>",currentTag];
            
            dataForKey = [self stringsBetweenString:tagStart andString:tagEnd andText:rawObject];
            [toAdd setObject:dataForKey forKey:currentTag];
        }
        
        [objects addObject:toAdd];
    }
    
    return objects;
    
}

-(NSMutableArray*)stringsBetweenString:(NSString*)start andString:(NSString*)end andText:(NSString*)text
{
    
    NSMutableArray* strings = [NSMutableArray arrayWithCapacity:0];
    
    NSRange startRange = [text rangeOfString:start];
    
    for( ;; )
    {
        
        if (startRange.location != NSNotFound)
        {
            
            NSRange targetRange;
            
            targetRange.location = startRange.location + startRange.length;
            targetRange.length = [text length] - targetRange.location;
            
            NSRange endRange = [text rangeOfString:end options:0 range:targetRange];
            
            if (endRange.location != NSNotFound)
            {
                
                targetRange.length = endRange.location - targetRange.location;
                NSString *addedTect = [text substringWithRange:targetRange];
                if (addedTect == nil) {
                    //We had an error, so we're going to exit now.
                    return 0;
                }
                [strings addObject: addedTect];
                
                NSRange restOfString;
                
                restOfString.location = endRange.location + endRange.length;
                restOfString.length = [text length] - restOfString.location;
                
                startRange = [text rangeOfString:start options:0 range:restOfString];
                
            }
            else
            {
                break;
            }
            
        }
        else
        {
            break;
        }
        
    }
    //    NSLog(@"%@",strings);
    return strings;
    
}

@end
