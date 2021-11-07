import Foundation

extension HydrationValue {
    
    var text: String {
        switch(unitType) {
        case .milliliters: return printMilliliters(value)
        case .cups: return printCups(value)
        case .pints: return printPints(value)
        case .ounces: return printOunces(value)
        }
    }
    
    private func printMilliliters(_ value: Double) -> String {
        return String(format: "%.0f %@",
                      value,
                      "units.milliliters".localized)
    }
    
    private func printCups(_ value: Double) -> String {
        return String(format: "%.1f %@",
                      value,
                      "units.cups".localized)
    }
    
    private func printPints(_ value: Double) -> String {
        return String(format: "%.2f %@",
                      value,
                      "units.pints".localized)
    }
    
    private func printOunces(_ value: Double) -> String {
        return String(format: "%.1f %@",
                      value,
                      "units.ounces".localized)
    }
    
}


