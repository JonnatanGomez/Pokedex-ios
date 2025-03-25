import SwiftUI

struct PokemonDetailView: View {
    let pokemonIdOrName: String
    @StateObject var viewModel = PokemonViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error+" Si")
                        .foregroundColor(.red)
                } else if let pokemon = viewModel.selectedPokemon {
                    
                    // Imagen con AsyncImage (iOS 15+)
                    AsyncImage(url: URL(string: pokemon.sprites.other.home.frontDefault)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        } else if phase.error != nil {
                            Text("Error loading image")
                        } else {
                            ProgressView()
                        }
                    }
                    
                    // Descripción
                    //Text(pokemon.description ?? "Sin descripcion")
                    //    .padding()
                    
                    // Estadísticas (por ejemplo, una lista de estadísticas)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Stats:")
                            .font(.headline)
                        ForEach(pokemon.stats, id: \.stat.name) { stat in
                            Text("\(stat.stat.name.capitalized): \(stat.baseStat)")
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle(pokemonIdOrName.capitalized)
        .onAppear {
            viewModel.getPokemonDetail(idOrName: pokemonIdOrName)
        }
    }
}
