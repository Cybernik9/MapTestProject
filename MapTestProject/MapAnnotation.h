//
//  MapAnnotation.h
//  MapTestProject
//
//  Created by Yurii Huber on 03.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
