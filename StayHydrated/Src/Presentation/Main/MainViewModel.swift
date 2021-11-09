import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    private let hydrationInteractor = HydrationInteractor(hydrationSettingsRepository: SettingsRepository(), hydrationDataRepository: HydrationHistoryDataRepository())
        
    @Published var screenInfo: ScreenInfo = ScreenInfo.Empty
    
    @Published var charDataInfo: [Double] = []
    
    func onStart() {
        Task(priority: .background) { [weak self] in
            await self?.loadScreenInfo()
            
            let chartData = await hydrationInteractor.fetchHistory()
            
            //todo(st235): not sure how to complete the api in terms async/await
            DispatchQueue.main.async { [weak self] in
                self?.charDataInfo = chartData
            }
        }
    }
    
    func onNewUnitsPicked(newUnit: UnitType) {
        Task(priority: .background) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.hydrationInteractor.selectedUnit = newUnit
            await self.loadScreenInfo()
        }
    }
    
    func onAddWaterClicked(value: HydrationValue) {
        Task(priority: .background) { [weak self] in
            guard let self = self else {
                return
            }
            
            await self.hydrationInteractor.updateProgress(diff: value.value, unit: value.unitType)
            await self.loadScreenInfo()
        }
    }
    
    private func loadScreenInfo() async {
        let value = await hydrationInteractor.todayValue
        let recommendedValue = await hydrationInteractor.recommendedValue
        let progress = await hydrationInteractor.todayProgress
        
        let levels = hydrationInteractor.availableLevels
        let units = hydrationInteractor.availableUnits
        
        let selectedUnit = hydrationInteractor.selectedUnit
        
        let screenInfo = ScreenInfo(todayProgress: Float(progress),
                          todayValue: value.text,
                          recommendedValue: recommendedValue.text,
                          availableUnits: units.map { UnitToggleInfo(rawValue: $0, isEnabled: selectedUnit == $0, text: $0.text) },
                          controlButtonsInfo: levels.map {
            return HydrationControlInfo(value: $0.value, text: $0.value.text, color: $0.color, image: $0.image)
        })
        
        //todo(st235): not sure how to complete the api in terms async/await
        DispatchQueue.main.async {
            self.screenInfo = screenInfo
        }
    }
    
}
