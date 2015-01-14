//
//  PeripheralViewController.h
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-14.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface PeripheralViewController : UIViewController <CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager* myPeripheralManager;
@property (nonatomic, strong) CBMutableCharacteristic* transferCharacteristic;
@property (strong, nonatomic) NSData* dataToSend;
@property (strong, atomic) NSDictionary* advertisementData;
@property (nonatomic, readwrite) NSInteger sendDataIndex;

@end
