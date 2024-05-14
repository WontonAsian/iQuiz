import UIKit

class QuizListViewController: UITableViewController {
    var quizzes: [Quiz] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Quiz Topics"
        
        // Settings Button
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(showSettings))
        self.navigationItem.rightBarButtonItem = settingsButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        fetchQuizzes()
    }

    func fetchQuizzes() {
        NetworkManager.shared.fetchQuizzes { quizzes in
            DispatchQueue.main.async {
                self.quizzes = quizzes
                self.tableView.reloadData()
                print("Fetched quizzes: \(quizzes)")
            }
        }
    }
    
    @objc func showSettings() {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let quiz = quizzes[indexPath.row]
        cell.textLabel?.text = quiz.title
        cell.detailTextLabel?.text = quiz.desc ?? "No description available"
        cell.imageView?.image = UIImage(systemName: "questionmark.circle") // Placeholder icon
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizDetailVC = QuizDetailViewController()
        quizDetailVC.quiz = quizzes[indexPath.row]
        navigationController?.pushViewController(quizDetailVC, animated: true)
    }
}
