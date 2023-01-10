//
//  MathPresenter.swift
//  DZ21
//
//  Created by Dmitriy on 1/10/23.
//

import UIKit

//object
//protocol
//ref to view, interactor, presenter

protocol MathPresenterProtocol {
    var view: MathViewProtocol? { get set }
    var interactor: MathInteractorProtocol? { get set }
    var router: MathRouterProtocol? { get set }
    func performCalculation()
}

class MathPresenter: MathPresenterProtocol {
    var view: MathViewProtocol?
    var interactor: MathInteractorProtocol?
    var router: MathRouterProtocol?
    func performCalculation() {
        if view!.currentOperator == "+" {
            view!.result = "\(Double(view!.leftOpeMath)! + Double(view!.currentNumber)!)"
        } else if view!.currentOperator == "-" {
            view!.result = "\(Double(view!.leftOpeMath)! - Double(view!.currentNumber)!)"
        } else if view!.currentOperator == "*" {
            view!.result = "\(Double(view!.leftOpeMath)! * Double(view!.currentNumber)!)"
        } else if view!.currentOperator == "/" {
            view!.result = "\(Double(view!.leftOpeMath)! / Double(view!.currentNumber)!)"
        }
    }
}
