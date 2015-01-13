//
//  UIImage+BlankEdge.m
//  ImageBlankEdge
//
//  Created by Hale Chan on 1/13/15.
//
//

#import "UIImage+BlankEdge.h"

const ImageBlankEdge ImageBlankEdgeZero = {0, 0, 0, 0};

@implementation UIImage (BlankEdge)
- (ImageBlankEdge)blankEdge
{
    //Get pixels of image
    CGImageRef inputCGImage = [self CGImage];
    size_t width = CGImageGetWidth(inputCGImage);
    size_t height = CGImageGetHeight(inputCGImage);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    UInt32 * pixels;
    
    if (!(pixels = (UInt32 *) calloc(height * width, sizeof(UInt32)))) {
        return ImageBlankEdgeZero;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), inputCGImage);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    NSInteger top, left, right, bottom;
    top = left = right = bottom = 0;
    
    //left
    for (NSInteger i = 0; i < height; i++) {
        UInt32 oldValue = 0;
        NSInteger thisLineEdge = 0;
        
        for (NSInteger j=0; j<width; j++) {
            UInt32 color = *(pixels + width * i + j);
            if (0 == j) {
                oldValue = color;
                thisLineEdge = j;
            }
            if (color != oldValue) {
                break;
            }
            thisLineEdge = j;
        }
        if (0 == i) {
            left = thisLineEdge;
        }
        else if(left > thisLineEdge) {
            left = thisLineEdge;
        }
    }
    
    //right
    for (NSInteger i = 0; i < height; i++) {
        UInt32 oldValue = 0;
        size_t thisLineEdge = 0;
        
        for (NSInteger j=width-1; j>=0; j--) {
            UInt32 color = *(pixels + width * i + j);
            if (width-1 == j) {
                oldValue = color;
                thisLineEdge = j;
            }
            if (color != oldValue) {
                break;
            }
            thisLineEdge = j;
        }
        if (0 == i) {
            right = thisLineEdge;
        }
        else if(right < thisLineEdge) {
            right = thisLineEdge;
        }
    }

    //top
    for (NSInteger i=0; i<width; i++) {
        UInt32 oldValue = 0;
        BOOL breakThisLine = NO;
        NSInteger thisLineEdge = 0;
        for (NSInteger j=0; j<height; j++) {
            UInt32 color = *(pixels + j*width + i);
            if (0 == j) {
                oldValue = color;
                thisLineEdge = j;
            }
            if (color != oldValue) {
                if (!breakThisLine) {
                    breakThisLine = YES;
                }
                break;
            }
            thisLineEdge = j;
        }
        if (0 == i) {
            top = thisLineEdge;
        }
        else {
            if (top > thisLineEdge) {
                top = thisLineEdge;
            }
        }
    }
    
    //bottom
    size_t max = right;
    for (NSInteger i=left; i<max; i++) {
        UInt32 oldValue = 0;
        NSInteger thisLineEdge = 0;
        for (NSInteger j=height-1; j>=0; j--) {
            UInt32 color = *(pixels + j*width + i);
            if (height-1 == j) {
                oldValue = color;
                thisLineEdge = j;
            }
            if (color != oldValue) {
                break;
            }
            thisLineEdge = j;
        }
        if (0 == i) {
            bottom = thisLineEdge;
        }
        else {
            if (bottom < thisLineEdge) {
                bottom = thisLineEdge;
            }
        }
    }
    
    free(pixels);
    
    ImageBlankEdge edge = {top, left, width-1-right, height-1-bottom};
    return edge;
}
@end
