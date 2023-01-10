//
//  MathInteractor.swift
//  DZ21
//
//  Created by Dmitriy on 1/10/23.
//

import Foundation

protocol MathInteractorProtocol {
    var presenter: MathPresenterProtocol? { get set }
}

class MathInteractor: MathInteractorProtocol {
    var presenter: MathPresenterProtocol?
}
