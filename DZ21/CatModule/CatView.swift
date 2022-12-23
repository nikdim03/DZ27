//
//  CatView.swift
//  DZ21
//
//  Created by Dmitriy on 12/23/22.
//

import UIKit

//view controller
//protocol
//ref to presenter

class LoadingView: UIView {
    let rhombusLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createRhombus()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createRhombus() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 50, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 50))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 0, y: 50))
        path.closeSubpath()
        
        // Set the path of the shape layer
        rhombusLayer.path = path
        
        // Set the properties of the shape layer
        rhombusLayer.fillColor = UIColor.blue.withAlphaComponent(0).cgColor
        rhombusLayer.strokeColor = UIColor.blue.cgColor
        rhombusLayer.lineWidth = 5
        rhombusLayer.position = self.center
        rhombusLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Add the shape layer to the view's layer hierarchy
        self.layer.addSublayer(rhombusLayer)
        
        // Create the flipping animation
        let flipAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        flipAnimation.fromValue = 0
        flipAnimation.toValue = CGFloat.pi
        flipAnimation.duration = 1.0
        flipAnimation.repeatCount = .greatestFiniteMagnitude
        flipAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        flipAnimation.fillMode = .backwards
        flipAnimation.isRemovedOnCompletion = false
        flipAnimation.valueFunction = CAValueFunction(name: .rotateZ)
        
        // Add the flipping animation to the layer
        rhombusLayer.add(flipAnimation, forKey: "flipAnimation")
        
    }

}


protocol CatListView {
    var presenter: CatsListPresenter? { get set }
    func update(with cats: [Cat])
    func update(with error: String)
    func handleButtonTap()
}

class CatViewController: UIViewController, CatListView {
    @IBOutlet weak var collectionView: UICollectionView!
    let rhombusLayer = CAShapeLayer()
    let loadingView = LoadingView()
    var presenter: CatsListPresenter?
    var cats = [Cat]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CatsApp"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Present", style: .plain, target: self, action: #selector(handleButtonTap))
        let flowLayout = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        flowLayout.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flowLayout)
        NSLayoutConstraint.activate([
            flowLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flowLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            flowLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            flowLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        self.collectionView = flowLayout
        
        // Add the loading view to the view hierarchy
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Perform some long-running task
        DispatchQueue.global().async {
            // simulate a long-running task
            sleep(3)
            
            // remove the loading view from the view hierarchy when the task is finished
            DispatchQueue.main.async {
                self.loadingView.removeFromSuperview()
            }
        }
    }
    func update(with cats: [Cat]) {
        DispatchQueue.main.async {
            self.cats = cats
            self.collectionView.register(for: CatCell.self)
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            
            self.collectionView.dragInteractionEnabled = true
            self.collectionView.reorderingCadence = .fast
            self.collectionView.dropDelegate = self
            self.collectionView.dragDelegate = self
            self.collectionView.reloadData()
        }
    }
    func update(with error: String) {
        super.title = error
    }
    @objc func handleButtonTap() {
        presenter?.handleButtonTap()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(for: CatCell.self, for: indexPath)
        cell.update(with: cats[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDragDelegate
extension CatViewController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
}

//MARK: - UICollectionViewDropDelegate
extension CatViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag, destinationIndexPath != nil {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        switch coordinator.proposal.operation {
        case .move:
            reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
        default:
            break
        }
    }
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let items = coordinator.items
        if items.count == 1, let item = items.first,
           let sourceIndexPath = item.sourceIndexPath {
            collectionView.performBatchUpdates ({
                let source = cats[sourceIndexPath.item]
                cats.remove(at: sourceIndexPath.item)
                cats.insert(source, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}


class CatCell: UICollectionViewCell {
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 3
        self.contentView.layer.borderColor = UIColor.purple.cgColor
    }
    
    func update(with cat: Cat){
        self.catLabel.text = cat.name
        self.catImage.image = UIImage(named: cat.imageName)
    }
}
