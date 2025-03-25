import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.pokemonList, id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemonIdOrName: pokemon.name)) {
                            Text(pokemon.name.capitalized)
                        }
                    }
                }
            }
            .navigationTitle("Pokédex")
            .onAppear {
                viewModel.getPokemonList()
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
