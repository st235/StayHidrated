import Foundation

protocol UnitConverter {
    
    var value: Double { get }
    
    func toMilliliters() -> UnitConverter
    
    func toCups() -> UnitConverter
    
    func toPints() -> UnitConverter
    
    func toOunces() -> UnitConverter
    
}

struct WaterUnits {
    
    fileprivate static let MlInCup = 250.0
    fileprivate static let MlInPint = 568.261
    fileprivate static let MlInOunces = 28.4131
    
    public struct Milliliters: UnitConverter {
        
        let value: Double
        
        init(_ value: Double) {
            self.value = value
        }
        
        func toMilliliters() -> UnitConverter {
            return self
        }
        
        func toCups() -> UnitConverter {
            return WaterUnits.Cups(value / WaterUnits.MlInCup)
        }
        
        func toPints() -> UnitConverter {
            return WaterUnits.Pints(value / WaterUnits.MlInPint)
        }
        
        func toOunces() -> UnitConverter {
            return WaterUnits.Ounces(value / WaterUnits.MlInOunces)
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.value == rhs.value
        }
        
    }
    
    public struct Cups: UnitConverter {
        
        let value: Double
        
        init(_ value: Double) {
            self.value = value
        }
        
        func toMilliliters() -> UnitConverter {
            return WaterUnits.Milliliters(value * WaterUnits.MlInCup)
        }
        
        func toCups() -> UnitConverter {
            return self
        }
        
        func toPints() -> UnitConverter {
            return toMilliliters().toPints()
        }
        
        func toOunces() -> UnitConverter {
            return toMilliliters().toOunces()
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.value == rhs.value
        }
        
    }
    
    public struct Pints: UnitConverter {
        
        let value: Double
        
        init(_ value: Double) {
            self.value = value
        }
        
        func toMilliliters() -> UnitConverter {
            return WaterUnits.Milliliters(value * WaterUnits.MlInPint)
        }
        
        func toCups() -> UnitConverter {
            return self
        }
        
        func toPints() -> UnitConverter {
            return toMilliliters().toPints()
        }
        
        func toOunces() -> UnitConverter {
            return toMilliliters().toOunces()
        }
        
    }
    
    public struct Ounces: UnitConverter {
        
        let value: Double
        
        init(_ value: Double) {
            self.value = value
        }
       
        func toMilliliters() -> UnitConverter {
            return WaterUnits.Milliliters(value * WaterUnits.MlInOunces)
        }
        
        func toCups() -> UnitConverter {
            return self
        }
        
        func toPints() -> UnitConverter {
            return toMilliliters().toPints()
        }
        
        func toOunces() -> UnitConverter {
            return toMilliliters().toOunces()
        }
        
    }
    
}
