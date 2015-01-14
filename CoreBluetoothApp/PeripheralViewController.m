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
    [_manufacturerDataValue setText:@"88888888"];
    [_myPeripheralManager startAdvertising:_advertisementData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        NSLog(@"Success: BLE is enabled and available to use");
        [_myPeripheralManager startAdvertising:_advertisementData];
    }
    else if(peripheral.state == CBPeripheralManagerStatePoweredOff){
        NSLog(@"Error: BLE is currently powered off");
    }
    
}

-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if(error == nil){
        NSLog(@"Peripheral is successfully advertising.");
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
