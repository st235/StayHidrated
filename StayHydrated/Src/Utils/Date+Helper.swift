import Foundation

extension Date {
    
    static var noon: Date {
        return Date().noon
    }
    
    static var yesterday: Date {
        return Date().yesterday
    }
    
    static var tomorrow:  Date {
        return Date().tomorrow
    }
        
    var noon: Date {
        let calendar = Calendar.current
        let date = Date()
        return calendar.startOfDay(for: date)
    }
    
    var yesterday: Date {
        let calendar = Calendar.current
        let date = noon
        return calendar.date(byAdding: .day, value: -1, to: date)!
    }
    
    var tomorrow: Date {
        let calendar = Calendar.current
        let date = noon
        return calendar.date(byAdding: .day, value: 1, to: date)!
    }
    
}
