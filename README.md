
# Marvel APP - iOS

## Arrancando
Para poder iniciar el proyecto hay que tener instalado [Cocoapods](https://cocoapods.org/) y hacer un pod install para generar el workspace

## Estructura del proyecto
Hay 4 diretorios principales:
 - **Interface:** contiene los storyboards de la aplicación 
 - **Resources:** contiene el plist del target y XCAssets
 - **Source:** contiene el código de la aplicación
 - **Delegate:** los delegates de App y de Scene

### Estructura de la aplicación
Hay 4 directorios:

 - **Commons:** contiene fichero de constantes, widgets, modelo, extensiones y helpers
 - **Managers:** contiene singleton de conectividad
 - **Repositories:** contiene las llamadas a servicios
 - **Scenes:** contiene código de controladores y widgets

 ## Arquitectura
 Se ha usado la arquitectura VIP
 ```mermaid
graph LR
A[View] --> B[Interactor]  
B --> C[Presenter]
C --> A
B --> D[Repository]
D --> B
```

## Dependencias
Proyecto que usa las siguientes dependencias:

 1. AlamofireNetworkActivityLogger
 2. Kingfisher

 
