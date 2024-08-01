import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                //Spacer()
                Text("Bienvenue sur l'application de gestion de votre bassin de poissons")
                    .font(.largeTitle.italic())
                    .multilineTextAlignment(.center)
                    .padding()
                    .shadow(radius: 20)
                    .foregroundColor(.blue)
                
                Spacer()
                
                GeometryReader { geometry in
                                  Image("Bassin")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: geometry.size.width * 1, height: geometry.size.height * 0.8) // Ajustez la taille en fonction des dimensions de l'écran
                                      .shadow(radius: 30)
                                      //.cornerRadius(30)
                              }
                .frame(height: UIScreen.main.bounds.height * 0.3) // Ajustez la hauteur de l'image en fonction de la hauteur de l'écran
                
                Spacer()
                
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
//            .navigationBarTitle("Accueil", displayMode: .inline)
//            .padding(.horizontal, 16)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Utilisez cette ligne pour corriger les problèmes d'affichage sur iPad
    }
}

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
