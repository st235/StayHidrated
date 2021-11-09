import Foundation
import CoreData

class HydrationRecordsManager {
    
    private var isStarted: Bool = false
    private let lock = NSLock()
    
    private var context: NSManagedObjectContext? {
        get {
            return persistentContainer.viewContext
        }
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        NSPersistentContainer(name: "HydrationRecordDataModel")
    }()
    
    init() {
        persistentContainer.loadPersistentStores(completionHandler: { [weak self] _, error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                fatalError("Unresolved error: \(error)")
            } else {
                self.lock.lock()
                self.isStarted = true
                self.lock.unlock()
            }
        })
    }
    
    func saveHydrationRecord(historyRecord: HistoryHydrationRecord) {
        lock.lock()
        defer { lock.unlock() }
        
        guard let context = context else {
            return
        }
        
        let record = HydrationRecord(context: context)
        record.hydrationValue = historyRecord.valueInMillilitres
        record.timestamp = historyRecord.timestamp
        
        do {
            try context.save()
        } catch {
            print("Error has happened \(error)")
        }
    }
    
    func findHydrationRecordsBetween(startDate: Date?, finishDate: Date?) async -> [HistoryHydrationRecord] {
        lock.lock()
        defer { lock.unlock() }
        
        guard let context = context else {
            return []
        }
        
        var predicate: NSPredicate? = nil
        
        if let startDate = startDate, let finishDate = finishDate {
            predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                NSPredicate(format: "timestamp >= %@", argumentArray: [startDate]),
                NSPredicate(format: "timestamp < %@", argumentArray: [finishDate])
            ])
        } else if let startDate = startDate {
            predicate = NSPredicate(format: "timestamp >= %@", argumentArray: [startDate])
        } else if let finishDate = finishDate {
            predicate = NSPredicate(format: "timestamp < %@", argumentArray: [finishDate])
        }
        
        guard let predicate = predicate else {
            return []
        }

        let fetchRequest = HydrationRecord.fetchRequest()
        fetchRequest.predicate = predicate
        
        return await withCheckedContinuation({ continuation in
            context.perform {
                do {
                    let rawRecords = try fetchRequest.execute()
                    let records = rawRecords.map({ record in
                        HistoryHydrationRecord(valueInMillilitres: record.hydrationValue, timestamp: record.timestamp ?? Date())
                    })
                    continuation.resume(returning: records)
                } catch {
                    continuation.resume(returning: [])
                }
            }
        })
    }
    
}
