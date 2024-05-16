import SwiftUI

struct CellView: View {
    var symbol: Symbol?

    var body: some View {
        Text(symbol?.rawValue ?? "")
            .font(.largeTitle)
            .frame(width: 80, height: 80)
            .background(Color(.init(white: 1, alpha: 0.50)))
            .cornerRadius(10)
    }
}
