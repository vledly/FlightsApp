//
//  FlightsViewController.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 18.08.2022.
//

import UIKit

final class FlightsViewController: BaseViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, FlightsItemModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, FlightsItemModel>
    
    private let collectionView: UICollectionView = {
        UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    }()
    
    private var dataSource: DataSource?
    
    override var viewForState: HasStateWrapperView { collectionView }
    
    var cancellables = Cancellables()
    
    let viewModel: FlightsViewModel

    init(viewModel: FlightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        binding()
        viewModel.loadFilghts()
    }
}

private extension FlightsViewController {
    func setup() {
        view.backgroundColor = .white

        collectionView.register(UINib(nibName: "FlightItemCell", bundle: nil), forCellWithReuseIdentifier: "FlightItemCell")
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        setupDataSource()
    }

    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(500))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(500))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.interItemSpacing = .fixed(10)
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)

            return section
        }
        return layout
    }

    func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightItemCell", for: indexPath) as? FlightItemCell
                cell?.configure(item)
                return cell
        })
    }

    func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.viewModels)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Binding
    
    func binding() {
        viewModel.state
            .sink { [weak self] value in
                self?.hideState()

                switch value {
                case .initial:
                    break
                case .loading:
                    self?.showState(type: .loading)
                case .empty:
                    self?.showState(type: .empty)
                case .loaded:
                    self?.updateSections()
                case .error(let error):
                    self?.showState(type: .error(error))
                }
            }.store(in: &cancellables)
    }
}

