import SwiftUI

struct RootView: View {
    @State private var SelectedSymbol: Symbol? = nil
    @State private var firstPlayer: Symbol? = nil
    @State private var isManualTurnSelection = false
    @State private var gameState: GameState = .playerSelection

    var body: some View {
        NavigationView {
            VStack {
                switch gameState {
                case .playerSelection:
                    SelectedSymbolView(selectedSymbol: $SelectedSymbol, onNext: {
                        gameState = .turnChoice
                    })
                case .turnChoice:
                    TurnChoiceView(selectedSymbol: SelectedSymbol!, isManualTurnSelection: $isManualTurnSelection, onNext: {
                        gameState = isManualTurnSelection ? .manualTurnSelection : .gameView
                        firstPlayer = isManualTurnSelection ? nil : (Bool.random() ? .X : .O)
                    })
                case .manualTurnSelection:
                    ManualTurnSelectionView(selectedSymbol: SelectedSymbol!, symbol: $firstPlayer, onNext: {
                        gameState = .gameView
                    })
                case .gameView:
                    GameView(playerX: SelectedSymbol!, firstTurnPlayer: firstPlayer!, onResetGame: {
                        resetGame()
                    })
               
                }
            }
        }
    }

    private func resetGame() {
        SelectedSymbol = nil
        firstPlayer = nil
        isManualTurnSelection = false
        gameState = .playerSelection
    }
}
