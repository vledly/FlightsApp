//
//  StateView.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import UIKit

protocol HasStateWrapperView: AnyObject {
    var wrapperView: UIView? { get set }
}

extension UICollectionView: HasStateWrapperView {
    var wrapperView: UIView? {
        get { return backgroundView }
        set { backgroundView = newValue }
    }
}

protocol StateViewPresentable {
    func showState(type: StateType)
    func hideState()
}

final class StateView: UIView {

    private let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func configure(type: StateType) {
        messageLabel.text = type.message
    }
}

private extension StateView {
    func setup() {
        backgroundColor = .white
       
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .lightGray

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
   }
}
