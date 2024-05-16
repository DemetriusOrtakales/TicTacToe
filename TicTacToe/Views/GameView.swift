import SwiftUI


struct GameView: View {
    @State private var currentTurn: Symbol
    @State private var board: [[Symbol?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @State private var winner: Symbol? = nil
    let playerX: Symbol
    let firstTurnPlayer: Symbol
    var onResetGame: () -> Void

    init(playerX: Symbol, firstTurnPlayer: Symbol, onResetGame: @escaping () -> Void) {
        self.playerX = playerX
        self.firstTurnPlayer = firstTurnPlayer
        self.onResetGame = onResetGame
        _currentTurn = State(initialValue: firstTurnPlayer)
    }

    var body: some View {
        VStack {
            Text(gameStatusText)
                .font(.largeTitle)
                .padding()
            
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { col in
                        CellView(symbol: board[row][col])
                            .onTapGesture {
                                processMove(row: row, col: col)
                            }
                    }
                }
            }

            if winner != nil || isBoardFull() {
                Button("New Game") {
                    onResetGame()
                }
                .font(.title)
                .padding()
                .background(Color(.green))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
            }
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

    private var gameStatusText: String {
        if let winner = winner {
            return "\(winner.rawValue) Wins!"
        } else if isBoardFull() {
            return "No Winner!"
        } else {
            return "It's \(currentTurn.rawValue)'s Turn"
        }
    }

    private func processMove(row: Int, col: Int) {
        if board[row][col] == nil, winner == nil {
            board[row][col] = currentTurn
            if checkWinner() {
                winner = currentTurn
            } else if isBoardFull() {
                winner = nil
            } else {
                currentTurn = (currentTurn == .X) ? .O : .X
            }
        }
    }

    private func checkWinner() -> Bool {
        let lines = [
            [(0, 0), (0, 1), (0, 2)], [(1, 0), (1, 1), (1, 2)], [(2, 0), (2, 1), (2, 2)],
            [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 1), (2, 1)], [(0, 2), (1, 2), (2, 2)],
            [(0, 0), (1, 1), (2, 2)], [(2, 0), (1, 1), (0, 2)]
        ]
        for line in lines {
            if line.allSatisfy({ board[$0.0][$0.1] == currentTurn }) {
                return true
            }
        }
        return false
    }

    private func isBoardFull() -> Bool {
           for row in board {
               for cell in row {
                   if cell == nil {
                       return false
                   }
               }
           }
           return true
       }
   }



struct TicTacToeBoard: View {
    @Binding var board: [[Symbol?]]
    @Binding var currentTurn: Symbol
    @Binding var winner: Symbol?

    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<3) { row in
                HStack(spacing: 10) {
                    ForEach(0..<3) { col in
                        CellView(symbol: board[row][col])
                            .onTapGesture {
                                if winner == nil && board[row][col] == nil {
                                    board[row][col] = currentTurn
                                    if checkWinner() {
                                        winner = currentTurn
                                    } else {
                                        currentTurn = (currentTurn == .X) ? .O : .X
                                    }
                                }
                            }
                    }
                }
            }
        }
        .padding()
    }

    func checkWinner() -> Bool {
        for i in 0..<3 {
            if let player = board[i][0], board[i][1] == player, board[i][2] == player { return true }
            if let player = board[0][i], board[1][i] == player, board[2][i] == player { return true }
        }
        if let player = board[0][0], board[1][1] == player, board[2][2] == player { return true }
        if let player = board[0][2], board[1][1] == player, board[2][0] == player { return true }

        return false
    }
}






