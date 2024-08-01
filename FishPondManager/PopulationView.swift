import SwiftUI
import PhotosUI

struct PopulationView: View {
    @State private var isPickerPresented = false
    @State private var fishPhotos: [FishPhoto] = []

    var body: some View {
        VStack {
            Text("Mes Photos")
                .font(.largeTitle)
                .padding()

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(fishPhotos) { photo in
                        if let uiImage = UIImage(contentsOfFile: photo.imageURL.path) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }

            Button(action: {
                isPickerPresented = true
            }) {
                Text("Ajouter une photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(fishPhotos: $fishPhotos, saveFishPhotos: saveFishPhotos)
        }
        .onAppear {
            // Charger les photos lorsqu'on apparait
            loadFishPhotos()
            createDirectoryIfNeeded()
        }
    }

    func createDirectoryIfNeeded() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fishPhotosDirectory = documentsDirectory.appendingPathComponent("FishPhotos")

        if !fileManager.fileExists(atPath: fishPhotosDirectory.path) {
            do {
                try fileManager.createDirectory(at: fishPhotosDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error)")
            }
        }
    }

    func saveFishPhotos(_ fishPhotos: [FishPhoto]) {
        if let encoded = try? JSONEncoder().encode(fishPhotos) {
            UserDefaults.standard.set(encoded, forKey: "fishPhotos")
        }
    }

    func loadFishPhotos() {
        if let savedData = UserDefaults.standard.data(forKey: "fishPhotos"),
           let decoded = try? JSONDecoder().decode([FishPhoto].self, from: savedData) {
            fishPhotos = decoded
        }
    }
}
