//
//  CompositeLayoutController.swift
//  CompositeLayout
//
//  Created by gaurav on 19/02/21.
//

import UIKit

fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<CompositeLayoutController.Section, News>
fileprivate typealias NewsDataSource  = UICollectionViewDiffableDataSource<CompositeLayoutController.Section, News>

class CompositeLayoutController: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    let cellId = "cellId"

    private var newsResource = [News]()
    private var verticalResource = [News]()
    private var dataSource: NewsDataSource!
    private var newscollectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News Source"
        createData()
        configureCollectionView()
        configureDataSource()
    }
    
}

//MARK: - Collection View Setup
extension CompositeLayoutController {
    
    func configureCollectionView() {
      let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
      view.addSubview(collectionView)
      collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      collectionView.backgroundColor = .systemBackground
      collectionView.delegate = self
      collectionView.register(NewsItemCell.self, forCellWithReuseIdentifier: NewsItemCell.reuseIdentifer)
      collectionView.register(
        HeaderView.self,
        forSupplementaryViewOfKind: CompositeLayoutController.sectionHeaderElementKind,
        withReuseIdentifier: HeaderView.reuseIdentifier)
        newscollectionView = collectionView
    }
    
    func generateLayout() -> UICollectionViewLayout {
       let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
        let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500

        let sectionLayoutKind = Section.allCases[sectionIndex]
        switch (sectionLayoutKind) {
        case .horizontal: return self.newHorizontalLayout(isWide: isWideView)

        case .vertical: return self.generateVerticalLayout(isWide: isWideView)
        }
      }
      return layout
    }
    
    private func createData() {
        newsResource.append(News(title: "Honda says CEO Hachigo to step down, replaced by R&D chief Mibe - Reuters", titleStory: "Honda Motor Co said on Friday that Chief Executive Officer Takahiro Hachigo would step down, handing over the reins to the head of the automaker's research and development arm, Toshihiro Mibe, on April 1.", publishedDate: "3 days ago", sourceName: "RTE", imgUrl: URL(string: "https://static.reuters.com/resources/r/?m=02&d=20210219&t=2&i=1552111447&r=LYNXMPEH1I08K&w=800")!))
        
        newsResource.append(News(title: "Biden to lay out his foreign policy at G-7, Munich summit", titleStory: "Joe Biden will make his first big appearance on the global stage as president on Friday, offering Group of Seven allies and other foreign leaders a glimpse...", publishedDate: "5 days ago", sourceName: "Reuters", imgUrl: URL(string:"https://s.yimg.com/ny/api/res/1.2/jtV3SJOg10Ha69a1Kzsyig--/YXBwaWQ9aGlnaGxhbmRlcjt3PTIwMDA7aD0xMzMz/https://s.yimg.com/uu/api/res/1.2/6B67TlRUSLOyOKRsrcEgcw--~B/aD0zOTAwO3c9NTg1MDthcHBpZD15dGFjaHlvbg--/https://media.zenfs.com/en/ap.org/1c6cdfedc8809d327a79e02efb5d92c0")!))
        
        newsResource.append(News(title: "FOREX-Dollar nurses losses after jobs data mars recovery narrative; sterling buoyant - Reuters", titleStory: "* Dollar continues to take cues from economy instead of sentiment * Ethereum marks new record high while bitcoin takes a breather * Graphic: World FX rates https://tmsnrt.rs/2RBWI5E By Kevin Buckland TOKYO, Feb 19 (Reuters) - The U.S. dollar paused on Friday …", publishedDate: "1 day ago", sourceName: "Motley Fool", imgUrl: URL(string:"https://s1.reutersmedia.net/resources_v2/images/rcom-default.png?w=800")!))
        
        newsResource.append(News(title: "If You'd Invested $10,000 in ARK Invest Founder Cathie Wood's Favorite Stock This Time Last Year, Here's What It'd Be Worth Now", titleStory: "The star investor has high words of praise for the holding that makes up so much of ARK Invest's active ETF portfolios.", publishedDate: "2 days ago", sourceName: "FXStreet", imgUrl: URL(string:"https://g.foolcdn.com/editorial/images/614001/bear-bull-gettyimages-503887289.jpg")!))
        
        newsResource.append(News(title: "Elon Musk defends Tesla bitcoin move, says token less dumb than cash", titleStory: "Tesla, Elon Musk's car company, took both the corporate world and the cryptocurrency space by storm when it announced this month it had put $1.5 billion of cash into Bitcoin.", publishedDate: "2 days ago", sourceName: "FXStreet", imgUrl: URL(string:"https://img.etimg.com/thumb/msid-81103987,width-1070,height-580,imgsize-95316,overlay-ettech/photo.jpg")!))
    

      }

    func generateVerticalLayout(isWide: Bool) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let groupHeight = NSCollectionLayoutDimension.fractionalWidth(isWide ? 0.25 : 0.5)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: groupHeight)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: isWide ? 4 : 2)

      let headerSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(44))
        
      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
        layoutSize: headerSize,
        elementKind: CompositeLayoutController.sectionHeaderElementKind,
        alignment: .top)

      let section = NSCollectionLayoutSection(group: group)
      section.boundarySupplementaryItems = [sectionHeader]

      return section
    }
    
    private func newHorizontalLayout(isWide: Bool) -> NSCollectionLayoutSection {
          let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalWidth(2/3))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)

          let groupFractionalWidth = isWide ? 0.475 : 0.95
          let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
          let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
          group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

          let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(44))
          let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: CompositeLayoutController.sectionHeaderElementKind, alignment: .top)

          let section = NSCollectionLayoutSection(group: group)
          section.boundarySupplementaryItems = [sectionHeader]
          section.orthogonalScrollingBehavior = .groupPaging

          return section
        }
   
    private func configureDataSource() {
            dataSource = UICollectionViewDiffableDataSource
              <Section, News>(collectionView: newscollectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath, newsItem: News) -> UICollectionViewCell? in
              
                
                guard let cell = collectionView.dequeueReusableCell(
                          withReuseIdentifier: NewsItemCell.reuseIdentifer,
                  for: indexPath) as? NewsItemCell else { fatalError("Could not create new cell") }
                  cell.featuredPhotoURL = newsItem.imgUrl
                  cell.title = newsItem.title
                  cell.body = newsItem.titleStory
                  cell.source = newsItem.sourceName
                  cell.publishedDate = newsItem.publishedDate
                  return cell
            }
        
            dataSource.supplementaryViewProvider = { (
              collectionView: UICollectionView,
              kind: String,
              indexPath: IndexPath) -> UICollectionReusableView? in

              guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as? HeaderView else { fatalError("Cannot create header view") }

              supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
              return supplementaryView
            }
            let snapshot = snapshotForCurrentState()
    
            dataSource.apply(snapshot, animatingDifferences: false)

        }
    
  

}


    


//MARK: - Collection View Delegates
extension CompositeLayoutController: UICollectionViewDelegate  {
    
   fileprivate func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, News> {
    var snapshot = NSDiffableDataSourceSnapshot<Section, News>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(self.newsResource, toSection: .horizontal)
    snapshot.appendItems(self.newsResource, toSection: .vertical)
    return snapshot
    }
    
    fileprivate enum Section:String, CaseIterable {
        case horizontal = "Horizontal Layout"
        case vertical = "Vertical Layout"
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         collectionView.deselectItem(at: indexPath, animated: true)
         guard let news = dataSource.itemIdentifier(for: indexPath) else { return }
         print(news)
     }
    
}

