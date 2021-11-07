extension UnitType {
    
    var text: String {
        switch(self) {
        case .milliliters: return "units.milliliters".localized
        case .cups: return "units.cups".localized
        case .pints: return "units.pints".localized
        case .ounces: return "units.ounces".localized
        }
    }
    
}
