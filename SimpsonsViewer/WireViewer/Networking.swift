//  Project: SimpsonsViewer 
// Created by Jason Stout on 4/24/23.
//
// Using Swift 5.0
// Running on macOS 13.2
// Networking
//
// "Design is not just what it looks like and feels like. Design is how it works." - Steve Jobs

import Foundation

class Networking {
    static let shared = Networking()
    
    let projectTitle = "The Wire Character Viewer"
    private var apiUrl = "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
    
    func fetchData(completion: @escaping(_ topics: [RelatedTopic]) -> Void) {
        let url = URL(string: apiUrl)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let jsonData = data, error == nil else {
                print("Error fetching JSON response: \(error!.localizedDescription)")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(DuckDuckGoResponse.self, from: jsonData)
                let relatedTopics = response.relatedTopics
                
                completion(relatedTopics)
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
