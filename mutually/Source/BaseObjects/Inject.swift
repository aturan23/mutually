//
//  Inject.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Swinject
import SwinjectAutoregistration
import Moya
import Alamofire

enum Inject {
    static var depContainer: Container = buildDefaultDepContainer()
    static func buildDefaultDepContainer() -> Container {
        let container = Container()
        return container
            .registerStorages()
            .registerNetworking()
            .registerServices()
            .registerModules()
            .registerCoordinators()
    }
}

extension Container {
    
    func registerStorages() -> Self {
        register(UserDefaults.self) { _ in UserDefaults.standard }
        register(FileManager.self) { _ in FileManager.default }
        return self
    }
    
    func registerNetworking() -> Self {
        if let reachabilityManager = NetworkReachabilityManager() {
            register(NetworkReachabilityChecking.self) { _ in reachabilityManager }
        }
        autoregister(
            SessionTrackerProtocol.self,
            initializer: SessionTracker.init(rootController:userDefaults:authorizationService:)
        ).inObjectScope(.container)
        return registerMoyaPlugins()
    }
    
    func registerMoyaPlugins() -> Self {
        register(NetworkLoggerPlugin.self) { _ in
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging)
        }
        register(AuthorizationTokenPlugin.self) { (res: Resolver) in
            AuthorizationTokenPlugin(registeredUserHandler: res.resolve(RegisteredUserHandlerProtocol.self))
        }
        autoregister(DefaultPlatformPlugin.self, initializer: DefaultPlatformPlugin.init)
        return self
    }
    
    func registerServices() -> Self {
//        register(FeatureManagerProtocol.self) { _ in
//            let remoteConfigService: RemoteConfigServiceProtocol = RemoteConfigService(firebaseConfig: RemoteConfig.remoteConfig())
//            remoteConfigService.refetch()
//            let featureManager = FeatureManager(remoteConfig: remoteConfigService)
//            return featureManager
//        }
        register(DataServiceProtocol.self) { _ in DataService() }.inObjectScope(.container)
        register(RegisteredUserHandlerProtocol.self) { (res: Resolver) in
            RegisteredUserHandler(storage: res.resolve(UserDefaults.self)!)
        }.inObjectScope(.container)
        
        func resolveDefaultPlugins(resolver: Resolver) -> [PluginType] {
            let optionalPlugins: [PluginType?] = [
                resolver.resolve(NetworkLoggerPlugin.self),
                resolver.resolve(AuthorizationTokenPlugin.self),
                resolver.resolve(DefaultPlatformPlugin.self)]
            return optionalPlugins.compactMap { $0 }
        }
        
        register(InboxServiceProtocol.self, factory: { (res: Resolver) in
            let provider = NetworkDataProvider<InboxTarget>(
                networkReachibilityChecker: res.resolve(NetworkReachabilityChecking.self),
                plugins: resolveDefaultPlugins(resolver: res))
            return InboxService(
                dataProvider: provider,
                dataService: res.resolve(DataServiceProtocol.self),
                authService: res.resolve(AuthorizationServiceProtocol.self))
        })
        register(ImageServiceProtocol.self) { (res: Resolver) in
            let provider = NetworkDataProvider<ImageTarget>(
                networkReachibilityChecker: res.resolve(NetworkReachabilityChecking.self),
                plugins: resolveDefaultPlugins(resolver: res))
            return ImageService(dataProvider: provider)
        }
        
        register(AuthorizationServiceProtocol.self) { (res: Resolver) in
            let authProvider = NetworkDataProvider<AuthorizationTarget>(
                networkReachibilityChecker: res.resolve(NetworkReachabilityChecking.self),
                plugins: resolveDefaultPlugins(resolver: res))
            return AuthorizationService(
                dataProvider: authProvider,
                dataService: res.resolve(DataServiceProtocol.self),
                registeredUserHandler: res.resolve(RegisteredUserHandlerProtocol.self))
        }
        .inObjectScope(.container)
        .initCompleted { (res, authorizationService) in
            authorizationService.sessionTracker = res.resolve(SessionTrackerProtocol.self)
        }
        return self
    }
    
    func registerModules() -> Self {
        register(RegistrationModuleAssembly.self) { _ in
            RegistrationModuleAssembly(injection: self)
        }
        register(SetupPasscodeModuleAssembly.self) { _ in
            SetupPasscodeModuleAssembly(injection: self)
        }
        register(SignInModuleAssembly.self) { _ in
            SignInModuleAssembly(injection: self)
        }
        register(MainTabsModuleAssembly.self) { _ in
            MainTabsModuleAssembly(injection: self)
        }
        register(SmsVerificationModuleAssembly.self) { _ in
            SmsVerificationModuleAssembly(injection: self)
        }
        register(SlidingRequestModuleAssembly.self) { _ in
            SlidingRequestModuleAssembly(injection: self)
        }
        register(FullRequestModuleAssembly.self) { _ in
            FullRequestModuleAssembly(injection: self)
        }
        register(LaunchScreenModuleAssembly.self) { _ in
            LaunchScreenModuleAssembly(injection: self)
        }
        return self
    }
    
    func registerCoordinators() -> Self {
        register(RegistrationCoordinating.self) { (_: Resolver, window: UIWindow) in
            RegistrationCoordinator(window: window, injection: self)
        }
        return self
    }
}
