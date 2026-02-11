# Flutter Template
自用开发模板

## 架构说明
项目采用 MVVM 与 Clean Architecture 相结合的分层架构

## 第三方库
| 模块     | 库                                                                                                                     |
| -------- | ---------------------------------------------------------------------------------------------------------------------- |
| 状态管理 | [bloc](https://pub.dev/packages/bloc), [flutter_bloc](https://pub.dev/packages/flutter_bloc)                           |
| 依赖注入 | [get_it](https://pub.dev/packages/get_it)                                                                              |
| 数据持久 | [shared_preferences](https://pub.dev/packages/shared_preferences)                                                      |
| 架构约束 | [meta](https://pub.dev/packages/meta)                                                                                  |
| 路由管理 | [go_router](https://pub.dev/packages/go_router)                                                                        |
| 网络请求 | [dio](https://pub.dev/packages/dio)                                                                        |
| 国际化   | [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/), [intl](https://pub.dev/packages/intl) |

## 路由管理
由 `AppRouter` 类使用 [go_router](https://pub.dev/packages/go_router) 统一调度

## 全局状态管理
项目包含多个全局的 Cubit，它们在 `injection_container.dart` 统一被注册为单例并注入

- **ThemeCubit**  
  管理应用的主题模式（亮色 / 暗色 / 跟随系统）

- **LocaleCubit**  
  管理多语言环境切换  

## 基类封装
对通用逻辑的抽象

- **BaseWidget**  
  封装了常用的功能

- **BaseBloc**  
  扩展了标准 `Bloc`，引入了单次通知机制（Effect Stream）

## 拓展模块
使用 `Extension`
- **BuildContextExtension**  
  封装对 `BuildContext` 的常用访问操作，例如将 `Theme.of(context)` 简化为 `context.theme`
