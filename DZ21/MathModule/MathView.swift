//
//  MathView.swift
//  DZ21
//
//  Created by Dmitriy on 1/10/23.
//


import UIKit

//view controller
//protocol
//ref to presenter

protocol MathViewProtocol {
    var presenter: MathPresenterProtocol? { get set }
    var currentNumber: String { get set }
    var leftOpeMath: String { get set }
    var rightOpeMath: String { get set }
    var currentOperator: String { get set }
    var result: String { get set }
}

class MathViewController: UIViewController, MathViewProtocol {
    var presenter: MathPresenterProtocol?
    
    // Outlets for the calculator buttons
    var displayLabel: UILabel!
    var numberButtons: [UIButton]!
    var operatorButtons: [UIButton]!
    
    // Properties to keep track of the calculator state
    var currentNumber = ""
    var leftOpeMath = ""
    var rightOpeMath = ""
    var currentOperator = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureDisplayLabel()
        createNumberButtons()
        createOperatorButtons()
        createClearButton()
    }
    
    func configureDisplayLabel() {
        displayLabel = UILabel(frame: CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 50))
        displayLabel.backgroundColor = .white
        displayLabel.textAlignment = .right
        displayLabel.text = "0"
        view.addSubview(displayLabel)
    }
    
    func createNumberButtons() {
        let buttonWidth = (view.frame.width - 40) / 4
        let buttonHeight: CGFloat = 50
        for i in 0...9 {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: 20 + CGFloat(i % 3) * (buttonWidth + 10),
                                  y: 120 + CGFloat(i / 3) * (buttonHeight + 10),
                                  width: buttonWidth,
                                  height: buttonHeight)
            button.setTitle("\(i)", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            button.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    func createOperatorButtons() {
        let buttonWidth = (view.frame.width - 40) / 4
        let buttonHeight: CGFloat = 50
        let operators = ["+", "-", "x", "÷", "="]
        for (index, op) in operators.enumerated() {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: 20 + CGFloat(index) * (buttonWidth * 0.8),
                                  y: 370,
                                  width: buttonWidth,
                                  height: buttonHeight)
            button.setTitle(op, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            button.addTarget(self, action: #selector(operatorButtonTapped), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    func createClearButton() {
        let buttonWidth = (view.frame.width - 40) / 4
        let buttonHeight: CGFloat = 50
        let clearButton = UIButton(type: .system)
        clearButton.frame = CGRect(x: view.frame.width - 120, y: 120, width: buttonWidth, height: buttonHeight)
        clearButton.setTitle("AC", for: .normal)
        clearButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        view.addSubview(clearButton)
    }

    @objc func numberButtonTapped(_ sender: UIButton) {
        // Get the number from the button title
        guard let numberText = sender.titleLabel?.text else { return }
        // Append the number to the current number string
        currentNumber += numberText
        displayLabel.text = currentNumber
    }
    
    @objc func clearButtonTapped() {
        currentNumber = ""
        leftOpeMath = ""
        rightOpeMath = ""
        currentOperator = ""
        result = ""
        displayLabel.text = "0"
    }
    
    @objc func operatorButtonTapped(_ sender: UIButton) {
        guard let operatorText = sender.titleLabel?.text else { return }
        switch operatorText {
        case "+":
            // Add the current number to the left opeMath
            // and update the current operator
            leftOpeMath = currentNumber
            currentNumber = ""
            currentOperator = "+"
        case "-":
            leftOpeMath = currentNumber
            currentNumber = ""
            currentOperator = "-"
        case "x":
            leftOpeMath = currentNumber
            currentNumber = ""
            currentOperator = "*"
        case "÷":
            leftOpeMath = currentNumber
            currentNumber = ""
            currentOperator = "/"
        case "=":
            presenter?.performCalculation()
            // Update the display label
            displayLabel.text = result
            currentNumber = result
        default:
            break
        }
    }
}
