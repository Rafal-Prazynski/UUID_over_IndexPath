//
//  FirstPepeCollectionViewCell.swift
//  UUIDoverIndexPath
//
//  Created by Rafał P. on 07/04/2021.
//  Copyright © 2021 Rafał P. All rights reserved.
//

import UIKit

final class PepeCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private(set) var id = UUID()
    
    func setup(with model: ViewModel) {
        id = model.id
        imageView.image = UIImage(named: model.imageName)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
        ])
    }
}

extension PepeCollectionViewCell {
    struct ViewModel {
        let id: UUID
        let imageName: String
    }
}
