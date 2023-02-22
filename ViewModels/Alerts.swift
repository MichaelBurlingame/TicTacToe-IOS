import SwiftUI

struct Alertitem: Identifiable {
    
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    
}

struct AlertContext {
    static let humanWin = Alertitem(title: Text("You Win"),
                                    message: Text("Congratulations!"),
                                    buttonTitle: Text("Go Again"))
    
    static let computerWin = Alertitem(title: Text("You Lost"),
                                       message: Text("You Let A Computer Beat You!"),
                                       buttonTitle: Text("Rematch!"))
    
    static let draw = Alertitem(title: Text("Draw"),
                                message: Text("There Are No Winners"),
                                buttonTitle: Text("Try Again"))
    
    static let player1Win = Alertitem(title: Text("Player 1 Wins"),
                                       message: Text(""),
                                       buttonTitle: Text("Rematch!"))
    
    static let player2Win = Alertitem(title: Text("Player 2 Wins"),
                                       message: Text(""),
                                       buttonTitle: Text("Rematch!"))
}
