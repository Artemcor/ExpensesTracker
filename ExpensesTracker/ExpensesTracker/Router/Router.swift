//
//  Router.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 26.09.2022.
//

import UIKit

protocol Router {
    
    var navigationController: UINavigationController { get }
    func push(_ controller: UIViewController, animated: Bool)
    func present(_ controller: UIViewController, animated: Bool)
}
