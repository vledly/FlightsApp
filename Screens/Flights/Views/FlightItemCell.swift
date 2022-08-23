//
//  FlightItemCell.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import UIKit
import Combine

protocol FlightItemCellPresentable {
    var title: String { get }
    var flyDuration: String { get }
    var price: String { get }
    var imageUrl: URL? { get }
}

final class FlightItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var flightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        flightImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flightImageView.image = nil
    }
    
    func configure(_ viewModel: FlightItemCellPresentable) {
        titleLabel.text = viewModel.title
        durationLabel.text = viewModel.flyDuration
        priceLabel.text = viewModel.price

        if let url = viewModel.imageUrl {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.flightImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
