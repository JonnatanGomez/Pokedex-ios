import Foundation

class PokemonService {
    static let shared = PokemonService()
    let baseUrl = "https://pokeapi.co/api/v2/"

    func fetchPokemonList(completion: @escaping (Result<[PokemonSpecies], Error>) -> Void) {
        let urlString = "\(baseUrl)generation/1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let listResponse = try decoder.decode(GenerationResponse.self, from: data)
                completion(.success(listResponse.pokemonSpecies))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchPokemonDetail(for idOrName: String, completion: @escaping (Result<PokemonDetailResponse, Error>) -> Void) {
        let urlString = "\(baseUrl)pokemon/\(idOrName)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let detail = try decoder.decode(PokemonDetailResponse.self, from: data)
                completion(.success(detail))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
