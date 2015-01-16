//
//  PeripheralManagementViewController.h
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-15.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralManagementViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic) BOOL connectionStatus;
@property (strong, nonatomic) CBCentralManager *myCentralManager;
@property (strong, nonatomic) CBPeripheral *connectedPeripheral;
@property (weak, nonatomic) IBOutlet UILabel *connectionStatusText;

@end
