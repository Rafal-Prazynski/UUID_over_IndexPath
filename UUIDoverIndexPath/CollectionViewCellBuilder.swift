//
//  CollectionViewCellBuilder.swift
//  UUIDoverIndexPath
//
//  Created by Rafał P. on 07/04/2021.
//  Copyright © 2021 Rafał P. All rights reserved.
//

import UIKit

protocol CollectionViewCellBuilderProtocol: class {
    func selectedModel(with id: UUID)
}

final class CollectionViewCellBuilder {
    private let pepeBuilder = PepeBuilder()
    
    weak var delegate: CollectionViewCellBuilderProtocol?
        
    func registerCellsFor(collectionView: CollectionView) {
        collectionView.register(PepeCollectionViewCell.self, forCellWithReuseIdentifier: PepeCollectionViewCell.description())
    }
    
    func collectionViewModel(for model: PepesModel) -> CollectionView.ViewModel {
        var pepes = model.pepes
        pepes.sort(by: { $0.pepe.name < $1.pepe.name })
        
        pepeBuilder.model = pepes.map({PepeCollectionViewCell.ViewModel(id: $0.id, imageName: $0.pepe.name)})
        
        var viewModel = CollectionView.ViewModel()
        viewModel.cellDequeue.append(contentsOf: Array(repeating: pepeBuilder, count: pepes.count))
        viewModel.cellDisplayer.append(contentsOf: Array(repeating: pepeBuilder, count: pepes.count))
        viewModel.cellInteractor.append(contentsOf: Array(repeating: pepeBuilder, count: pepes.count))
        
        pepeBuilder.selectedModel = { [weak self] uuid in
            self?.delegate?.selectedModel(with: uuid)
        }
        
        return viewModel
    }
}

private final class PepeBuilder: CollectionViewDequeueProtocol, CollectionViewCellDisplayProtocol, CollectionViewCellInteractionProtocol {
    var model = [PepeCollectionViewCell.ViewModel]()
    
    var selectedModel: ((UUID) -> Void)?
    
    func dequeue(for collectionView: UICollectionView,_ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PepeCollectionViewCell.description(), for: indexPath) as! PepeCollectionViewCell
        return cell
    }
    
    func willDisplayCell(at indexPath: IndexPath, for cell: UICollectionViewCell) {
        let myCell = cell as! PepeCollectionViewCell
        myCell.setup(with: model[indexPath.item])
    }
    
    func selectedItem(at indexPath: IndexPath) {
        print("Selected cell index: \(indexPath.item)")
        selectedModel?(model[indexPath.item].id)
    }
}
