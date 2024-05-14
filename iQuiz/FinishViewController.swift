import UIKit

class FinishedViewController: UIViewController {
    var score: Int = 0
    var totalQuestions: Int = 0
    
    var resultLabel: UILabel!
    var scoreLabel: UILabel!
    var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupResultLabel()
        setupScoreLabel()
        setupNextButton()
        
        displayResults()
    }
    
    func setupResultLabel() {
        resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.numberOfLines = 0
        self.view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupScoreLabel() {
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.numberOfLines = 0
        self.view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupNextButton() {
        nextButton = UIButton(type: .system)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextQuiz), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func displayResults() {
        let percentage = Double(score) / Double(totalQuestions)
        if percentage == 1.0 {
            resultLabel.text = "Perfect!"
        } else if percentage >= 0.8 {
            resultLabel.text = "Almost!"
        } else {
            resultLabel.text = "Better luck next time!"
        }
        
        scoreLabel.text = "You scored \(score) out of \(totalQuestions)."
    }
    
    @objc func nextQuiz() {
        navigationController?.popToRootViewController(animated: true)
    }
}
