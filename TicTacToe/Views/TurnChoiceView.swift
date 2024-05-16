import SwiftUI

struct TurnChoiceView: View {
    let selectedSymbol: Symbol
    @Binding var isManualTurnSelection: Bool
    var onNext: () -> Void

    var body: some View {
        VStack {
            Text("Choose First Turn Mode")
                .font(.largeTitle)
            Button(action: {
                isManualTurnSelection = true
                onNext()
            }) {
                Text("Choose Manually")
                    .font(.title)
                    .padding()
                    .frame(width: 250, height:70)
                    .background(Color(.init(white: 1, alpha: 0.50)))
                    .cornerRadius(10)
                    .foregroundColor(.black)
            }
            .padding()
            Button(action: {
                isManualTurnSelection = false
                onNext()
            }) {
                Text("Random")
                    .font(.title)
                    .padding()
                    .frame(width: 250, height:70)
                    .background(Color(.init(white: 1, alpha: 0.50)))
                    .cornerRadius(10)
                    .foregroundColor(.black)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    .yellow,
                    Color.yellow,
                    Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
