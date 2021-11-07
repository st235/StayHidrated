import Foundation
import SwiftUI

struct ProgressBar: View {
    
    var progress: Float
    
    var inactiveColor: Color
    var activeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(activeColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)

            Text(String(format: "%.0f %%", min(self.progress, 1.0) * 100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct ProgressBar_Preview: PreviewProvider {
    
    static var previews: some View {
        ProgressBar(progress: 0.55, inactiveColor: .gray, activeColor: .green)
            .frame(width: 150.0, height: 150.0)
    }
    
}
