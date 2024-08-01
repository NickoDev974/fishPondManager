import SwiftUI

struct Traitement: Identifiable, Codable {
    let id: UUID
    let date: Date
    let product: String
    let dose: String
}

struct TraitementView: View {
    @State private var concentration: String = ""
    @State private var waterVolume: String = ""
    @State private var desiredDose: String = ""
    @State private var result: String = ""
    
    @State private var product: String = ""
    @State private var dose: String = ""
    @State private var treatments: [Traitement] = []

    init() {
        _treatments = State(initialValue: loadTreatments())
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Calcul de dosage")
                    .font(.largeTitle)
                    .padding(.top, 16)
                    .padding(.horizontal)

                // Champs pour entrer la prescription /m3
                TextField("Prescription médicament (ml)", text: $concentration)
                    .padding()
                    .keyboardType(.decimalPad)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Champs pour entrer le volume d'eau
                TextField("Prescription Volume d'eau (L)", text: $waterVolume)
                    .padding()
                    .keyboardType(.decimalPad)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Champs pour entrer la dose souhaitée
                TextField("Volume de votre Bassin (L)", text: $desiredDose)
                    .padding()
                    .keyboardType(.decimalPad)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                Button(action: {
                    // Calcul du dosage
                    if let concentrationValue = concentration.toDouble(),
                       let waterVolumeValue = waterVolume.toDouble(),
                       let desiredDoseValue = desiredDose.toDouble() {
                        let dosage = (concentrationValue * desiredDoseValue) / waterVolumeValue
                        result = "Résultat: \(dosage.roundedString(to: 2)) mL"
                    } else {
                        result = "Valeur(s) invalide(s)"
                    }
                }) {
                    Text("Calculer")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Text(result)
                    .padding(.horizontal)

                Text("Vos traitements")
                    .font(.headline)
                    .padding(.top, 32)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    TextField("Produit", text: $product)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    TextField("Dose", text: $dose)
                        .padding()
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    Button(action: {
                        let newTreatment = Traitement(id: UUID(), date: Date(), product: product, dose: dose)
                        treatments.append(newTreatment)
                        saveTreatments(treatments)
                        product = ""
                        dose = ""
                    }) {
                        Text("Ajouter")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(treatments) { treatment in
                        HStack {
                            Text(Formatters.dateFormatter.string(from: treatment.date))
                            Spacer()
                            Text(treatment.product)
                            Spacer()
                            Text(treatment.dose)
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
            // Recharger les traitements lorsque la vue apparaît
            treatments = loadTreatments()
        }
    }

    // Sauvegarde des traitements dans UserDefaults
    func saveTreatments(_ treatments: [Traitement]) {
        if let encoded = try? JSONEncoder().encode(treatments) {
            UserDefaults.standard.set(encoded, forKey: "treatments")
        }
    }

    // Chargement des traitements depuis UserDefaults
    func loadTreatments() -> [Traitement] {
        if let savedData = UserDefaults.standard.data(forKey: "treatments"),
           let decoded = try? JSONDecoder().decode([Traitement].self, from: savedData) {
            return decoded
        }
        return []
    }
}

struct TraitementView_Previews: PreviewProvider {
    static var previews: some View {
        TraitementView()
    }
}
