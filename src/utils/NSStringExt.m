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

#include "NSStringExt.h"

@implementation NSString (SonatinaTagExtensions)

- (id)initWith4CC:(uint32_t)fourcc
{
    char str[5];

    /* Unpack the fourcc into the string */
    str[0] = (char)(fourcc >> 24);
    str[1] = (char)(fourcc >> 16);
    str[2] = (char)(fourcc >> 8);
    str[3] = (char)fourcc;
    str[4] = '\0';

    return [self initWithUTF8String:str];
}

+ (id)stringWith4CC:(uint32_t)fourcc
{
    char str[5];

    /* Unpack the fourcc into the string */
    str[0] = (char)(fourcc >> 24);
    str[1] = (char)(fourcc >> 16);
    str[2] = (char)(fourcc >> 8);
    str[3] = (char)fourcc;
    str[4] = '\0';

    return [NSString stringWithUTF8String:str];
}

@end /* @implementation NSString (SonatinaTagExtensions) */
