import Foundation

class HydrationMillilitresDataRepository {
    
    private var rawValue = 0.0
    
    var todayValue: Double {
        return rawValue
    }
    
    func updateValue(diff: Double) {
        rawValue += diff
    }
    
    func getHistoricData() {
        
    }
    
}
