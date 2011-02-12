//
//  TotalMapViewController.h
//  ichurris
//
//  Created by Javier Dolcet on 2/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TotalMapViewController : UIViewController {
    MKMapView *mapaView;
    NSArray *towns;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapaView;
@property (nonatomic, retain) NSArray *towns;

@end