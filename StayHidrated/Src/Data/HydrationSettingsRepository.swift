import Foundation

class HydrationSettingsRepository {
    
    private static let UnitsKey = "defaults.units.setting"
    
    private let userDefaults = UserDefaults.standard
    
    var hydrationUnits: UnitType {
        get {
            let selectedValue = userDefaults.integer(forKey: HydrationSettingsRepository.UnitsKey)
            return UnitType.allCases.first(where: { $0.rawValue == selectedValue }) ?? UnitType.milliliters
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: HydrationSettingsRepository.UnitsKey)
        }
    }
    
}
