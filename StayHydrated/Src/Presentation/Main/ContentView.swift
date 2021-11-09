import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("main.tab.today".localized, systemImage: "calendar")
                }
                .environmentObject(MainViewModel())
            
            HistoricView()
                .tabItem {
                    Label("main.tab.history".localized, systemImage: "clock")
                }
                .environmentObject(MainViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            ContentView()
                .environmentObject(MainViewModel())
                .preferredColorScheme(scheme)
        }
    }
}
