import SwiftUI

struct SinglePlayerView: View {
    
    @StateObject private var primaryViewModel = SinglePlayerViewModel()
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                
                HStack {
                    //Top Controls
                    
                    NavigationLink(destination: MenuView().navigationBarBackButtonHidden(true)) {
                        Image(systemName: "house.circle.fill")
                    }
                    .scaleEffect(2, anchor: .leading)
                    .padding()
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        
                        primaryViewModel.resetGame()
                        
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
                                
                                Image(systemName: primaryViewModel.moves[i]?.indicator ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .shadow(radius: 15)
                            }
                            .onTapGesture {
                                
                                //Lets Computer Play Based On Chosen Difficulty
                                
                                if primaryViewModel.difficulty == "Easy"{
                                    primaryViewModel.easyDifficulty(for: i)
                                } else if primaryViewModel.difficulty == "Medium" {
                                    primaryViewModel.mediumDifficulty(for: i)
                                } else if primaryViewModel.difficulty == "Hard" {
                                    primaryViewModel.hardDifficulty(for: i)
                                }
                                
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                }
                .disabled(primaryViewModel.isBoardDisabled)
                .padding()
                .alert(item: $primaryViewModel.alertitem, content: { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {
                        primaryViewModel.resetGame()}))})
                
                VStack {
                    
                    //Difficulty UI
                    
                    Spacer()
                    
                    Text("\(primaryViewModel.difficulty)")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        
                        //Difficulty controls
                        
                        Spacer()
                        
                        Button {
                            
                            primaryViewModel.difficulty = "Easy"
                            primaryViewModel.resetGame()
                            
                        } label: {
                            
                            ZStack {
                                
                                Capsule()
                                Text("Easy")
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            .frame(width: 100, height: 40)
                        }
                        
                        Button {
                            
                            primaryViewModel.difficulty = "Medium"
                            primaryViewModel.resetGame()
                            
                        } label: {
                            
                            ZStack {
                                
                                Capsule()
                                Text("Medium")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(width: 100, height: 40)
                        }
                        
                        Button {
                            
                            primaryViewModel.difficulty = "Hard"
                            primaryViewModel.resetGame()
                            
                        } label: {
                            
                            ZStack {
                                
                                Capsule()
                                Text("Hard")
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            .frame(width: 100, height: 40)
                        }
                        
                        Spacer()
                        
                    }
                }
                .padding()
            }
            .preferredColorScheme(.light)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerView()
    }
}

