
import SwiftUI

struct ButtonData {
    var id: String
    var type: ButtonType
    var gradient: LinearGradient
   
}
enum ButtonType {
    case Gradient
    case Outline
}
