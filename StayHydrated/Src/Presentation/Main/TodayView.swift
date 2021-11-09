import Foundation
import SwiftUI

struct TodayView: View {
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    var body: some View {
        let screenInfo = mainViewModel.screenInfo
        
        let selectionBunding = Binding(get: {
            screenInfo.availableUnits.first(where: {$0.isEnabled})?.rawValue ?? .milliliters
        }, set: {
            mainViewModel.onNewUnitsPicked(newUnit: $0)
        })
        
        VStack {
            Text("main_screen.title".localized)
                .font(.title.weight(.bold))
                .foregroundColor(.Dynamic.TextPrimary)
                .padding(.trailing, 16)
                .padding(.leading, 16)
                .padding(.top, 32)
                .padding(.bottom, 16)
            
            Picker("", selection: selectionBunding) {
                ForEach(screenInfo.availableUnits, id: \.self) { unitToggleInfo in
                    Text(unitToggleInfo.text)
                        .foregroundColor(.Dynamic.TextPrimary)
                        .font(.headline)
                        .tag(unitToggleInfo.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.top, 8)
            .padding(.bottom, 8)
            
            let gridItems = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            ProgressBar(
                progress: screenInfo.todayProgress,
                inactiveColor: .Static.Grey800,
                activeColor: .Static.DeepOrange300
            )
                .frame(height: 200, alignment: .center)
                .padding(32)
            
            Text(String(format: "%@ / %@", screenInfo.todayValue, screenInfo.recommendedValue))
                .foregroundColor(.Dynamic.TextPrimary)
                .font(.headline.weight(.bold))
            
            LazyVGrid(
                columns: gridItems
            ) {
                ForEach(screenInfo.controlButtonsInfo, id: \.self) { controlButtonInfo in
                    ImagedButton(text: controlButtonInfo.text, image: controlButtonInfo.image) { [controlButtonInfo] in
                        mainViewModel.onAddWaterClicked(value: controlButtonInfo.value)
                    }
                    .foregroundColor(.Dynamic.TextPrimary)
                    .font(.headline.weight(.bold))
                    .padding(16)
                    .foregroundColor(.Dynamic.TextPrimary)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundColor(controlButtonInfo.color))
                    .padding(4)
                }
            }
            .padding(.top, 16)
            .padding(.trailing, 16)
            .padding(.leading, 16)
            .padding(.bottom, 8)
            
            Spacer()
        }
        .onAppear {
            mainViewModel.onStart()
        }
    }
    
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            TodayView()
                .environmentObject(MainViewModel())
                .preferredColorScheme(scheme)
        }
    }
}

