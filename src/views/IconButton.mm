/*
 *  Copyright (C) 2015 Savoir-faire Linux Inc.
 *  Author: Alexandre Lision <alexandre.lision@savoirfairelinux.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA.
 */

#import "IconButton.h"

#import "NSColor+RingTheme.h"

@implementation IconButton

-(void) awakeFromNib {
    if (!self.bgColor) {
        self.bgColor = [NSColor ringBlue];
    }

    if (!self.cornerRadius) {
        self.cornerRadius = @(NSWidth(self.frame) / 2);
    }

    if (self.imageInsets == 0)
        self.imageInsets = 5.0f;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    NSColor* backgroundColor6;
    NSColor* backgroundStrokeColor5;

    if (self.mouseDown || self.state == NSOnState) {
        if (self.highlightColor) {
            backgroundColor6 = self.highlightColor;
            backgroundStrokeColor5 = [self.highlightColor darkenColorByValue:0.1];
        } else {
            backgroundColor6 = [self.bgColor darkenColorByValue:0.3];
            backgroundStrokeColor5 = [self.bgColor darkenColorByValue:0.4];
        }

    } else {
        backgroundColor6 = self.bgColor;
        backgroundStrokeColor5 = [self.bgColor darkenColorByValue:0.1];
    }

    //// Subframes
    NSRect group = NSMakeRect(NSMinX(dirtyRect) + floor(NSWidth(dirtyRect) * 0.03333) + 0.5, NSMinY(dirtyRect) + floor(NSHeight(dirtyRect) * 0.03333) + 0.5, floor(NSWidth(dirtyRect) * 0.96667) - floor(NSWidth(dirtyRect) * 0.03333), floor(NSHeight(dirtyRect) * 0.96667) - floor(NSHeight(dirtyRect) * 0.03333));

    //// Group
    {
        //// Oval Drawing
        NSBezierPath* ovalPath = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(NSMinX(group) + floor(NSWidth(group) * 0.00000 + 0.5), NSMinY(group) + floor(NSHeight(group) * 0.00000 + 0.5), floor(NSWidth(group) * 1.00000 + 0.5) - floor(NSWidth(group) * 0.00000 + 0.5), floor(NSHeight(group) * 1.00000 + 0.5) - floor(NSHeight(group) * 0.00000 + 0.5)) xRadius:[self.cornerRadius floatValue] yRadius:[self.cornerRadius floatValue]];

        [backgroundColor6 setFill];
        [ovalPath fill];
        [backgroundStrokeColor5 setStroke];
        [ovalPath setLineWidth: 0.5];
        [ovalPath stroke];

        [NSGraphicsContext saveGraphicsState];

        NSBezierPath *path = [NSBezierPath bezierPathWithRect:dirtyRect];
        [path addClip];

        [self setImagePosition:NSImageOnly];
        auto rect2 = NSInsetRect(dirtyRect, self.imageInsets, self.imageInsets);


        [[NSColor image:self.image tintedWithColor:[NSColor whiteColor]]
                drawInRect:rect2
                 fromRect:NSZeroRect
                operation:NSCompositeSourceOver
                 fraction:1.0
                respectFlipped:YES
                         hints:nil];

        [NSGraphicsContext restoreGraphicsState];
    }
}

-(void)mouseDown:(NSEvent *)theEvent
{
    self.mouseDown = TRUE;
    [self setNeedsDisplay:YES];

    [super mouseDown:theEvent];

    self.mouseDown = FALSE;
    [self setNeedsDisplay:YES];
}

@end