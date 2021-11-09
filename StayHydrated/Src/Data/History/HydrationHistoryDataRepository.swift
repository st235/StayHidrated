import Foundation

class HydrationHistoryDataRepository {
    
    private let hydrationRecordsManager = HydrationRecordsManager()
    
    func getTodayValue() async -> Double {
        return await hydrationRecordsManager.findHydrationRecordsBetween(startDate: Date.noon, finishDate: Date.tomorrow).map({ $0.valueInMillilitres }).reduce(0, +)
    }
    
    func updateValue(diff: Double) async {
        hydrationRecordsManager.saveHydrationRecord(historyRecord: HistoryHydrationRecord(valueInMillilitres: diff, timestamp: Date()))
    }
    
    func getHistoricData() async -> [HistoryHydrationRecord] {
        return await hydrationRecordsManager.findHydrationRecordsBetween(startDate: nil, finishDate: Date.noon)
    }
    
}
