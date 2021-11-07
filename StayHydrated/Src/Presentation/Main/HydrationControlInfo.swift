import Foundation
import SwiftUI

struct HydrationControlInfo: Hashable {
    
    public let value: HydrationValue
    public let text: String
    public let color: Color
    public let image: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(text)
        hasher.combine(color)
        hasher.combine(image)
    }
    
}
