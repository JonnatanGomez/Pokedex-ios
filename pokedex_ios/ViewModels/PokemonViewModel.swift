import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [PokemonSpecies] = []
    @Published var selectedPokemon: PokemonDetailResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func getPokemonList() {
        isLoading = true
        PokemonService.shared.fetchPokemonList { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let list):
                    self.pokemonList = list
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getPokemonDetail(idOrName: String) {
        isLoading = true
        PokemonService.shared.fetchPokemonDetail(for: idOrName) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let detail):
                    self.selectedPokemon = detail
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
