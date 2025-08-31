//
//  ViewController.swift
//  WalkingStepSample
//
//  Created by Tasuku Maeda on 2025/08/31.
//

import UIKit
import CoreMotion

// 参考
// https://i-app-tec.com/ios/pedometer.html

class ViewController: UIViewController {

    @IBOutlet private weak var logLabel: UILabel!
    @IBOutlet private weak var statusLabal: UILabel!
    private var pedometer: CMPedometer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabal.text = ""
        NotificationManager().requestPermission()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapStartButton() {
        print("start")
        statusLabal.text = "測定開始しました"
        if (pedometer == nil) {
            pedometer = CMPedometer()
        } else {
            print("dbg already started")
            return
        }

        if (CMPedometer.isStepCountingAvailable()) {
            print("dbg isStepCountingAvailable")
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
                let logText = "歩数: \(steps)"
                print("dbg steps \(steps)")
                NotificationManager().sendNotification(title: "歩数更新", body: logText)
                Task { @MainActor in
                    self.updateLogLabelText(text: logText)
                }
            }
        }
    }
    
    @IBAction func didTapStopButton() {
        print("stop")
        if (pedometer == nil) {
            return
        }
        
        pedometer?.stopUpdates()
        pedometer = nil
        statusLabal.text = "測定終了しました"
    }
    
    func updateLogLabelText(text: String?) {
        logLabel.text = text
    }
}

