import SwiftUI

struct CalculView: View {
    @State private var selectedShape = 0
    @State private var length: String = ""
    @State private var width: String = ""
    @State private var height: String = ""
    @State private var radius: String = ""
    @State private var result: String = ""

    var body: some View {
        VStack {
            Text("Calcul de volume")
                .font(.largeTitle)
                .padding()

            Picker(selection: $selectedShape, label: Text("Forme du bassin")) {
                Text("Rectangulaire").tag(0)
                Text("Cylindrique").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Text("Entrez des valeurs en Mètres")

            if selectedShape == 0 {
                // Champs pour bassin rectangulaire
                TextField("Entrez la Longueur", text: $length)
                    .padding()
                    .keyboardType(.decimalPad)
                    .border(Color.gray)

                TextField("Entrez la Largeur", text: $width)
                    .padding()
                    .keyboardType(.decimalPad)
                    .border(Color.gray)

                TextField("Entrez la Hauteur", text: $height)
                    .padding()
                    .keyboardType(.decimalPad)
                    .border(Color.gray)
            } else {
                // Champs pour bassin cylindrique
                TextField("Entrez le Rayon", text: $radius)
                    .padding()
                    .keyboardType(.decimalPad)
                    .border(Color.gray)

                TextField("Entrez la Hauteur", text: $height)
                    .padding()
                    .keyboardType(.decimalPad)
                    .border(Color.gray)
            }

            Button(action: {
                if selectedShape == 0 {
                    // Calcul pour bassin rectangulaire
                    if let lengthValue = length.toDouble(),
                       let widthValue = width.toDouble(),
                       let heightValue = height.toDouble() {
                        let volume = lengthValue * widthValue * heightValue
                        let volumeEnLitre = volume * 1000
                        result = "Votre Bassin a un volume de : \(volume.roundedString(to: 2)) m³ (soit : \(volumeEnLitre.roundedString(to: 2)) L)"
                    } else {
                        result = "Valeur(s) invalide(s)"
                    }
                } else {
                    // Calcul pour bassin cylindrique
                    if let radiusValue = radius.toDouble(),
                       let heightValue = height.toDouble() {
                        let volume = Double.pi * pow(radiusValue, 2) * heightValue
                        let volumeEnLitre = volume * 1000
                        result = "Votre Bassin a un volume de : \(volume.roundedString(to: 2)) m³ (soit : \(volumeEnLitre.roundedString(to: 2)) L)"
                    } else {
                        result = "Valeur(s) invalide(s)"
                    }
                }
            }) {
                Text("Calculer")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Text(result)
                .padding()
        }
        .padding()
    }
}

struct CalculView_Previews: PreviewProvider {
    static var previews: some View {
        CalculView()
    }
}

//extension String {
//    func toDouble() -> Double? {
//        let formatter = NumberFormatter()
//        formatter.locale = Locale(identifier: "fr_FR")
//        formatter.numberStyle = .decimal
//        return formatter.number(from: self)?.doubleValue
//    }
//}
//
//extension Double {
//    func roundedString(to places: Int) -> String {
//        return String(format: "%.\(places)f", self)
//    }
//}
