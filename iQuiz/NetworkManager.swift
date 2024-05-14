import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchQuizzes(completion: @escaping ([Quiz]) -> Void) {
        let url = URL(string: "http://tednewardsandbox.site44.com/questions.json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error!)")
                return
            }
            
            do {
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
                print(quizzes)  // Add this line to log the quizzes
                completion(quizzes)
            } catch {
                print("JSON parsing error: \(error)")
            }
        }
        
        task.resume()
    }
}
