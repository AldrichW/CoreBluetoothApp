//
//  PeripheralViewController.m
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-14.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import "PeripheralViewController.h"

@interface PeripheralViewController ()
@property (weak, nonatomic) IBOutlet UILabel *manufacturerDataValue;
@property (weak, nonatomic) IBOutlet UILabel *bluetoothStatusText;

@end

@implementation PeripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(!_myPeripheralManager){
        _myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    NSString *manufacturerData = @"88888888";
    NSString *manufacturerDataKey = @"kCBAdvDataManufacturerData";
    if (!_advertisementData){
        
        _advertisementData = [NSDictionary dictionaryWithObject: manufacturerData forKey:manufacturerDataKey];
    }
    else{
        [_advertisementData setValue:manufacturerData forKey:manufacturerDataKey];
    }
    //Set ADvertising Packets
    [_manufacturerDataValue setText:@"88888888"];
    
    //Set Services
    CBUUID *serviceUUID = [CBUUID UUIDWithString:@"69A28C31-6B9D-4EBF-BC22-40A7A47ED58E"];
    CBMutableService *mockService = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    
    //Set Characteristics
    CBUUID *characteristicReadUUID = [CBUUID UUIDWithString:@"0036D779-E5EB-455B-9FF2-3B5775BF6637"];
    NSData *readableData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"../Data/sample_data.txt"]];
    CBMutableCharacteristic *mockReadCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicReadUUID properties:CBCharacteristicPropertyRead value:readableData permissions:CBAttributePermissionsReadable];
    
    CBUUID *characteristicWriteUUID = [CBUUID UUIDWithString:@"A6ABAB2B-BE3D-4414-9A5C-C3F0200D39DE"];
    CBMutableCharacteristic *mockWriteCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicWriteUUID properties:CBCharacteristicPropertyWrite value:nil permissions:CBAttributePermissionsWriteable];
    
    [mockService setCharacteristics:@[mockReadCharacteristic, mockWriteCharacteristic]];
    
    [_myPeripheralManager addService:mockService];
    
    [_myPeripheralManager startAdvertising:_advertisementData];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        NSLog(@"Success: Peripheral BLE is enabled and available to use");
        [_bluetoothStatusText setText:@"Active"];
        [_bluetoothStatusText setTextColor:[UIColor greenColor]];
        
        [_myPeripheralManager startAdvertising:_advertisementData];
    }
    else if(peripheral.state == CBPeripheralManagerStatePoweredOff){
        NSLog(@"Error: Peripheral BLE is currently powered off");
        UIAlertView *bluetoothOffAlert = [[UIAlertView alloc] initWithTitle:@"Bluetooth was Disabled" message:@"Bluetooth must be on to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [_bluetoothStatusText setText:@"InActive"];
        [_bluetoothStatusText setTextColor:[UIColor redColor]];
        
        [bluetoothOffAlert show];
    }
    
}

-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if(error == nil){
        NSLog(@"Peripheral is successfully advertising.");
    }
    
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (error != nil){
        NSLog(@"Error, could not add service. %@", [error localizedDescription]);
    }
    else{
        NSLog(@"Success! Service was added");
    }
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
