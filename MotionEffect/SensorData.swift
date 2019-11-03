//
//  SensorData.swift
//  MotionEffect
//
//  Created by Sai Raghu Varma Kallepalli on 2/11/19.
//  Copyright © 2019 Training. All rights reserved.
//

import Foundation

class SensorData {
    var lat: Double
    var long: Double
    var rf: Int
    var speed: Double
    var motionLevel: Int
    var outTemp: Double
    var inTemp: Double
    var light: Bool
    var objectDistance: Double
    
    init() {
        lat = -37
        long = 144
        rf = 987654321000
        speed = 50
        motionLevel = 4
        outTemp = 33
        inTemp = 25
        light = false
        objectDistance = 300
    }
    
}
