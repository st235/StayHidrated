import Foundation

struct HydrationValue: Hashable {
    
    public let value: Double
    public let unitType: UnitType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(unitType)
    }
    
}

extension HydrationValue {
    
    func changeUnitType(newUnitType: UnitType) -> HydrationValue {
        let oldValueConverter = unitType.toUnitConverter(rawValue: value)
        
        var newUnitsConverter: UnitConverter
        switch(newUnitType) {
        case .milliliters:
            newUnitsConverter = oldValueConverter.toMilliliters()
        case .cups:
            newUnitsConverter = oldValueConverter.toCups()
        case .pints:
            newUnitsConverter = oldValueConverter.toPints()
        case .ounces:
            newUnitsConverter = oldValueConverter.toOunces()
        }
        
        return HydrationValue(value: newUnitsConverter.value, unitType: newUnitsConverter.unitType)
    }
    
}
