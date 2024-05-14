import UIKit

class QuestionViewController: UIViewController {
    var quiz: Quiz?
    var currentQuestionIndex = 0
    var score = 0
    
    var questionLabel: UILabel!
    var answerButtons: [UIButton] = []
    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupQuestionLabel()
        setupAnswerButtons()
        setupSubmitButton()
        
        loadQuestion()
    }
    
    func setupQuestionLabel() {
        questionLabel = UILabel()
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 0
        self.view.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupAnswerButtons() {
        for _ in 0..<4 {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(answerSelected), for: .touchUpInside)
            answerButtons.append(button)
            self.view.addSubview(button)
        }
        
        for i in 0..<answerButtons.count {
            let button = answerButtons[i]
            if i == 0 {
                button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: answerButtons[i-1].bottomAnchor, constant: 10).isActive = true
            }
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    func setupSubmitButton() {
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitAnswer), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: answerButtons.last!.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadQuestion() {
        guard let quiz = quiz else { return }
        guard currentQuestionIndex < quiz.questions.count else { return }
        
        let question = quiz.questions[currentQuestionIndex]
        questionLabel.text = question.text
        
        for i in 0..<answerButtons.count {
            let button = answerButtons[i]
            if i < question.answers.count {
                button.setTitle(question.answers[i], for: .normal)
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
    }
    
    @objc func answerSelected(sender: UIButton) {
        for button in answerButtons {
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    @objc func submitAnswer() {
        guard let quiz = quiz else { return }
        guard currentQuestionIndex < quiz.questions.count else { return }
        
        let question = quiz.questions[currentQuestionIndex]
        let selectedButtonIndex = answerButtons.firstIndex(where: { $0.isSelected }) ?? -1
        var isCorrect = false
        
        // Convert correct answer to 0-based index and compare
        if let correctAnswerIndex = Int(question.answer) {
            if selectedButtonIndex == (correctAnswerIndex - 1) {
                score += 1
                isCorrect = true
            }
        }
        
        let answerVC = AnswerViewController()
        answerVC.question = question
        answerVC.userAnswerIndex = selectedButtonIndex
        answerVC.correctAnswerIndex = Int(question.answer)! - 1
        answerVC.isCorrect = isCorrect
        answerVC.quiz = quiz
        answerVC.currentQuestionIndex = currentQuestionIndex
        answerVC.score = score
        navigationController?.pushViewController(answerVC, animated: true)
    }
}
