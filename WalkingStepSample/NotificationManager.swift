import Foundation
import UserNotifications

// オリジナル
// https://note.com/u_chanmaru/n/n831992bd2732


final class NotificationManager {

   // 権限リクエスト
   func requestPermission() {
       UNUserNotificationCenter.current()
           .requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
               print("Permission granted: \(granted)")
           }
   }

   // notificationの登録
    func sendNotification(title: String?, body: String?) {
       let content = UNMutableNotificationContent()
       content.title = title ?? "デフォルトタイトル"
       content.body = body ?? "デフォルト本文"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "com.pedometer.sample", content: content, trigger: trigger)

       UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
}
