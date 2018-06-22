/*
	File:		debugger-misc.dcl

	Version:	1.1

	Content:	Trace parameters (apart from rules and texts)

	Release notes:

		1.1 (2016/03/04)		
			1) new instance DEBUGGER_PARAM

		1.0 (2016/02/28)		
			1) divide old debugger.dcl in several files
		
*/


// ----------------------------------------------------------------------
// ----------   More useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_MISC

		/* the main steps of the Yseop Engine internal workflow (methods open, read, process,
		  write, close for the class RequestManager) are traced 
		*/
//--> internalWorkflow                      true

		/* for new engine versions
		   as internalWorkflow but with more intermediate steps traced
		*/
//--> deepInternalWorkflow                  true

		/* the main steps of the usecase processes are traced */
//--> usecases								true

		/* when the methods evaluadeGender or evaluateNumber (for the class Text) returns null, a trace is generated. */
//--> failureEvaluateGenderNumber			true

		/* If the value is:
			_ALL:
				All the KB modifications (creation of object, setting of variables, etc)
				are traced
			_RULE_NOTIFICATION:
				All the KB modifications within execution of rules are traced
		*/
//--> kBChanges								_RULE_NOTIFICATION

		/* All the object creations are traced */
//--> newSymbolicObjects					true

		/* All the add to collection operations are traced */
//--> addToCollection						true

; // DEBUGGER_KB_TRACE_MISC


// ----------------------------------------------------------------------
// ------------ Less useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_MISC
//--> conditions
//--> endActions
//--> logActionsSourceCode
//--> logDeveloppedTreeReadingTrees
//--> logIdentifiers
//--> logInstanciateTreeModel
//--> logMultipleOccurrencesReadingTrees
//--> logValues								true
//--> savepointChanges
//--> startActions
//--> startFunctions
//--> startMethods
//--> triggers

		// All the automatic cloning operations are traced
//--> automaticCloning						true // default value
; // DEBUGGER_KB_TRACE_MISC


complete DEBUGGER_MISC_LOG

		/*  Specify the log level for the explicit logs in the knowledge base. Explicit logs are user defined logs
			using the functions logXX (e.g. logProperties, logEval, logChanges,  logLookups, tags \\logXX..).
			The user log level can be different from the project log level but must remain inferior or equal to it. 
		*/
//--> userLoglevel			_TRACE

		/* If the value is defined, you can precise a log level, for the consol window, different from the 
		   log level of the project but necessarly less or equal
		*/
//--> consoleOutputLevel	_TRACE

		
		/* If the value is defined, you can precise a log level, for yengine.log file, different from the 
		   log level of the project but necessarly less or equal		
		   For example, the value _TRACE force all the traces in the file yEngine.log even within an Yseop Manager session
		   (in the addition to section <y:logging> of the Xml output) 
		*/
//--> fileOutputLevel		_TRACE

//--> useTextualizationInYengineLog	true

		/*  If true, the log file, if it's generated, is closed after each writing opertion.
			Warning : this mode slow down the program, its only utility is, in case of system crash, to access to the last log executed.
		*/
//--> closeLogFileAfterWrite	false

		/* this operation precises if there is a log is within the XML produced by the write method of the RequestManager class.
		   If the the value is null (it's the default case), the decision is made by the engine regarding the context
		   (true if it's a server mode or batch mode that uses instance of the class RequestManager)
		*/
//--> requestManagerOutput	true

//--> logWidgetIdentifier		true

		/* All the load of XmlReferentials are traced */
//--> logReferentials			true // default value

; // DEBUGGER_MISC_LOG



// ----------------------------------------------------------------------
// ------------ Less useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_ERROR_LOG

//--> logFullSourceFileName			false // default value

		/* 
			_NEVER
				xx

			_WARNING
				xx
			
			_NO_FATAL_ERROR
				xx

			_FATAL
				xx
		*/
//--> showStackIfSeverity			//_NEVER
									//_WARNING
									//_NO_FATAL_ERROR
									//_FATAL

//--> showEngineStackIfErrorPrefix	"W64"

//--> hideStackOnAssert				false // default value
//--> fatalOnWarning				false // default value
//--> continueOnFatalError			false // default value
//--> showStackOnlyFirst			false // default value
//--> stackSizeOnFatalError			<integer>
//--> textStackSizeOnFatalError		<integer>

; // DEBUGGER_ERROR_LOG

	
complete DEBUGGER_PARAM
//--> valuesInStackLog			true // default value
//--> internalNameInStackLog	false // default value
//--> extendedNameInStackLog	true // default value. yengine >= 6.0.0.RC30
//--> saveStack					false // default value
//--> unifiedView				false // default value
//--> stopOnConsoleMessage		false // default value
;
