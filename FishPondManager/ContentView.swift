import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
            
                Text("Fish Pond Manager")
                    .font(.largeTitle.italic())
                    .multilineTextAlignment(.center)
                    .padding()
                    .shadow(radius: 20)
                    .foregroundColor(.blue)
                
                Spacer()
                
                GeometryReader { geometry in
                                                 Image("koi")
                                                     .resizable()
                                                     .scaledToFit()
                                                     .frame(width: geometry.size.width * 1, height: geometry.size.height * 1) // Ajustez la taille en fonction des dimensions de l'écran
                                                     .shadow(radius: 30)
                                                     //.cornerRadius(30)
                                             }
                               .frame(height: UIScreen.main.bounds.height * 0.5) // Ajustez la hauteur de l'image en fonction de la hauteur de l'écran
                               
                
//                VideoPlayerView()
//                    .frame(height: UIScreen.main.bounds.height * 0.2)  // Ajustez la hauteur de la vidéo ici
//                
                Spacer()
                
                HStack {
                    NavigationLink(destination: CalculView()) {
                        VStack {
                            Image(systemName: "function")
                                .font(.largeTitle)
                            Text("Calcul")
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    
                    NavigationLink(destination: TraitementView()) {
                        VStack {
                            Image(systemName: "pills")
                                .font(.largeTitle)
                            Text("Entretien")
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    
                    NavigationLink(destination: WaterParamView()) {
                        VStack {
                            Image(systemName: "drop.fill")
                                .font(.largeTitle)
                            Text("Paramètres")
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                    
                    NavigationLink(destination: PopulationView()) {
                        VStack {
                            Image(systemName: "camera.fill")
                                .font(.largeTitle)
                            Text("Photo")
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
                .padding(.bottom, 10)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct VideoPlayerView: View {
    @StateObject private var videoPlayer = VideoPlayerCoordinator()

    var body: some View {
        VideoPlayer(player: videoPlayer.player)
            .onAppear {
                videoPlayer.start()
            }
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}

class VideoPlayerCoordinator: ObservableObject {
    let player: AVPlayer

    init() {
        guard let url = Bundle.main.url(forResource: "animationFish", withExtension: "mp4") else {
            fatalError("Erreur : Le fichier vidéo n'a pas été trouvé.")
        }
        self.player = AVPlayer(url: url)
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            self.player.seek(to: .zero)
            self.player.play()
        }
    }

    func start() {
        player.play()
    }
}

// Exemples de vues pour navigation
//struct CalculView: View {
//    var body: some View {
//        Text("Calcul View")
//            .navigationBarTitle("Calcul", displayMode: .inline)
//    }
//}
//
//struct TraitementView: View {
//    var body: some View {
//        Text("Traitement View")
//            .navigationBarTitle("Entretien", displayMode: .inline)
//    }
//}
//
//struct WaterParamView: View {
//    var body: some View {
//        Text("Water Param View")
//            .navigationBarTitle("Paramètres", displayMode: .inline)
//    }
//}
//
//struct PopulationView: View {
//    var body: some View {
//        Text("Population View")
//            .navigationBarTitle("Photo", displayMode: .inline)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
