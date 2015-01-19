//
//  PeripheralData.h
//  CoreBluetoothApp
//
//  Created by Aldrich Wingsiong on 2015-01-18.
//  Copyright (c) 2015 Aldrich Wingsiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralData : NSObject

@property (nonatomic, strong) CBMutableCharacteristic* transferCharacteristic;
@property (strong, nonatomic) NSData* dataToSend;

+(void) cbServiceWithName:(NSString*)serviceName andServiceUUID:(NSString *)serviceUUID;

@end
