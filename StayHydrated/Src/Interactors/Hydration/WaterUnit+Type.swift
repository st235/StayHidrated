import Foundation

extension UnitConverter {
    
    var unitType: UnitType {
        switch(self) {
        case is WaterUnits.Milliliters: return .milliliters;
        case is WaterUnits.Pints: return .pints;
        case is WaterUnits.Cups: return.cups;
        case is WaterUnits.Ounces: return.ounces;
        default: return .milliliters;
        }
    }
    
    func toHydrationValue() -> HydrationValue {
        return HydrationValue(value: value, unitType: unitType)
    }
    
}

extension UnitType {
    
    func toUnitConverter(rawValue: Double) -> UnitConverter {
        switch (self) {
        case .milliliters: return WaterUnits.Milliliters(rawValue)
        case .cups: return WaterUnits.Cups(rawValue)
        case .pints: return WaterUnits.Pints(rawValue)
        case .ounces: return WaterUnits.Ounces(rawValue)
        }
    }
    
}
