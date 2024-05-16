import SwiftUI

struct SelectedSymbolView: View {
    @Binding var selectedSymbol: Symbol?
    var onNext: () -> Void

    var body: some View {
        VStack {
            Text("Choose Your Symbol")
                .font(.largeTitle)
                .padding(.top, 40)
            
            VStack {
                Button(action: {
                    selectedSymbol = .X
                    onNext()
                }) {
                    Text("X")
                        .font(.title)
                        .padding()
                        .frame(width: 250, height:70)
                        .background(Color(.init(white: 1, alpha: 0.50)))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                }
                .padding()
                Button(action: {
                    selectedSymbol = .O
                    onNext()
                }) {
                    Text("O")
                        .font(.title)
                        .padding()
                        .frame(width: 250, height:70)
                        .background(Color(.init(white: 1, alpha: 0.50)))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                }
                .padding()
            }
            .padding(.bottom, 40)
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
