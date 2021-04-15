//
//  ViewController.swift
//  UUIDoverIndexPath
//
//  Created by Rafał P. on 07/04/2021.
//  Copyright © 2021 Rafał P. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    private let cellBuilder = CollectionViewCellBuilder()
    private let collectionView = CollectionView()
    private let pepeModels = MOCK.getPepe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        cellBuilder.registerCellsFor(collectionView: collectionView)
        cellBuilder.delegate = self
        let model = cellBuilder.collectionViewModel(for: pepeModels)
        collectionView.set(model)
    }
}

extension ViewController: CollectionViewCellBuilderProtocol {
    func selectedModel(with id: UUID) {
        print("Model index in not sorted list: \(pepeModels.pepes.firstIndex(where: {$0.id == id}))")
        print("Model name in not sorted list: \(pepeModels.pepes.first(where: {$0.id == id})?.pepe.name)")
    }
}
