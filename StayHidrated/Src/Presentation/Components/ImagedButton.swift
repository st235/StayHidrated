import Foundation
import SwiftUI

struct ImagedButton: View {
    
    let text: String
    let image: String?
    let action: (() -> Void)?

    
    var body: some View {
        HStack {
            if let image = image {
                Image(image)
                    .renderingMode(.template)
            }
            
            Button(text) {
                action?()
            }
        }
    }
    
}

struct ImagedButton_Preview: PreviewProvider {
    
    static var previews: some View {
        ImagedButton(text: "Hello world", image: nil, action: {
            print("on click")
        })
    }
    
}
