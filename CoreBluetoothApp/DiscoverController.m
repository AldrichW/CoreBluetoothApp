//
//  DiscoverController.m
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-13.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import "DiscoverController.h"

@interface DiscoverController ()

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_myCentralManager){
        _myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    
    [_myCentralManager scanForPeripheralsWithServices:nil options:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //Required method implementation if using the CBCentralManagerDelegate Protocol
    
    //Bluetooth LE needs to be powered on and available for use
    if (central.state  == CBCentralManagerStatePoweredOff){
        NSLog(@"Success: Bluetooth LE is on and available for use.");
    }
    
    if (central.state < CBCentralManagerStatePoweredOn){
        //If less than this constant, all CB scanning has stopped and disconnected
        NSLog(@"Error: Bluetooth LE is unavailable.");
    }
}

- (void)centralManager:(CBCentralManager *)central

 didDiscoverPeripheral:(CBPeripheral *)peripheral

     advertisementData:(NSDictionary *)advertisementData

                  RSSI:(NSNumber *)RSSI {
    
    
    
    NSLog(@"Discovered %@", peripheral.name);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
