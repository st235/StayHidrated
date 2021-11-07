import Foundation

struct ScreenInfo: Hashable {
    
    public static let Empty = ScreenInfo(todayProgress: Float(0), todayValue: "", recommendedValue: "", availableUnits: [], controlButtonsInfo: [])
    
    let todayProgress: Float
    let todayValue: String
    let recommendedValue: String
    
    let availableUnits: [UnitToggleInfo]
    let controlButtonsInfo: [HydrationControlInfo]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(todayValue)
        hasher.combine(todayProgress)
        hasher.combine(recommendedValue)
        hasher.combine(controlButtonsInfo)
        hasher.combine(availableUnits)
    }
    
}
