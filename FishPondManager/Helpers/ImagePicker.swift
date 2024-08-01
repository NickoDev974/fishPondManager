import SwiftUI
import PhotosUI

struct ImagePicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var fishPhotos: [FishPhoto]
    var saveFishPhotos: ([FishPhoto]) -> Void
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images
        ) {
            Text("Select a photo")
        }
        .onChange(of: selectedItem) {
            Task {
                if let selectedItem = selectedItem {
                    if let data = try? await selectedItem.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        let fileManager = FileManager.default
                        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let fishPhotosDirectory = documentsDirectory.appendingPathComponent("FishPhotos")
                        
                        // Créer le répertoire si nécessaire
                        if !fileManager.fileExists(atPath: fishPhotosDirectory.path) {
                            do {
                                try fileManager.createDirectory(at: fishPhotosDirectory, withIntermediateDirectories: true, attributes: nil)
                            } catch {
                                print("Error creating directory: \(error)")
                            }
                        }
                        
                        let uniqueFilename = UUID().uuidString + ".jpg"
                        let fileURL = fishPhotosDirectory.appendingPathComponent(uniqueFilename)
                        
                        if let imageData = image.jpegData(compressionQuality: 1.0) {
                            do {
                                try imageData.write(to: fileURL)
                                
                                let newFishPhoto = FishPhoto(id: UUID(), imageURL: fileURL)
                                fishPhotos.append(newFishPhoto)
                                saveFishPhotos(fishPhotos)
                            } catch {
                                print("Error saving image: \(error)")
                            }
                        }
                    }
                }
                dismiss()
            }
        }
    }
}
