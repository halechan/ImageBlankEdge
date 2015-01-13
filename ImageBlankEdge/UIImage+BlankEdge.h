//
//  UIImage+BlankEdge.h
//  ImageBlankEdge
//
//  Created by Hale Chan on 1/13/15.
//
//

#import <UIKit/UIKit.h>

typedef struct ImageBlankEdge_ {
    int top;
    int left;
    int right;
    int bottom;
}ImageBlankEdge;

extern const ImageBlankEdge ImageBlankEdgeZero;

@interface UIImage (BlankEdge)

/**
 *  Blank edge area of the Image.
 *
 *  @return a ImageBlankEdge struct.
 */
- (ImageBlankEdge)blankEdge;
@end
