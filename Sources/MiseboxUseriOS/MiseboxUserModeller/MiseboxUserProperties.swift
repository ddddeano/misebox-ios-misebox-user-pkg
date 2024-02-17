//
//  File.swift
//  
//
//  Created by Daniel Watson on 25.01.24.
//

import Foundation
extension MiseboxUserManager {
    
    public var id: String {
        miseboxUser.id
    }
  
    public var miseCODE: String {
        miseboxUser.miseCODE
    }
    
    public var handle: String {
        miseboxUser.handle
    }
    
    public var name: String {
        miseboxUserProfile.fullName.first
    }
    public var fullName: String {
        let fullName = miseboxUserProfile.fullName
        return [fullName.first, fullName.middle, fullName.last].filter { !$0.isEmpty }.joined(separator: " ")
    }
    public var verified: Bool {
        return miseboxUser.verified
    }
    public var accountProviders: [String] {
        return miseboxUserProfile.accountProviders
    }
    public var userRoles: [UserRole] {
        return miseboxUser.userRoles
    }
    public var imageUrl: String {
        return miseboxUser.imageUrl
    }
    
    // EcoSystem Properties
    
    public var miseboxUserMotto: String {
        ecosystemData?.miseboxUserMotto ?? ""
    }
    
    public var chefMotto: String {
        ecosystemData?.chefMotto ?? ""
    }
    
    public var agentMotto: String {
        ecosystemData?.agentMotto ?? ""
    }
    
    public var recruiterMotto: String {
        ecosystemData?.recruiterMotto ?? ""
        
    }
}
