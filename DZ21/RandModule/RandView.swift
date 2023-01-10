//
//  RandView.swift
//  DZ21
//
//  Created by Dmitriy on 12/23/22.
//

import UIKit

//view controller
//protocol
//ref to presenter

protocol RandViewProtocol {
    var presenter: RandPresenterProtocol? { get set }
    func updateBackgroundColor(_ color: UIColor)
}

class RandViewController: UIViewController {
    var presenter: RandPresenterProtocol?
    let button: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Change Color", for: .normal)
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return myButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    @objc private func buttonTapped(_ sender: UIButton) {
        presenter?.buttonTapped()
    }
}

// MARK: - RandViewProtocol
extension RandViewController: RandViewProtocol {
    func updateBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
