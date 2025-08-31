//
//  Untitled.swift
//  WalkingStepSample
//
//  Created by Tasuku Maeda on 2025/08/31.
//

import UIKit
import CoreMotion

protocol PedometerManagerDelegate: AnyObject {
    func pedometerManager(_ manager: PedometerManager, didUpdateNumberOfSteps steps: NSNumber)
}

class PedometerManager {
    
    private var pedometer: CMPedometer?
    weak var delegate: PedometerManagerDelegate?
    var numberOfSteps: NSNumber = 0
    
    static var shared = PedometerManager()
    private init() {
        
    }
    
    func startUpdates() {
        if (pedometer == nil) {
            pedometer = CMPedometer()
        } else {
            print("dbg already started")
            return
        }

        if (CMPedometer.isStepCountingAvailable()) {
            print("dbg isStepCountingAvailable")
            numberOfSteps = 0
            
            pedometer?.startUpdates(from: Date()) { [weak self] (data, error) in
                print("dbg update!")
                guard let self else {
                    return
                }
                if (error != nil) {
                    print("dbg \(error!.localizedDescription)")
                    return
                }
                guard let data else {
                    print("dbg data is nil")
                    return
                }
                let steps = data.numberOfSteps
                numberOfSteps = steps
                self.delegate?.pedometerManager(self, didUpdateNumberOfSteps: steps)
            }
        }
    }
    
    func stopUpdates() {
        if (pedometer == nil) {
            return
        }
        
        pedometer?.stopUpdates()
        pedometer = nil
    }
}
