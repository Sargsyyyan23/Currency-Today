//
//  HomeTableViewCell.swift
//  Currency Today
//
//  Created by Student on 19.07.25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .systemTeal
        return view
    }()
    
    private let iconImage: UIImageView = {
        let image =  UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        return image
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.textColor = .systemTeal
        title.font = .systemFont(ofSize: 20, weight: .bold)
        return title
    }()
    
    private let currencyTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.textColor = .systemTeal
        return title
    }()
    
    private let courseTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.textColor = .systemTeal
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImage)
        contentView.addSubview(title)
        contentView.addSubview(currencyTitle)
        contentView.addSubview(courseTitle)
        contentView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 10
        iconContainer.frame = CGRect(x: 15,
                                     y: 5,
                                     width: size,
                                     height: size)
        let imageSize: CGFloat = size/1.5
        iconImage.frame = CGRect(x: (size - imageSize)/2,
                                 y: (size - imageSize)/2,
                                 width: imageSize,
                                 height: imageSize)
        title.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: -10,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
        currencyTitle.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                                     y: 10,
                                     width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                                     height: contentView.frame.size.height)
        courseTitle.frame = CGRect(x: contentView.frame.size.width - 60,
                                   y: 0,
                                   width: contentView.frame.size.width - 100 -
                                    iconContainer.frame.size.width,
                                   height: contentView.frame.size.height)
    }
    public func configure(with modal: CourseOption){
        iconContainer.backgroundColor = modal.backgroundcolor
        iconImage.image = modal.backgroundimage
        title.text =  modal.name
        currencyTitle.text = modal.currency
        courseTitle.text = modal.course
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

