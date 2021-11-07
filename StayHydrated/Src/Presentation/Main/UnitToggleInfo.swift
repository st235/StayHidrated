struct UnitToggleInfo: Hashable {
    
    let rawValue: UnitType
    let isEnabled: Bool
    let text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
        hasher.combine(text)
        hasher.combine(isEnabled)
    }
    
}

