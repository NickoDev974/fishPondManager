import SwiftUI

// Modèle de données pour les paramètres d'eau
struct WaterParam: Identifiable, Codable {
    let id: UUID
    let date: Date
    let ph: String
    let kh: String
    let gh: String
    let ammoniak: String
    let nitrites: String
    let nitrates: String
    let phosphates: String
}

// Vue principale pour les paramètres d'eau
struct WaterParamView: View {
    @State private var ph: String = ""
    @State private var kh: String = ""
    @State private var gh: String = ""
    @State private var ammoniak: String = ""
    @State private var nitrites: String = ""
    @State private var nitrates: String = ""
    @State private var phosphates: String = ""
    @State private var waterParams: [WaterParam] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Paramètres de l'eau")
                    .font(.largeTitle)
                    .padding(.top, 16)
                    .padding(.horizontal)

                // Formulaire pour entrer les paramètres
                Group {
                    TextField("pH", text: $ph)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("KH", text: $kh)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("GH", text: $gh)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("Ammoniac", text: $ammoniak)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("Nitrites", text: $nitrites)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("Nitrates", text: $nitrates)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("Phosphates", text: $phosphates)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                Button(action: {
                    let newWaterParam = WaterParam(
                        id: UUID(),
                        date: Date(),
                        ph: ph,
                        kh: kh,
                        gh: gh,
                        ammoniak: ammoniak,
                        nitrites: nitrites,
                        nitrates: nitrates,
                        phosphates: phosphates
                    )
                    waterParams.append(newWaterParam)
                    saveWaterParams(waterParams)
                    clearForm()
                }) {
                    Text("Ajouter")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(waterParams) { param in
                        VStack(alignment: .leading) {
                            Text(Formatters.dateFormatter.string(from: param.date))
                                .font(.headline)
                                .padding(.bottom, 2)
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    VStack {
                                                        Text("pH")
                                                        Text("\(param.ph)")
                                                    }
                                                    VStack {
                                                        Text("KH")
                                                        Text("\(param.kh)")
                                                    }
                                                    VStack {
                                                        Text("GH")
                                                        Text("\(param.gh)")
                                                    }
                                                    VStack {
                                                        Text("NH3")
                                                        Text("\(param.ammoniak)")
                                                    }
                                                    VStack {
                                                        Text("NO2")
                                                        Text("\(param.nitrites)")
                                                    }
                                                    VStack {
                                                        Text("NO3")
                                                        Text("\(param.nitrates)")
                                                    }
                                                    VStack {
                                                        Text("PO4")
                                                        Text("\(param.phosphates)")
                                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .onAppear {
            // Recharger les paramètres lorsque la vue apparaît
            waterParams = loadWaterParams()
        }
    }

    // Sauvegarde des paramètres dans UserDefaults
    func saveWaterParams(_ waterParams: [WaterParam]) {
        if let encoded = try? JSONEncoder().encode(waterParams) {
            UserDefaults.standard.set(encoded, forKey: "waterParams")
        }
    }

    // Chargement des paramètres depuis UserDefaults
    func loadWaterParams() -> [WaterParam] {
        if let savedData = UserDefaults.standard.data(forKey: "waterParams"),
           let decoded = try? JSONDecoder().decode([WaterParam].self, from: savedData) {
            return decoded
        }
        return []
    }

    // Réinitialiser les champs du formulaire
    func clearForm() {
        ph = ""
        kh = ""
        gh = ""
        ammoniak = ""
        nitrites = ""
        nitrates = ""
        phosphates = ""
    }
}

// Prévisualisation de la vue
struct WaterParamView_Previews: PreviewProvider {
    static var previews: some View {
        WaterParamView()
    }
}
