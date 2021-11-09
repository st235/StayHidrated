import Foundation
import SwiftUI
import SwiftUICharts

struct HistoricView: View {
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    var body: some View {
        VStack {
            Text("history.title".localized)
                .font(.title.weight(.bold))
                .foregroundColor(.Dynamic.TextPrimary)
                .padding(.trailing, 16)
                .padding(.leading, 16)
                .padding(.top, 32)
                .padding(.bottom, 16)
            
            Spacer()
            
            LineView(data: mainViewModel.charDataInfo)
                .frame(height: 400)
            
            Spacer()
        }
        .onAppear {
            mainViewModel.onStart()
        }
    }
    
}

struct HistoricView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { scheme in
            HistoricView()
                .environmentObject(MainViewModel())
                .preferredColorScheme(scheme)
        }
    }
}

