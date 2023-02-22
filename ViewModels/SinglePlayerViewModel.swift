import SwiftUI

final class SinglePlayerViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDisabled = false
    @Published var alertitem: Alertitem?
    @Published var feedback = UINotificationFeedbackGenerator()
    @Published var difficulty = "Medium"
    
    //Functions
    
    func mediumDifficulty(for position: Int) {
        
            if isSpaceOccupied(in: moves, forIndex: position) { return }
            moves[position] = Move(player: .human, boardIndex: position)
            isBoardDisabled = true
            
            if checkWinCondition(for: .human, in: moves) {
                
                alertitem = AlertContext.humanWin
                feedback.notificationOccurred(.success)
                return
            }
            
            if checkDraw(in: moves) {
                
                alertitem = AlertContext.draw
                return
            }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            
                let computerPosition = medComputerMove(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isBoardDisabled = false
                
                if checkWinCondition(for: .computer, in: moves) {
                    
                    alertitem = AlertContext.computerWin
                    return
                }
                
                if checkDraw(in: moves) {
                    
                    alertitem = AlertContext.draw
                    return
                }
            }
    }
    
    func hardDifficulty(for position: Int) {
        
            if isSpaceOccupied(in: moves, forIndex: position) { return }
            moves[position] = Move(player: .human, boardIndex: position)
            isBoardDisabled = true
            
            if checkWinCondition(for: .human, in: moves) {
                
                alertitem = AlertContext.humanWin
                feedback.notificationOccurred(.success)
                return
            }
            
            if checkDraw(in: moves) {
                
                alertitem = AlertContext.draw
                return
            }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            
                let computerPosition = hardComputerMove(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isBoardDisabled = false
                
                if checkWinCondition(for: .computer, in: moves) {
                    
                    feedback.notificationOccurred(.success)
                    alertitem = AlertContext.computerWin
                    return
                }
                
                if checkDraw(in: moves) {
                    
                    alertitem = AlertContext.draw
                    return
                }
            }
    }

    func easyDifficulty(for position: Int) {
        
            if isSpaceOccupied(in: moves, forIndex: position) { return }
            moves[position] = Move(player: .human, boardIndex: position)
            isBoardDisabled = true
            
            if checkWinCondition(for: .human, in: moves) {
                
                feedback.notificationOccurred(.success)
                alertitem = AlertContext.humanWin
                return
            }
            
            if checkDraw(in: moves) {
                
                feedback.notificationOccurred(.error)
                alertitem = AlertContext.draw
                return
            }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            
                let computerPosition = easyComputerMove(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isBoardDisabled = false
                
                if checkWinCondition(for: .computer, in: moves) {
                    
                    feedback.notificationOccurred(.error)
                    alertitem = AlertContext.computerWin
                    return
                }
                
                if checkDraw(in: moves) {
                    
                    feedback.notificationOccurred(.error)
                    alertitem = AlertContext.draw
                    return
                }
            }
    }

    
    func isSpaceOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func hardComputerMove(in moves: [Move?]) -> Int {
        
        //If AI Can Win, Win (Searches Set To match To Current Moves)
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPosition = Set(computerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            
            let winPositions = pattern.subtracting(computerPosition)
            
            if winPositions.count == 1 {
                
                let isAvailable = !isSpaceOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        //If AI Cant Win, Block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPosition = Set(humanMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            
            let winPositions = pattern.subtracting(humanPosition)
            
            if winPositions.count == 1 {
                
                let isAvailable = !isSpaceOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        //If AI Cant block, then take middle square
        let centerSquare = 4
        if !isSpaceOccupied(in: moves, forIndex: centerSquare) {
            
            return centerSquare
        }
        
        
        //If AI Cant take Middle, take random spot
        var movePosition = Int.random(in: 0..<9)
        while isSpaceOccupied(in: moves, forIndex: movePosition) {
            
            movePosition = Int.random(in: 0..<9)}
        
       return movePosition
    }
    
    func medComputerMove(in moves: [Move?]) -> Int {
        
        //AI Won't Block As Agressively But Will Win When Available
        
        //If AI Can Win, Win (Searches Set To match To Current Moves)
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPosition = Set(computerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            
            let winPositions = pattern.subtracting(computerPosition)
            
            if winPositions.count == 1 {
                
                let isAvailable = !isSpaceOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        //If AI Cant Win, Block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPosition = Set(humanMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            
            let winPositions = pattern.subtracting(humanPosition)
            
            if winPositions.count == 1 {
                
                let isAvailable = !isSpaceOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        //If AI Cant take Middle, take random spot
        var movePosition = Int.random(in: 0..<9)
        while isSpaceOccupied(in: moves, forIndex: movePosition) {
            
            movePosition = Int.random(in: 0..<9)}
        
       return movePosition
        
    }
    
    func easyComputerMove(in moves: [Move?]) -> Int {
        
        //AI Will Choose Randomly and Win When Available
        var movePosition = Int.random(in: 0..<9)
        
        while isSpaceOccupied(in: moves, forIndex: movePosition) {
            
            movePosition = Int.random(in: 0..<9)}
        
       return movePosition
    }

    
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkDraw(in moves: [Move?]) -> Bool {
        
        return moves.compactMap{ $0 }.count == 9
    }
    
    func resetGame() {
        
        moves = Array(repeating: nil, count: 9)
        isBoardDisabled = false
    }
}



