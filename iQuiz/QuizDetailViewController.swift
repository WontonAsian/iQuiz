import UIKit

class QuizDetailViewController: UIViewController {
    var quiz: Quiz?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = quiz?.title
        self.view.backgroundColor = .white
        
        let startButton = UIButton(type: .system)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start Quiz", for: .normal)
        startButton.addTarget(self, action: #selector(startQuiz), for: .touchUpInside)
        self.view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func startQuiz() {
        let questionVC = QuestionViewController()
        questionVC.quiz = quiz
        navigationController?.pushViewController(questionVC, animated: true)
    }
}
