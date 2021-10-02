//
//  NotificationService.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 02/10/21.
//

import Foundation
import UserNotifications

enum NotificationType: Int, Identifiable, CaseIterable {
    var id: Int { self.rawValue }
    
    case week1 = 1
    case week2 = 2
    case week3 = 3
    case month1 = 4
    case month2 = 5
    case month3 = 6
    
    var string: String {
        switch self {
        case .week1:
            return "1_week"
        case .week2:
            return "2_week"
        case .week3:
            return "3_week"
        case .month1:
            return "1_month"
        case .month2:
            return "2_month"
        case .month3:
            return "3_month"
        }
    }
    var duration: TimeInterval {
        switch self {
        case .week1:
            return 1.0 * 7.0 * 24.0 * 60.0 * 60.0
        case .week2:
            return 2.0 * 7.0 * 24.0 * 60.0 * 60.0
        case .week3:
            return 3.0 * 7.0 * 24.0 * 60.0 * 60.0
        case .month1:
            return 1.0 * 30.0 * 24.0 * 60.0 * 60.0
        case .month2:
            return 2.0 * 30.0 * 24.0 * 60.0 * 60.0
        case .month3:
            return 3.0 * 30.0 * 24.0 * 60.0 * 60.0
        }
    }
}

class NotificationService {
    private init() { }
    
    static let instance = NotificationService()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    func add(_ gratitudes: [GratitudeModel]) { for gratitude in gratitudes { add(gratitude) } }
    
    func add(_ gratitude: GratitudeModel) {
        guard SettingsService.instance.showNotifications else { return }
        let type = NotificationType.allCases.randomElement()!
        let content = UNMutableNotificationContent()
        content.title = "\("hey".localized()) \("what_now".localized())"
        content.body = "\(type.string.localized()) \("you_were_grateful_for".localized()) \(gratitude.text)"
        content.sound = .default
        
#if DEBUG
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
#else
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: type.duration, repeats: false)
#endif
        
        let request = UNNotificationRequest(identifier: gratitude.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func update(_ gratitude: GratitudeModel) {
        guard SettingsService.instance.showNotifications else { return }
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            if let _ = requests.first(where: { $0.identifier == gratitude.id }) {
                self.delete(gratitude)
                self.add(gratitude)
            }
        }
    }
    
    func delete(_ gratitude: GratitudeModel) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [gratitude.id])
    }
    
    func deleteAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}
