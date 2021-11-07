import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "Localized string with key \(self)")
    }
    
}
