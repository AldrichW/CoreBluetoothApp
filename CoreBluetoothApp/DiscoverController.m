//
//  DiscoverController.m
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-13.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import "DiscoverController.h"
#import "PeripheralManagementViewController.h"

@interface DiscoverController ()
@property (strong, atomic) NSMutableArray* peripherals;
@property (weak, nonatomic) IBOutlet UITableView *peripheralTable;
@property (nonatomic) BOOL connected;

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    _peripherals = [NSMutableArray array];
    if (!_myCentralManager){
        _myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    }
    _connected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //Required method implementation if using the CBCentralManagerDelegate Protocol
    
    //Bluetooth LE needs to be powered on and available for use
    if (central.state  == CBCentralManagerStatePoweredOn){
        NSLog(@"Success: Central Bluetooth LE is on and available for use.");
        [_myCentralManager scanForPeripheralsWithServices:nil options:nil];
        NSLog(@"Scanning has started");
    }
    
    if (central.state == CBCentralManagerStatePoweredOff){
        //If less than this constant, all CB scanning has stopped and disconnected
        NSLog(@"Error: Central BLE is currently powered off");
        UIAlertView *bluetoothOffAlert = [[UIAlertView alloc] initWithTitle:@"Bluetooth was Disabled" message:@"Bluetooth must be on to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [bluetoothOffAlert show];
    }
}

- (void)centralManager:(CBCentralManager *)central

 didDiscoverPeripheral:(CBPeripheral *)peripheral

     advertisementData:(NSDictionary *)advertisementData

                  RSSI:(NSNumber *)RSSI {
    
    NSData *manufacturerField = [advertisementData valueForKey:@"kCBAdvDataManufacturerData"];
    NSString *manufacturerFieldString =  [[NSString alloc] initWithData:manufacturerField encoding:NSUnicodeStringEncoding];
    
    if(RSSI.integerValue>-50 && manufacturerFieldString != nil){
        [_peripherals addObject:peripheral];
        NSLog(@"Discovered new peripheral called: %@ with RSSI: %ld", peripheral.name, (long)RSSI.integerValue);
        [_peripheralTable reloadData];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
    NSLog(@"Device failed to connect to peripheral: %@", error);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_peripherals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"PeripheralCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if([[_peripherals objectAtIndex:indexPath.row] name] == nil){
        cell.textLabel.text = @"Unnamed Peripheral Device";
    }
    else{
        cell.textLabel.text = [[_peripherals objectAtIndex:indexPath.row] name];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_myCentralManager connectPeripheral:[_peripherals objectAtIndex:indexPath.row] options:nil];
    
    [self performSegueWithIdentifier:@"peripheralDetailsSegue" sender:self];
}

- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connection to peripheral was successful!");
    
    _connected = YES;
    
    [_myCentralManager stopScan];
    NSLog(@"Scan stopped");
    
    [peripheral setDelegate:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"peripheralDetailsSegue"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        PeripheralManagementViewController *controller = (PeripheralManagementViewController *)navController.topViewController;
        controller.connectionStatus = _connected;
        controller.connectedPeripheral = _myRemotePeripheral;
        if (_connected == YES){
            [controller.connectionStatusText setText:@"Connected"];
            [controller.connectionStatusText setTextColor:[UIColor greenColor]];
        }
        else{
            [controller.connectionStatusText setText:@"Disconnected"];
            [controller.connectionStatusText setTextColor:[UIColor redColor]];
        }
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
