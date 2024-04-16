//
//  MainTableViewCell.swift
//  RXSwiftVIPER
//
//  Created by Alisher Saideshov on 16.04.2024.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    // MARK: View setup
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Unknown"
        label.textColor = UIColor.gray
        return label
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup functions
    
    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: speciesLabel.topAnchor, constant: 0)
        ])
        
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speciesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            speciesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            speciesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 45).isActive = true
    }
    
    func setupLabels(name: String, species: String) {
        nameLabel.text = name
        speciesLabel.text = species
    }
}
