//
//  ChangeTableViewCell.swift
//  Currency Today
//
//  Created by Student on 24.07.25.
//

import UIKit

class ChangeTableViewCell: UITableViewCell {

    static let identifier = "ChangeTableViewCell"
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImage)
        contentView.addSubview(title)
        
        accessoryType = .disclosureIndicator
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
    }
    
    public func configure(with modal: ChangeOption){
        iconContainer.backgroundColor = modal.backgroundColor
        iconImage.image = modal.backgroundImage
        title.text = modal.name
    }
}
