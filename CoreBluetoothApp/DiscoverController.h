//
//  DiscoverController.h
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-13.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface DiscoverController : UITableViewController <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager* myCentralManager;
@property (nonatomic, strong) CBPeripheral* myRemotePeripheral;

@end
