//
//  Router.swift
//  EnemyLoss
//
//  Created by Artem Stozhok on 18.07.2022.
//

import UIKit

protocol Router {
    
    var navigationController: UINavigationController { get }
    func push(_ controller: UIViewController, animated: Bool)
}
