import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    
    private let hydrationInteractor = HydrationInteractor(hydrationSettingsRepository: HydrationSettingsRepository(), hydrationDataRepository: HydrationMillilitresDataRepository())
        
    @Published var screenInfo: ScreenInfo = ScreenInfo.Empty
    
    func onStart() {
        self.screenInfo = prepareScreenInfo()
    }
    
    func onNewUnitsPicked(newUnit: UnitType) {
        hydrationInteractor.selectedUnit = newUnit
        self.screenInfo = prepareScreenInfo()
    }
    
    func onAddWaterClicked(value: HydrationValue) {
        hydrationInteractor.updateProgress(diff: value.value, unit: value.unitType)
        self.screenInfo = prepareScreenInfo()
    }
    
    private func prepareScreenInfo() -> ScreenInfo {
        let value = hydrationInteractor.todayValue
        let recommendedValue = hydrationInteractor.recommendedValue
        let progress = hydrationInteractor.todayProgress
        
        let levels = hydrationInteractor.availableLevels
        let units = hydrationInteractor.availableUnits
        
        let selectedUnit = hydrationInteractor.selectedUnit
        
        return ScreenInfo(todayProgress: Float(progress),
                          todayValue: value.text,
                          recommendedValue: recommendedValue.text,
                          availableUnits: units.map { UnitToggleInfo(rawValue: $0, isEnabled: selectedUnit == $0, text: $0.text) },
                          controlButtonsInfo: levels.map {            
            return HydrationControlInfo(value: $0.value, text: $0.value.text, color: $0.color, image: $0.image)
        })
    }
    
}
