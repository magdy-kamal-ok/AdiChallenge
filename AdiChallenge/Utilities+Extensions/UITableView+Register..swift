//
//  UITableView+Register.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 25/03/2021.
//

import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in dequeue cell")
        }
        
        return cell
    }
    
    func registerHeaderNib<Header: UITableViewHeaderFooterView>(headerClass: Header.Type) {
        register(UINib(nibName: String(describing: Header.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: Header.self))
    }
    
    func dequeueHeader<Header: UITableViewHeaderFooterView>() -> Header {
        let identifier = String(describing: Header.self)
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header else {
            fatalError("Error in dequeue cell")
        }
        return header
    }
}
