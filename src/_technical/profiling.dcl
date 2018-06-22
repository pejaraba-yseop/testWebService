/*
	File version: 1.1

	Release notes:
		1.1 (2015/12/O1)
			new instance DEBUGGER_DUMP_MEMORY
			many new comments

		1.0 (2015/11/24)
			initialization
*/

// -----------------------------------------------------------
// ------- General profiling settings        -----------------
// ------- (more useful parameters)        -------------------
// -----------------------------------------------------------

complete DEBUGGER_PROFILING

		/* Activates the trace of <yp:calls> */
//--> callsProfiling

		/* The most expensive texts in execution time are displayed in the section <yp:text-longest-duration>.
		If calcTextsLongestDurationRootOnly=true, only the inclusive texts are listed. */
//--> calcTextsLongestDuration					true

		/* If true, within the section <yp:text-longest-duration>, only the inclusive texts are listed. */
//--> calcTextsLongestDurationRootOnly			true

		/* The most expensive rules in execution time are displayed in the section <yp:rule-longest-duration> */
//--> calcRulesLongestDuration					true

		/* The most expensive functions and methods in execution time are displayed. 
		See also alternative profiling method: <yp:calls> section */
//--> calcMethodsAndFunctionsLongestDuration	true

		/* The most expensive texts in execution time are displayed in the section <yp:text-longest-duration>.
		If calcTextsLongestDurationRootOnly=true, only the inclusive texts are listed.*/
//--> calcRecursiveLongestDuration				true

		/* If true, the main memory counters are displayed: 1) For counter 'oav': list of
			"attributes that contributed most to the occupation of memory
			"2) For counter 'symbolic', list of classes of symbolic objects that contributed
			"the most to the memory usage of objects (use new and free) */
//--> calcGreatestMemoryCounters				true

		/* The time counters are performed for intermediate steps (in <yp:calls> section) */
//--> calcRecursiveEngineTimeCounters			true

; // DEBUGGER_PROFILING


complete DEBUGGER_DUMP_MEMORY

		/* Log .ct tables usages in the file yEngineMemory.log. */
//--> tablesSizes							true
;

// -----------------------------------------------------------
// ------- General profiling settings        -----------------
// ------- (less useful paramètres)        -------------------
// -----------------------------------------------------------

complete DEBUGGER_PROFILING

		/* Display the <yp:global> section. */
//--> logGlobalSection							true	// default value

		/* Display the <yp:workflow> section: log execution time details for each step of the class
		RequestManager treatments (open, read, process, write, close).*/
//--> logWorkflowSection						true 	// default value

		/* Generate a detailed log of the internal counters on main engine
		functionalities (e.g. text, rules, ...).*/
//--> logDetails								false 	// default value

		/* Display the KB step counters: usage of instruction stepCounter */
//--> useKBTimeCounters							true	// default value

		/* Display the KB step counters: usage of instruction stepCounter */
//--> useKBStepCounters							true	// default value

		/* Specify what engine time counters should be used.
		   If the value is:
			_NEVER:
				xx

			_STANDARD:
				xx

			_INTERNAL_HIGH_LEVEL:
				xx

			_INTERNAL_LOW_LEVEL:
				xx
		*/
//--> useEngineTimeCounters						_STANDARD	// default value

		/*  */
//--> engineTimeCountersOnAllCalls				true

		/* This option bounds the height of the stack displayed (by default, no maximum is imposed), "
		 in particular to avoid generating a stream falling into too much detail. In addition, can "
		also raise a temporary crash that should be above 18 (or 20, depending on the project) */
//--> callsStackSize

		/* Scales the internal table used by Yseop Engine to record calls (usage of <yp:call> section */
//--> callsTabSize								1000000 // default value

; // DEBUGGER_PROFILING


complete DEBUGGER_DUMP_MEMORY
		/* Dump symbolic objects heap operations in the file ycompilerMemory.log, yengineMemory.log or regenMemory.log depending on the program. */
//--> externalHeap								false

		/* Dump external stack operations like pushing and popping elements in the file ycompilerMemory.log,
		   yengineMemory.log or regenMemory.log depending on the program. The external stack is an alternative
		   to the program stack that allows to allocate memory in the program heap as if it was the program stack.
		   This is used, inter alia, to prevent program stack overflow. The macros EMPILE_KALLOCA(), DEF_TOP_ET_EMPILE_KALLOCA, DEPILE_KALLOCA(),
		   among others, are used to push and pop elements onto/off the stack.
		*/
//--> externalStack								false

		/* Log the stack peak for every entry in the external stack dump */
//--> externalStackPeak							false

		/* Add an entry in the external stack dump each time an element is pushed onto the stack. */
//--> externalStackPush							false

		/* Add an entry in the external stack dump each time an element is popped off the stack. */
//--> externalStackPop							false

		/* Log the engine source file and the line for every entry in the external stack dump. */
//--> externalStackEngineSourceFile							false

		/* */
//--> sizesOfObjectsInExternalHeap				false

		/* Close the memory log file after every write operation. This option is used to access the last logs after a crash. */
//--> closeFileAfterWrite						false

		/* Set the types of objects that will be dumped before the knowledge base execution or compilation. */
// --> startMode					//_WORDS
									//_LISTS,
									//_TABLES,
									//_NUMBERS,
									//_STRINGS,
									//_IDENTIFIERS,
									//_TRIGGERS,
									//_CLASSES,
									//_COMPONENTS,
									//_SYMBOLIC_OBJECTS,
									//_OAV


		/* Set the types of objects that will be dumped after the knowledge base execution or compilation. */
// --> endMode						//_WORDS
									//_LISTS,
									//_TABLES,
									//_NUMBERS,
									//_STRINGS,
									//_IDENTIFIERS,
									//_TRIGGERS,
									//_CLASSES,
									//_COMPONENTS,
									//_SYMBOLIC_OBJECTS,
									//_OAV


		/* Specify the level of details for dumping symbolic objects
		   If the value is:
			_WITH_ALL_PROPERTIES:
				xx

			_WITH_STORABLE_PROPERTIES:
				xx

			_WITHOUT_PROPERTIES:
				xx
		*/
//--> symbolicObjectsMode			//_WITH_ALL_PROPERTIES
									//_WITH_STORABLE_PROPERTIES
									//_WITHOUT_PROPERTIES

		/* Specify the origine of the objects to dump.
		   If the value is:
			_PREDEFINED_ONLY:
				xx

			_KB_ONLY:
				xx

			_ALL:
				xx
		*/
//--> predefinedObjectsMode			//_PREDEFINED_ONLY
									//_KB_ONLY
									//_ALL

		/* */
//--> sizesOfObjectsInExternalHeap	false

		/* */
//--> forceDumpEndIfError			false

		/* */
//--> forceDumpEndIfUserExit		false

; // DEBUGGER_DUMP_MEMORY

