import SwiftUI

final class TwoPlayerViewModel: ObservableObject {
    
    //Variables
    
    @Published var twoMoves: [TwoMove?] = Array(repeating: nil, count: 9)
    @Published var isHumanTurn = true
    @Published var alertItem: Alertitem?
    @Published var turnDisplay = "xmark"
    
    //Functions
    
    func whosTurn() {
        
        if isHumanTurn {
            turnDisplay = "xmark"
        } else {
            turnDisplay = "circle"
        }
    
    }
    
    func resetGame() {
        
            twoMoves = Array(repeating: nil, count: 9)
            isHumanTurn = true
            turnDisplay = "xmark"
        
    }
    
    func isSquareUsed(in twoMoves: [TwoMove?], forIndex index: Int) -> Bool {
        
        return twoMoves.contains(where: { $0?.boardIndex == index})
        
    }
    
    func checkWinCondition(for player: twoPlayers, in twoMoves: [TwoMove?]) -> Bool {
        
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let p1Moves = twoMoves.compactMap { $0 }.filter { $0.player == player}
        let p1Positions = Set(p1Moves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: p1Positions) { return true }
        
        return false
        
    }
    
    func checkForDraw(in moves: [TwoMove?]) -> Bool {
        
        return twoMoves.compactMap{ $0 }.count == 9
        
    }
    
}

