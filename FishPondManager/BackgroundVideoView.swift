//import SwiftUI
//import AVKit
//
//struct BackgroundVideoView: View {
//    @StateObject private var videoPlayer = VideoPlayerCoordinator()
//
//    var body: some View {
//        VideoPlayer(player: videoPlayer.player)
//            .onAppear {
//                videoPlayer.start()
//            }
//            .aspectRatio(contentMode: .fill) // Remplir tout l'espace disponible
//            .clipped()
//            .edgesIgnoringSafeArea(.all) // Ignorer les zones sécurisées pour couvrir l'ensemble de l'écran
//    }
//}
//
//class VideoPlayerCoordinator: ObservableObject {
//    let player: AVPlayer
//
//    init() {
//        guard let url = Bundle.main.url(forResource: "animationFish", withExtension: "mp4") else {
//            fatalError("Erreur : Le fichier vidéo n'a pas été trouvé.")
//        }
//        self.player = AVPlayer(url: url)
//        NotificationCenter.default.addObserver(
//            forName: .AVPlayerItemDidPlayToEndTime,
//            object: player.currentItem,
//            queue: .main
//        ) { _ in
//            self.player.seek(to: .zero)
//            self.player.play()
//        }
//    }
//
//    func start() {
//        player.play()
//    }
//}
