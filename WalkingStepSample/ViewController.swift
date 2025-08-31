//
//  ViewController.swift
//  WalkingStepSample
//
//  Created by Tasuku Maeda on 2025/08/31.
//

import UIKit

// 参考
// https://i-app-tec.com/ios/pedometer.html

class ViewController: UIViewController {

    @IBOutlet private weak var logLabel: UILabel!
    @IBOutlet private weak var statusLabal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabal.text = ""
        NotificationManager().requestPermission()
        PedometerManager.shared.delegate = self
    }

    @IBAction func didTapStartButton() {
        print("start")
        statusLabal.text = "測定開始しました"
        PedometerManager.shared.startUpdates()
    }
    
    @IBAction func didTapStopButton() {
        print("stop")
        PedometerManager.shared.stopUpdates()
        statusLabal.text = "測定終了しました"
    }
    
    func updateLogLabelText(text: String?) {
        logLabel.text = text
    }
}

extension ViewController: PedometerManagerDelegate {
    func pedometerManager(_ manager: PedometerManager, didUpdateNumberOfSteps steps: NSNumber) {
        let logText = "歩数: \(steps)"
        print("dbg steps \(steps)")
        NotificationManager().sendNotification(title: "歩数更新", body: logText)
        Task { @MainActor in
            self.updateLogLabelText(text: logText)
        }
    }
}
