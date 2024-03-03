//
//  File.swift
//  
//
//  Created by Daniel Watson on 23.02.2024.
//

import Foundation
import SwiftUI
import MiseboxiOSGlobal

public struct MiseboxUserProfile<DashboardVM: DashboardViewModelProtocol & ObservableObject>: View {
    @ObservedObject var vm: DashboardVM
    @StateObject var nav = MiseboxUserProfileViewNavigation()
    @EnvironmentObject var miseboxUser: MiseboxUserManager.MiseboxUser
    @EnvironmentObject var miseboxUserProfile: MiseboxUserManager.MiseboxUserProfile
    @Binding var navigationPath: NavigationPath
    
    public init(vm: DashboardVM, navigationPath: Binding<NavigationPath>) {
        self._vm = ObservedObject(wrappedValue: vm)
        self._nav = StateObject(wrappedValue: MiseboxUserProfileViewNavigation())
        self._navigationPath = navigationPath
    }

    public var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                UserCardView(
                    photoVM: PhotosPickerVM(
                        path: "misebox-users/avatars/\(miseboxUser.miseCODE)",
                        documentId: miseboxUser.id,
                        collectionName: miseboxUser.collection
                    ),
                    vm: ProfileDashboardVM(
                        miseboxUserManager: vm.miseboxUserManager,
                        signOutAction: vm.signOut
                    )
                )
                    VStack {
                    ScrollView {
                        ForEach(MiseboxUserProfileViewNavigation.ProfileSections.allCases) { section in
                            navigationLink(for: section)
                                .listStyle()
                            Divider()
                        }
                    }
                }
                .sectionStyle(borderColor: .purple)
                signOutButton
            }
            .padding()
        }
        //.navigationDestination(for: MiseboxUserProfileViewNavigation.ProfileSections.self) { section in
       //     switch section {
           // case .basicInfo: BasicInfoView(vm: vm)
           // case .mediumInfo: MediumInfoView(vm: vm)
           // case .advancedInfo: AdvancedInfoView(vm: vm)
          //  }
       // }
        .pageStyle(backgroundColor: .purple.opacity(0.1))
    }

    private var signOutButton: some View {
        
        CircleButton(iconType: .system("rectangle.portrait.and.arrow.right"), size: 50, background: .purple.opacity(0.2), foregroundColor: .purple, strokeColor: .purple, action: {
            Task {
                await vm.signOut()
                miseboxUser.resetFields()
                miseboxUserProfile.resetFields()
            }
        })
        .padding(.vertical)
    }

    @ViewBuilder
    private func navigationLink(for section: MiseboxUserProfileViewNavigation.ProfileSections) -> some View {
        Button {
            navigationPath.append(section)
        } label: {
            HStack {
                
                Image(systemName: section.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.purple)

                Text(section.rawValue)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Set a minimum height for easier tapping
        }
        .buttonStyle(PlainButtonStyle()) // Remove button's default styling
        .contentShape(Rectangle()) // Ensure the touch area covers the entire button space
    }

}
