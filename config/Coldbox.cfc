component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Your app name here",
			eventName 				= "event",

			//Development Settings
			reinitPassword			= "",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "user.myaccount",
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "Main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "includes/helpers/ApplicationHelper.cfm",
			viewsHelper					= "",
			modulesExternalLocation		= [ "modules_app" ],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			controllerDecorator			= "",

			//Error/Exception Handling
			invalidHTTPMethodHandler = "",
			exceptionHandler		= "main.onException",
			onInvalidEvent			= "",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true,
			viewCaching				= true
		};

		// The CacheBox configuration structure DSL
		cacheBox = {
			// LogBox config already in coldbox app, not needed
			// logBoxConfig = "coldbox.system.web.config.LogBox", 
			
			// The defaultCache has an implicit name "default" which is a reserved cache name
			// It also has a default provider of cachebox which cannot be changed.
			// All timeouts are in minutes
			defaultCache = {
				objectDefaultTimeout = 120, //two hours default
				objectDefaultLastAccessTimeout = 30, //30 minutes idle time
				useLastAccessTimeouts = true,
				reapFrequency = 5,
				freeMemoryPercentageThreshold = 0,
				evictionPolicy = "LRU",
				evictCount = 1,
				maxObjects = 300,
				objectStore = "ConcurrentStore", //guaranteed objects
				coldboxEnabled = true
			},
			
			// Register all the custom named caches you like here
			caches = {
				// Named cache for all coldbox event and view template caching
				"template" : {
					provider = "coldbox.system.cache.providers.CacheBoxColdBoxProvider",
					properties = {
						objectDefaultTimeout = 120,
						objectDefaultLastAccessTimeout = 30,
						useLastAccessTimeouts = true,
						freeMemoryPercentageThreshold = 0,
						reapFrequency = 5,
						evictionPolicy = "LRU",
						evictCount = 2,
						maxObjects = 300,
						objectStore = "ConcurrentSoftReferenceStore" //memory sensitive
					}
				},
				"user" :
				{
					provider : 'modules.cbRedis.models.RedisColdboxProvider'
				    ,properties : {
				    	maxConnections : 10
						,defaultTimeoutUnit : "MINUTES"
						,objectDefaultTimeout : 30
			            ,opTimeout : 5000
				        ,timeoutExceptionThreshold : 5000
				        ,ignoreRedisTimeouts : true
						,bucket : "default"
						,server : "localhost:6379" // This can be an array
						,caseSensitiveKeys : true
						,updateStats : true
						,debug = false
						,dbIndex = 0
				    }
				}
			}		
		};

		// custom settings
		settings = {

		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "localhost,^127\.0\.0\.1"
		};

		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				//coldboxTracer = { class="coldbox.system.logging.appenders.ConsoleAppender" }
				logfile = {
					class="coldbox.system.logging.appenders.RollingFileAppender",
					properties={filePath="logs",
					fileName=coldbox.appname,
					autoExpand=true,
					fileMaxSize=2000,
					fileMaxArchives=2,
					async=true}
				}
			},
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			info = [ "coldbox.system" ]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{class="coldbox.system.interceptors.SES",
			 properties={}
			}
		];

		/*
		// flash scope configuration
		flash = {
			scope = "session,client,cluster,ColdboxCache,or full path",
			properties = {}, // constructor properties for the flash scope implementation
			inflateToRC = true, // automatically inflate flash data into the RC scope
			inflateToPRC = false, // automatically inflate flash data into the PRC scope
			autoPurge = true, // automatically purge flash data for you
			autoSave = true // automatically save flash scopes at end of a request and on relocations.
		};

		//Register Layouts
		layouts = [
			{ name = "login",
		 	  file = "Layout.tester.cfm",
			  views = "vwLogin,test",
			  folders = "tags,pdf/single"
			}
		];

		//Conventions
		conventions = {
			handlersLocation = "handlers",
			viewsLocation 	 = "views",
			layoutsLocation  = "layouts",
			modelsLocation 	 = "models",
			eventAction 	 = "index"
		};

		//Datasources
		datasources = {
			mysite   = {name="mySite", dbType="mysql", username="root", password="pass"},
			blog_dsn = {name="myBlog", dbType="oracle", username="root", password="pass"}
		};
		*/

	}

	/**
	* Development environment
	*/
	function development(){
		coldbox.customErrorTemplate = "/coldbox/system/includes/BugReport.cfm";

		cacheBox[ "caches" ][ "user" ] = {
			provider = "coldbox.system.cache.providers.CacheBoxColdBoxProvider",
			properties = {
				objectDefaultTimeout = 120,
				objectDefaultLastAccessTimeout = 30,
				useLastAccessTimeouts = true,
				freeMemoryPercentageThreshold = 0,
				reapFrequency = 5,
				evictionPolicy = "LRU",
				evictCount = 2,
				maxObjects = 300,
				objectStore = "ConcurrentSoftReferenceStore" //memory sensitive
			}
		};

		structAppend( coldbox, {
			handlerCaching:false,
			eventCaching:false,
			viewCaching:false
		}, true );
	}

}