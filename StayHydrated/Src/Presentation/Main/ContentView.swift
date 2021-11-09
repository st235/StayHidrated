import SwiftUI
import SwiftUICharts

struct ContentView: View {
    
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("main.tab.today".localized, systemImage: "list.dash")
                }
                .environmentObject(MainViewModel())
            
            HistoricView()
                .tabItem {
                    Label("main.tab.history".localized, systemImage: "list.dash")
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
