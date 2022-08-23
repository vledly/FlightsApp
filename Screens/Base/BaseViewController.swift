//
//  BaseViewController.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    var viewForState: HasStateWrapperView? { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController: StateViewPresentable {
    
    func showState(type: StateType) {
        let stateView = StateView()
        stateView.configure(type: type)
        viewForState?.wrapperView = stateView

        view.addSubview(stateView)
        stateView.translatesAutoresizingMaskIntoConstraints = false
        stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stateView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        stateView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }

    func hideState() {
        viewForState?.wrapperView?.removeFromSuperview()
        viewForState?.wrapperView = nil
    }
}

