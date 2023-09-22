//
// MyCreativeCollection
// Created by: itsjagnezi on 11/04/23
// Copyright (c) today and beyond
//

import QuickLook
import SwiftUI


struct CollectionsScreen: View {
	
	@State private var showingCreateSheet = false
	@State private var fileUrl: URL?
	@EnvironmentObject var viewModel: ViewModel
	
	var body: some View {
		ZStack {
			LinearGradient(colors: [Color.fridayDark, Color.fridayLight], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
				.ignoresSafeArea(.all)
			Group {
				if viewModel.collectionsLoading {
					VStack {
						ProgressView()
							.progressViewStyle(.linear)
						ProgressView()
							.progressViewStyle(.circular)
					}
				}
				
				if !viewModel.collectionsLoading && viewModel.collections.isEmpty {
					NothingHere(description: "collectionsScreen.emptyDescription")
				}
				
				if !viewModel.collectionsLoading && !viewModel.collections.isEmpty {
					VStack {
						List(viewModel.collections, id: \.id) { collection in
							NavigationLink(value: collection) {
								Text(collection.title)
							}
							.swipeActions(edge: .trailing) {
								Button(role: .destructive) {
									Task {
										try await	CollectionService.shared.deleteCollection(
											id: collection.id
										)
										let collections = try await CollectionService.shared.getAllCollections()
										viewModel.setCollectionsData(collections)
									}
								} label: {
									Label("common.delete", systemImage: "trash")
								}
							}
						}
						.refreshable {
							Task {
								let collections = try await CollectionService.shared.getAllCollections()
								viewModel.setCollectionsData(collections)
							}
						}
					}
				}
			}
		}
		.navigationTitle("collectionsScreen.screenTitle")
		.navigationBarBackButtonHidden()
		.navigationDestination(for: CollectionResponseData.self) { collection in
			CollectionScreen(collection: collection)
		}
		.toolbar {
			ToolbarItem(placement: .bottomBar) {
				ToolbarItemButton(toggleSomething: $showingCreateSheet, label: "common.newCollection")
			}
		}
		.sheet(isPresented: $showingCreateSheet) {
			CreateCollectionScreen()
		}
		.onAppear {
			print("run onAppear")
			Task {
				print("run onAppear TASK")
				let collections = try await CollectionService.shared.getAllCollections()
				viewModel.setCollectionsData(collections)
			}
		}
	}
}

struct CollectionsScreen_Previews: PreviewProvider {
	static let viewModel = ViewModel()
	
	static var previews: some View {
		NavigationStack {
			CollectionsScreen()
				.environmentObject(viewModel)
		}
		.navigationTitle("collectionsScreen.screenTitle")
		.navigationBarBackButtonHidden()
	}
}
