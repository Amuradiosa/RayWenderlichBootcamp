/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class CompactViewController: UIViewController {
  
  enum Section {
    case main
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var dataSource: UICollectionViewDiffableDataSource<Section, Pokemon>!
  let items = PokemonGenerator.shared.generatePokemons()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    // Do any additional setup after loading the view.
  }
  
  func configureCollectionView() {
    let cell = UINib(nibName: PokemonCompactCell.reuseIdentifier, bundle: nil)
    collectionView.register(cell, forCellWithReuseIdentifier: PokemonCompactCell.reuseIdentifier)
    
    collectionView.collectionViewLayout = configureLayout()
    configureDataSource()
  }
  
  func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, Pokemon) -> UICollectionViewCell? in
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCompactCell.reuseIdentifier, for: indexPath) as? PokemonCompactCell else {
        fatalError("Cannot create new cell")
      }
      cell.populateCell(with: Pokemon)
      
      return cell
    })
    
    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(items)
    
    dataSource.apply(initialSnapshot, animatingDifferences: false)
    
  }
    
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
