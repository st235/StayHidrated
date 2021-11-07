import Foundation
import SwiftUI

struct HydrationLevelDescription: Hashable {
    
    let value: HydrationValue
    let color: Color
    let image: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(color)
        hasher.combine(image)
    }
    
}
