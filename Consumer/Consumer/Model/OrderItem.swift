//
//  OrderItem.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/9/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SmartStore

class OrderItem: Record, StoreProtocol {
    enum Field: String {
        case itemId = "Id"
        case orderId = "OrderId"
        case orderItemNumber = "OrderItemNumber"
        case quantity = "Quantity"
        case unitPrice = "UnitPrice"
        case pricebookEntry = "PricebookEntryId"
        case productId = "Product2Id"
        
        
        static let allFields = [itemId.rawValue, orderId.rawValue, orderItemNumber.rawValue, quantity.rawValue, unitPrice.rawValue, pricebookEntry.rawValue, productId.rawValue]
    }
    
    fileprivate(set) lazy var itemId: String? = data[Field.itemId.rawValue] as? String
    fileprivate(set) lazy var orderId: String? = data[Field.orderId.rawValue] as? String
    fileprivate(set) lazy var orderItemNumber: String? = data[Field.orderItemNumber.rawValue] as? String
    fileprivate(set) lazy var quantity: Int? = data[Field.quantity.rawValue] as? Int
    fileprivate(set) lazy var unitPrice: Float? = data[Field.unitPrice.rawValue] as? Float
    fileprivate(set) lazy var pricebookEntry: String? = data[Field.pricebookEntry.rawValue] as? String
    fileprivate(set) lazy var productId: String? = data[Field.productId.rawValue] as? String
    
    override static var indexes: [[String : String]] {
        return super.indexes + [
            ["path" : Field.itemId.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.orderId.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.orderItemNumber.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.quantity.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.unitPrice.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.pricebookEntry.rawValue, "type" : kSoupIndexTypeString],
            ["path" : Field.productId.rawValue, "type" : kSoupIndexTypeString]
            
        ]
    }
    
    static var objectName: String = "OrderItem"
    
    static var orderPath: String = Field.itemId.rawValue
    
    override static var readFields: [String] {
        return super.readFields + Field.allFields
    }
    override static var createFields: [String] {
        return super.createFields + Field.allFields
    }
    override static var updateFields: [String] {
        return super.updateFields + Field.allFields
    }
    
    static func selectFieldsString() -> String {
        return Field.allFields.map { return "{\(objectName):\($0)}" }.joined(separator: ", ")
    }
    
}
