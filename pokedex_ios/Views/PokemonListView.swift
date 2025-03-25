import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var searchText: String = ""
    
    // Two columns for the grid layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                (
                    Text("¡Hola, ") +
                    Text("bienvenido")
                        .bold() +
                    Text("!")
                )
                .font(.custom("montserratregular", size: 24))
                .foregroundColor(.black)
                .padding(.leading)
                .padding(.top, 15)
                .padding(.bottom, 15)
                      
                // -- Search bar
                HStack {
                    TextField("", text: $searchText, prompt: Text("Buscar por nombre o ID").foregroundColor(.black))
                        .padding(.horizontal, 16)
                        .frame(height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 16)
                            }
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                
                // -- Content area
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Grid of Pokémon cards
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredPokemon, id: \.id) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemonIdOrName: pokemon.name)) {
                                    PokemonCardView(pokemon: pokemon)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 100)                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getPokemonList()
            }.background(Color(red: 248/255, green: 248/255, blue: 248/255))
        }
    }
    
    private var filteredPokemon: [PokemonSpecies] {
        if searchText.isEmpty {
            return viewModel.pokemonList
        } else {
            return viewModel.pokemonList.filter { species in
                let lowerSearch = searchText.lowercased()
                let pokemonId = extractId(from: species.url)
                // Compare against name or ID
                return species.name.lowercased().contains(lowerSearch)
                    || pokemonId.contains(lowerSearch)
            }
        }
    }
    
    private func extractId(from url: String) -> String {
        guard let lastComponent = url.split(separator: "/").last else { return "" }
        return String(lastComponent)
    }
}

struct PokemonCardView: View {
    let pokemon: PokemonSpecies
    
    var body: some View {
       
        let pokemonId = extractId(from: pokemon.url)
        
        let formattedId = "#\(String(format: "%03d", Int(pokemonId) ?? 0))"
        
        let spriteURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonId).png")
        
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                Spacer()
                
                // Pokémon sprite (placeholder if error or loading)
                AsyncImage(url: spriteURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 135, height: 135)
                    case .failure(_):
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                // Pokémon name
                Text(pokemon.name.capitalized)
                    .font(.title)
                    .foregroundColor(.black)
                
                Spacer()
            }
            // ID in top-right
            Text(formattedId)
                .font(.caption)
                .foregroundColor(.gray)
                .padding([.top, .trailing], 15)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private func extractId(from url: String) -> String {
        guard let lastComponent = url.split(separator: "/").last else { return "" }
        return String(lastComponent)
    }
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color = .black

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 16)
            }
            TextField("", text: $text)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(Color.white)
                .cornerRadius(8)
                .foregroundColor(.black)
        }
    }
}
