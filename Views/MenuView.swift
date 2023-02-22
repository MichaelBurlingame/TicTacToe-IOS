import SwiftUI

struct MenuView: View {

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Image("Logo")
                    .padding()
                    .scaledToFit()
                
                Spacer()
                
                NavigationLink(destination: SinglePlayerView().navigationBarBackButtonHidden(true)) {
                    
                    ZStack {
                        
                        Capsule()
                            .foregroundColor(.black)
                            .frame(width: 200, height: 75)
                            .scaledToFit()
                            .shadow(radius: 25)
                        
                        Text("1 Player")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .scaledToFit()
                        
                    }
                }
                .padding()
                
                Spacer()
                
                NavigationLink(destination: TwoPlayerView().navigationBarBackButtonHidden(true)) {
                    
                    ZStack {
                        
                        Capsule()
                            .foregroundColor(.black)
                            .frame(width: 200, height: 75)
                            .scaledToFit()
                            .shadow(radius: 25)
                        
                        Text("2 Players")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .scaledToFit()
                        
                    }
                }
                .padding()
                
                Spacer()
                
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.light)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

