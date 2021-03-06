/*
    SonatinaTag
    Copyright (C) 2010 Lawrence Sebald

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License version 2.1 as published by the Free Software Foundation.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
*/

#include "STTagID3v2TextFrame.h"

static NSStringEncoding encs[4] = {
    NSISOLatin1StringEncoding,
    NSUTF16StringEncoding,
    NSUTF16BigEndianStringEncoding,
    NSUTF8StringEncoding
};

@implementation STTagID3v2TextFrame
- (id)initWithType:(STTagID3v2_FrameCode)type size:(uint32_t)size
             flags:(uint16_t)flags data:(NSData *)data
{
    const uint8_t *bytes = [data bytes];

    if((self = [super initWithType:type size:size flags:flags data:data])) {
        /* Make sure the encoding is valid */
        if(bytes[0] > STTAGID3V2_ENCODING_UTF8) {
            [self release];
            return nil;
        }

        _encoding = bytes[0];
        _text = [[NSString alloc] initWithBytes:bytes + 1
                                         length:size - 1
                                       encoding:encs[_encoding]];
    }

    return self;
}

+ (id)frameWithType:(STTagID3v2_FrameCode)type size:(uint32_t)size
              flags:(uint16_t)flags data:(NSData *)data;
{
    return [[[self alloc] initWithType:type
                                  size:size
                                 flags:flags
                                  data:data] autorelease];
}

- (void)dealloc
{
    [_text release];
    [super dealloc];
}

- (uint8_t)encoding
{
    return _encoding;
}

- (NSString *)text
{
    NSCharacterSet *s =
        [NSCharacterSet characterSetWithCharactersInString:@"\0"];
    return [_text stringByTrimmingCharactersInSet:s];
}

@end /* @implementation STTagID3v2TextFrame */
