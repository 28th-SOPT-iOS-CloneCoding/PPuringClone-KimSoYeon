//
//  StopWatch.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/15.
//

import UIKit

class StopWatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
