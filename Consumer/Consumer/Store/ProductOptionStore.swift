//
//  ProductOptionStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/24/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class ProductOptionStore: Store<ProductOption> {
    static let instance = ProductOptionStore()
    
    override func records() -> [ProductOption] {
        let query: SFQuerySpec = SFQuerySpec.newAllQuerySpec(ProductOption.objectName, withOrderPath: ProductOption.orderPath, with: .descending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(ProductOption.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return ProductOption.from(results)
    }
    
    func options(_ forProduct:Product) -> [ProductOption]? {
        guard let productID = forProduct.productId else {return nil}
        let query = SFQuerySpec.newExactQuerySpec(ProductOption.objectName, withPath: ProductOption.Field.configuredProduct.rawValue, withMatchKey: productID, withOrderPath: ProductOption.orderPath, with: .ascending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(ProductOption.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return ProductOption.from(results)
    }
}
