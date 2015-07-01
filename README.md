# ConiferXML
The Easiest XML Parser for iOS

##About ConiferXML
ConiferXMl is a simple solution that generates an ```NSMutableArray``` of ```NSDictionary``` objects that contain properties obtained from an XML file at a certain URL. As an example, check out this simple XML file from <a href="http://www.coniferapps.com/chf/apples.xml">Our Website</a>. Parsing this with ConiferXML would return an array that contains 13 dictionaries. Each one of these dictionaries has the properties of an apple tied to various keys, which you can then use to create objects or access the information. For example, accessing the information stored at the key of "name" for object 1 in the array would return "Williams Pride". <br>

##Making it work
Simply import ConiferXML.h and ConiferXML.m into your project and add ```#import "ConiferXML.h"``` to the Objective-C file in which you wish to use ConiferXML to get started. Also, to make ConiferXML work, you will need to know the main container tag of each object returned in the XML file. For example, in the file above, each apple is contained between the tags ```<variety>``` and ```</variety>``` so the object tag is (without quotes) "variety".
###The Code
First create a parser object that will manage all the methods. <br>
```ConiferXML *parser = [[ConiferXML alloc] init];``` <br><br>
To parse an XML file stored at a specific URL just call the following method and input your object tag and URL in ```NSString``` format: <br>
```NSMutableArray *objects = [parser parseXMLWithURL:YOUR URL STRING objectTag:YOUR OBJECT TAG];``` <br><br>
To access this information, check out the example below. This parses the XML file from the example above, and gets the name of the 12th apple in the array, which is printed out to the console: <br>
``` 
    NSMutableArray *apples = [[NSMutableArray alloc] init];
    
    ConiferXML *parser = [[ConiferXML alloc] init];
    
    apples = [parser parseXMLWithURL:@"http://www.coniferapps.com/chf/apples.xml" objectTag:@"variety"];
    
    NSDictionary *apple = [apples objectAtIndex:11];
    
    NSLog(@"%@",[apple objectForKey:@"name"]);
``` 
What's Next:
------
We'll soon be adding parsing support for local files.

