//
//  PeripheralViewController.h
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-14.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface PeripheralViewController : UIViewController <CBPeripheralManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) CBPeripheralManager* myPeripheralManager;

@property (strong, atomic) NSDictionary* advertisementData;
@property (nonatomic, readwrite) NSInteger sendDataIndex;

@end
