//
//  File.swift
//  
//
//  Created by Duc apple  on 24/12/24.
//

import Foundation

public extension Date {
    var calendar: Calendar {
        return NSCalendar.current
    }

    var era: Int {
        return calendar.component(.era, from: self)
    }

    var quarter: Int {
        return calendar.component(.quarter, from: self)
    }

    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }

    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }

    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.year = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.month = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.day = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var weekday: Int {
        get {
            return calendar.component(.weekday, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: self)
            component.weekday = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.hour = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.minute = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            var component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
            component.second = newValue
            if let date = calendar.date(from: component) {
                self = date
            }
        }
    }

    var nanosecond: Int {
        get {
            return calendar.component(.nanosecond, from: self)
        }
        set {
            if let date = calendar.date(bySetting: .nanosecond, value: newValue, of: self) {
                self = date
            }
        }
    }

    var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1000000
        }
        set {
            let nanoseconds = newValue * 1000000
            if let date = calendar.date(bySetting: .nanosecond, value: nanoseconds, of: self) {
                self = date
            }
        }
    }

    var isInFuture: Bool {
        return self > Date()
    }

    var isInPast: Bool {
        return self < Date()
    }

    var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }

    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }

    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }

    var isInWeekday: Bool {
        return !calendar.isDateInWeekend(self)
    }


    var timeZone: TimeZone {
        return calendar.timeZone
    }

    var unixTimestamp: Double {
        return timeIntervalSince1970
    }

    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Double(milliseconds) / Double(1000)))
    }

    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    func getElapsedInterval() -> String {
        let componentsToNow = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())

        if componentsToNow.year! > 0 {
            return componentsToNow.year! == 1 ? "\(componentsToNow.year!) year ago" : "\(componentsToNow.year!) years ago"
        }

        if componentsToNow.month! > 0 {
            return componentsToNow.month! == 1 ? "\(componentsToNow.month!) month ago" : "\(componentsToNow.month!) months ago"
        }

        if componentsToNow.day! > 0 {
            return componentsToNow.day! == 1 ? "\(componentsToNow.day!) day ago" : "\(componentsToNow.day!) days ago"
        }

        if componentsToNow.hour! > 0 {
            return componentsToNow.hour! == 1 ? "\(componentsToNow.hour!) hour ago" : "\(componentsToNow.hour!) hours ago"
        }

        if componentsToNow.minute! > 0 {
            return componentsToNow.minute! == 1 ? "\(componentsToNow.minute!) minute ago" : "\(componentsToNow.minute!) minutes ago"
        }

        return "a moment ago"
    }

    var yesterDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }

    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var isAM: Bool {
       let dateFormatterPrint = DateFormatter()
       dateFormatterPrint.dateFormat = "a"
       let text = dateFormatterPrint.string(from: self)
       return text.uppercased().elementsEqual("AM")
    }

    var startOfDay: Date {
        let components = Calendar.current.dateComponents([.year,.day,.month], from: self)
        return Calendar.current.date(from: components)!
    }

    var endOfDay: Date {
        let startOfDay = self.tomorrow.startOfDay
        return startOfDay.addingTimeInterval(-1)
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getDateFullDes() -> String {
        return self.string(format: "EEE, MMMM dd, yyyy")
    }
    
    func dateToString() -> String {
         return self.string(format: "dd MMM, yyyy")
     }
    
    func timeToString() -> String {
        return String(format: "%02d:%02d", self.hour, self.minute)
    }
    
    func dateInformation() -> String {
        return self.string(format: "dd/MM/yyyy - hh:mm a")
    }
    
    func componentsFromDate(_ date: Date, components: [Calendar.Component] = [.day, .month, .year, .hour, .minute, .second, .weekday]) -> DateComponents {
        return self.calendar.dateComponents(Set(components), from: self, to: date)
    }
    
    func fullDescription() -> String {
        return String(format: "%02d:%02d %02d/%02d/%04d", self.hour, self.minute, self.day, self.month, self.year)
    }
    
    var sAngle: Double {
        get {
            let s_angle = Double(self.second) / 60 * 360
            return s_angle
        }
    }
    
    var mAngle: Double {
        get {
            let m_angle = (Double(minute) + (sAngle / 360)) / 60 * 360
            return m_angle
        }
    }
    
    var hAngle: Double {
        get {
            let h_angle = (Double(hour) + (mAngle / 360)) / 12 * 360
            return h_angle
        }
    }
}

extension Double {
    func toRadian() -> Double {
        return self * .pi / 180
    }
}
