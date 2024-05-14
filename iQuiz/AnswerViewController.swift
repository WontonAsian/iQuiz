import UIKit

class AnswerViewController: UIViewController {
    var question: Question?
    var userAnswerIndex: Int?
    var correctAnswerIndex: Int?
    var isCorrect: Bool = false
    var quiz: Quiz?
    var currentQuestionIndex: Int?
    var score: Int?
    
    var questionLabel: UILabel!
    var correctAnswerLabel: UILabel!
    var userAnswerLabel: UILabel!
    var resultLabel: UILabel!
    var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupQuestionLabel()
        setupCorrectAnswerLabel()
        setupUserAnswerLabel()
        setupResultLabel()
        setupNextButton()
        
        displayAnswer()
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
    
    func setupCorrectAnswerLabel() {
        correctAnswerLabel = UILabel()
        correctAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        correctAnswerLabel.numberOfLines = 0
        correctAnswerLabel.textColor = .green
        self.view.addSubview(correctAnswerLabel)
        
        NSLayoutConstraint.activate([
            correctAnswerLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            correctAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            correctAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupUserAnswerLabel() {
        userAnswerLabel = UILabel()
        userAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        userAnswerLabel.numberOfLines = 0
        userAnswerLabel.textColor = .red
        self.view.addSubview(userAnswerLabel)
        
        NSLayoutConstraint.activate([
            userAnswerLabel.topAnchor.constraint(equalTo: correctAnswerLabel.bottomAnchor, constant: 20),
            userAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupResultLabel() {
        resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.numberOfLines = 0
        self.view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: userAnswerLabel.bottomAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupNextButton() {
        nextButton = UIButton(type: .system)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func displayAnswer() {
        guard let question = question, let userAnswerIndex = userAnswerIndex, let correctAnswerIndex = correctAnswerIndex else { return }
        
        questionLabel.text = question.text
        correctAnswerLabel.text = "Correct Answer: \(question.answers[correctAnswerIndex])"
        userAnswerLabel.text = "Your Answer: \(question.answers[userAnswerIndex])"
        
        if isCorrect {
            resultLabel.text = "You are correct!"
            resultLabel.textColor = .green
        } else {
            resultLabel.text = "You are incorrect."
            resultLabel.textColor = .red
        }
    }
    
    @objc func nextQuestion() {
        guard let quiz = quiz, let currentQuestionIndex = currentQuestionIndex, let score = score else { return }
        
        if currentQuestionIndex + 1 < quiz.questions.count {
            let questionVC = QuestionViewController()
            questionVC.quiz = quiz
            questionVC.currentQuestionIndex = currentQuestionIndex + 1
            questionVC.score = score
            navigationController?.pushViewController(questionVC, animated: true)
        } else {
            let finishedVC = FinishedViewController()
            finishedVC.score = score
            finishedVC.totalQuestions = quiz.questions.count
            navigationController?.pushViewController(finishedVC, animated: true)
        }
    }
}
