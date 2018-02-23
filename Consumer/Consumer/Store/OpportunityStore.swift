//
//  OpportunityStore.swift
//  Consumer
//
//  Created by Nicholas McDonald on 2/22/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import Foundation
import SalesforceSwiftSDK
import SmartStore
import SmartSync

class OpportunityStore: Store<Opportunity> {
    static let instance = OpportunityStore()
    
    override func records() -> [Opportunity] {
        let query: SFQuerySpec = SFQuerySpec.newAllQuerySpec(Opportunity.objectName, withOrderPath: Opportunity.orderPath, with: .descending, withPageSize: 100)
        var error: NSError? = nil
        let results: [Any] = store.query(with: query, pageIndex: 0, error: &error)
        guard error == nil else {
            SalesforceSwiftLogger.log(type(of:self), level:.error, message:"fetch \(Opportunity.objectName) failed: \(error!.localizedDescription)")
            return []
        }
        return Opportunity.from(results)
    }
}
