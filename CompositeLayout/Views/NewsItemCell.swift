//
//  NewsItemCell.swift
//  CompositeLayout
//
//  Created by gaurav on 19/02/21.
//

import UIKit

class NewsItemCell: UICollectionViewCell {
  static let reuseIdentifer = "news-item-cell-reuse-identifier"
  let titleLabel = UILabel()
  let bodyLabel = UILabel()
  let sourceName = UILabel()
  let postedDate = UILabel()
  let featuredPhotoView = UIImageView()
  let contentContainer = UIView()

  var title: String? {
    didSet {
      configure()
    }
  }
    
  var body: String? {
      didSet {
        configure()
      }
    }
    
   var source:String?{
        didSet {
          configure()
    }
   }

    var publishedDate:String?{
        didSet {
          configure()
    }
  }

  var featuredPhotoURL: URL? {
    didSet {
      configure()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewsItemCell {
  func configure() {
    contentContainer.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(featuredPhotoView)
    contentView.addSubview(contentContainer)
    featuredPhotoView.translatesAutoresizingMaskIntoConstraints = false
    if let featuredPhotoURL = featuredPhotoURL {
        DispatchQueue.global(qos: .background).async{
            let data = try? Data(contentsOf: featuredPhotoURL)
            DispatchQueue.main.async {
                if let data = data{
                    self.featuredPhotoView.image = UIImage(data: data)
                }
                
               }
        }
        
    }
    featuredPhotoView.contentMode = .scaleAspectFill
    featuredPhotoView.layer.cornerRadius = 4
    featuredPhotoView.clipsToBounds = true
    contentContainer.addSubview(featuredPhotoView)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.text = title
    titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    titleLabel.numberOfLines = 2
    titleLabel.adjustsFontForContentSizeCategory = true
    contentContainer.addSubview(titleLabel)
    
    bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    bodyLabel.text = body
    bodyLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    bodyLabel.numberOfLines = 2
    bodyLabel.adjustsFontForContentSizeCategory = true
    bodyLabel.textColor = .placeholderText
    contentContainer.addSubview(bodyLabel)
    
    postedDate.translatesAutoresizingMaskIntoConstraints = false
    postedDate.text = publishedDate
    postedDate.font = UIFont.preferredFont(forTextStyle: .footnote)
    postedDate.adjustsFontForContentSizeCategory = true
    postedDate.textColor = .placeholderText
    contentContainer.addSubview(postedDate)
    
    sourceName.translatesAutoresizingMaskIntoConstraints = false
    sourceName.text = source
    sourceName.font = UIFont.preferredFont(forTextStyle: .footnote)
    sourceName.adjustsFontForContentSizeCategory = true
    sourceName.textColor = .placeholderText
    contentContainer.addSubview(sourceName)


    let spacing = CGFloat(10)
    NSLayoutConstraint.activate([
      contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
      contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      featuredPhotoView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
      featuredPhotoView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
      featuredPhotoView.topAnchor.constraint(equalTo: contentContainer.topAnchor),

      titleLabel.topAnchor.constraint(equalTo: featuredPhotoView.bottomAnchor, constant: spacing),
      titleLabel.leadingAnchor.constraint(equalTo: featuredPhotoView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: featuredPhotoView.trailingAnchor),

      bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      postedDate.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor),
      postedDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      postedDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        
      sourceName.topAnchor.constraint(equalTo: postedDate.bottomAnchor),
      sourceName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      sourceName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      sourceName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
