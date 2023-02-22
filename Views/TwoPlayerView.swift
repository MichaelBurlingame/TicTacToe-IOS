import SwiftUI

struct TwoPlayerView: View {
    
    @StateObject private var twoPlayerViewModel = TwoPlayerViewModel()
    @StateObject private var primaryViewModel = SinglePlayerViewModel()

    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                HStack {
                    
                    //Top Controls
                    
                    NavigationLink(destination: MenuView().navigationBarBackButtonHidden(true)) { Image(systemName: "house.circle.fill") }
                    .scaleEffect(2, anchor: .leading)
                    .padding()
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        
                        twoPlayerViewModel.resetGame()
                        
                    } label: {
                        
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                        
                    }
                    .scaleEffect(2, anchor: .trailing)
                    .padding()
                    .foregroundColor(.black)
                    
                }
                
                
                VStack {
                    
                    //Title
                    
                    Text("Tic-Tac-Toe")
                        .font(.largeTitle)
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    
                    Spacer()
                    
                    //Game Board
                    
                    LazyVGrid(columns: primaryViewModel.columns) {
                        
                        ForEach(0..<9) { i in
                            
                            ZStack {
                                
                                Rectangle()
                                    .foregroundColor(.blue).opacity(0.75)
                                    .frame(width: geometry.size.width/3 - 15, height: geometry.size.width/3 - 15)
                                    .shadow(radius: 15)
                                
                                Image(systemName: twoPlayerViewModel.twoMoves[i]?.indicator ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .shadow(radius: 15)
                                
                            }
                            .onTapGesture {
                                
                                //Play Game
                                
                                if twoPlayerViewModel.isSquareUsed(in: twoPlayerViewModel.twoMoves, forIndex: i) { return }
                                twoPlayerViewModel.twoMoves[i] = TwoMove(player: twoPlayerViewModel.isHumanTurn ? .p1 : .p2, boardIndex: i)
                                
                                if twoPlayerViewModel.checkWinCondition(for: .p1, in: twoPlayerViewModel.twoMoves) {
                                    primaryViewModel.feedback.notificationOccurred(.success)
                                    twoPlayerViewModel.alertItem = AlertContext.player1Win
                                    return
                                }
                                
                                if twoPlayerViewModel.checkForDraw(in: twoPlayerViewModel.twoMoves) {
                                    twoPlayerViewModel.alertItem = AlertContext.draw
                                    return
                                }
                                
                                twoPlayerViewModel.isHumanTurn.toggle()
                                
                                twoPlayerViewModel.whosTurn()
                                
                                if twoPlayerViewModel.checkWinCondition(for: .p2, in: twoPlayerViewModel.twoMoves) {
                                    primaryViewModel.feedback.notificationOccurred(.success)
                                    twoPlayerViewModel.alertItem = AlertContext.player2Win
                                    return
                                }
                                
                                if twoPlayerViewModel.checkForDraw(in: twoPlayerViewModel.twoMoves) {
                                    primaryViewModel.feedback.notificationOccurred(.error)
                                    twoPlayerViewModel.alertItem = AlertContext.draw
                                    return
                                    
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        //Show Who's Turn
                        
                        Capsule()
                            .frame(width: 250, height: 100)
                        
                        Image(systemName: "\(twoPlayerViewModel.turnDisplay)")
                            .foregroundColor(.white)
                            .frame(width: 250, height: 100)
                            .scaleEffect(4, anchor: .center)
                        
                    }
                    
                    Spacer()
                    
                }
                .alert(item: $twoPlayerViewModel.alertItem, content: { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle , action: twoPlayerViewModel.resetGame))})
                
                Spacer()
                
            }
            .padding()
            .preferredColorScheme(.light)
            Spacer()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


enum twoPlayers {
    case p1, p2
}

struct TwoMove {
    let player: twoPlayers
    let boardIndex: Int
    
    var indicator: String {
        return player == .p1 ? "xmark" : "circle"
    }
}



struct twoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        TwoPlayerView()
    }
}


