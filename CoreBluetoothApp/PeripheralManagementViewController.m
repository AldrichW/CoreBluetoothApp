//
//  PeripheralManagementViewController.m
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-15.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import "PeripheralManagementViewController.h"

@interface PeripheralManagementViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bluetoothStatusText;

@end

@implementation PeripheralManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    //Bluetooth LE needs to be powered on and available for use
    if (central.state  == CBCentralManagerStatePoweredOn){
        NSLog(@"Success: Central Bluetooth LE is on and available for use.");
    }
    
    if (central.state == CBCentralManagerStatePoweredOff){
        //If less than this constant, all CB scanning has stopped and disconnected
        NSLog(@"Error: Central BLE is currently powered off");
        UIAlertView *bluetoothOffAlert = [[UIAlertView alloc] initWithTitle:@"Bluetooth was Disabled" message:@"Bluetooth must be on to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [_bluetoothStatusText setText:@"Inactive"];
        [_bluetoothStatusText setTextColor:[UIColor redColor]];
        
        [bluetoothOffAlert show];
    }
}

-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"Error: Peripheral was disconnected.");
    [_connectionStatusText setText:@"Disconnected"];
    [_connectionStatusText setTextColor:[UIColor redColor]];
    
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
