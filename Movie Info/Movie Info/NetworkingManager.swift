import Foundation

// Result <Success, Error> protocol
protocol NetworkingDelegate {
    func networkingDidFinishWithMovies(movies: [MovieModel])
    func networkingDidFinishWithError()
}

class NetworkingManager {
    var delegate: NetworkingDelegate?
    static var shared = NetworkingManager()

    func searchMovies(query: String) {
        do {
            let apiKey = "e250c3d93a9d9bb095d1af3d2c6f796b"
            let urlString = "https://api.themoviedb.org/3/search/multi?query=\(query)&api_key=\(apiKey)"
            guard let url = URL(string: urlString) else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    self.delegate?.networkingDidFinishWithError()
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) 
                else {
                    self.delegate?.networkingDidFinishWithError()
                    return
                }

                if let jsonData = data {
                    let decoder = JSONDecoder()
                    do {
                        let searchResponse = try decoder.decode(SearchResponse.self, from: jsonData)
                        let movies = searchResponse.results.compactMap { movieResult in
                            return MovieModel(
                                id: movieResult.id,
                                originalTitle: movieResult.originalTitle,
                                originalTitle2: movieResult.originalTitle2,
                                posterPath: movieResult.posterPath,
                                backdropImagePath: movieResult.backdropImagePath,
                                overview: movieResult.overview,
                                mediaType: movieResult.mediaType,
                                releaseDate: movieResult.releaseDate,
                                popularity: movieResult.popularity
                            )
                        }
                        
                        self.delegate?.networkingDidFinishWithMovies(movies: movies)
                        
                    } 
                    catch {
                        print("Decoding error: \(error)")
                        self.delegate?.networkingDidFinishWithError()
                    }
                }
            }

            task.resume()
        } 
        catch {
            print("URL creation error: \(error)")
            self.delegate?.networkingDidFinishWithError()
        }
    }
}
