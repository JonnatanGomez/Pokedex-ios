import SwiftUI

struct PokemonDetailView: View {
    let pokemonIdOrName: String
    @StateObject var viewModel = PokemonViewModel()

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Cargando...")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else if let pokemon = viewModel.selectedPokemon {
                VStack(alignment: .center, spacing: 20) {
                    
                    // Cabecera con nombre e ID
                    HStack {
                        Text(pokemon.species.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Text("#\(String(format: "%03d", pokemon.id))")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    // Imagen oficial con fondo gris
                    ZStack(alignment: .top) {
                        // Rectángulo de fondo gris (100 de alto)
                        //TODO: Modificar estilos de imagen de fondo y estacks
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 100)
                            .frame(maxWidth: .infinity, alignment: .bottom)
                        
                        // AsyncImage del Pokémon
                        AsyncImage(url: URL(string: pokemon.sprites.other.home.frontDefault)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                            } else if phase.error != nil {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                            } else {
                                ProgressView()
                                    .frame(height: 200)
                            }
                        }
                    }

                    
                    // Información básica
                    HStack(spacing: 40) {
                        VStack {
                            Text("Peso")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(pokemon.weight)")
                                .font(.headline)
                        }
                        VStack {
                            Text("Altura")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("\(pokemon.height)")
                                .font(.headline)
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // Estadísticas
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Estadísticas")
                            .font(.headline)
                        ForEach(pokemon.stats, id: \.stat.name) { stat in
                            HStack {
                                Text(stat.stat.name.capitalized)
                                    .frame(width: 120, alignment: .leading)
                                ProgressView(value: Float(stat.baseStat), total: 200)
                                    .accentColor(.green)
                                Text("\(stat.baseStat)")
                                    .frame(width: 40, alignment: .trailing)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getPokemonDetail(idOrName: pokemonIdOrName)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PokemonDetailView(pokemonIdOrName: "bulbasaur")
        }
    }
}
