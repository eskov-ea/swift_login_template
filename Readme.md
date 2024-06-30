# EN

#### Login Template is an app in Swift to be reused and scalable in new projects.

#### In this project I use:
    - SwiftUI;
    - Keychain;
    - Network calls;
    
###### The app has enough room to improve e.g. it can be implemented error handling service.

# RU

#### Login Template - шаблон регистрации-авторизации, который может быть использован, расширен в следующих проектах.

#### В приложении используется:
    - SwiftUI;
    - Keychain;
    - Network calls;
    
###### Данное приложение содержит возможности для улучшения, например, сервис обработки ошибок, таких как HTTP ошибок, ошибок соединения и тд.

###### В приложении не используются реальные запросы к серверу, регистрация и авторизация. Используются фейковые запросы, в большинстве реализованные таймером. Регистрация сохраняет данные в память в рантайме - RuntimeAccountStorage. После регистрации может быть выполнена авторизация. После перезапуска приложения данные будут потеряны. OTP код - любая комбинация цифр.
