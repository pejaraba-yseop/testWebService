// ====================================================================================
// =========================    REQUEST_MANAGER   =====================================
// ====================================================================================

complete REQUEST_MANAGER

// ------------------------------------------------------------------------
// ----------  Entry points in the Yseop Engine internal workflow  --------
// ------------------------------------------------------------------------

//--> serverInit { include code here }

//--> actionBeforeXmlReading {}

--> actionAfterXmlReading { 

	// -------------------------------------
	// ----- print XML schema. Uncomment only if you want o create the inputSchema.xsd file in your dialog directory
	// -------------------------------------
	// printXMLSchema(GeneralData);
 }

--> actionProcessIfNotDialog 
		{
			// -------------------------------------
			// ----- general initializations
			// -------------------------------------

			//temporary, waiting for libActors to use new features for init in automatic mode
			@if (exists_object (LibActors:Person) == true)
				logInfo("setLibActors called");
				
				// we can do this here because generalInit can be found in generated_text_elements.yml. 
				// It's last element in project.kao
				@if (exists_object (setLibActors) == true)
					setLibActors();
				@else
					@error "the function setLibActors must be defined."
				@endif	
			@endif
	
			// patch #586
			RULES_PARAM_CONTEXT.updateAfterDeletion = false;
			
			@remark "rules trigger to be plugged again. or not"
			//RULES_PARAM_CONTEXT.startTrigger(getSuiveurRegles());

			// -------------------------------------
			// ----- project specific initializations
			// -------------------------------------

			RULES_PARAM_CONTEXT.fireOnlyOnce = false;
			TEXT_PARAM_CONTEXT.kBLanguage = getGeneralData().language;
			
			// processing tasks: rules, functions, other tasks
			runProcessingTasks();
		}

//--> actionAfterXmlWriting { include code here }




// ------------------------------------------------------------------------
// -----------------  Specification of the text output    -----------------
// ------------------------------------------------------------------------

--> outputText	
		-> DialogText
		--> formats			XML_DIALECT_FORMAT
		--> xmlAttributes	["id", "finalDocument", "index", 1, "name", "text1"]
		--> text			-> TextMail
		
							--> components	{_texts:finalDocument}
	
							--> mailData	-> MailData
											--> date Date..current()

											--> mailActors	-> MailActors

															//--> recipient				to be defined...
															//--> recipientFirstName	to be defined... = FWWS_CONFIG.recipient.getFirstName();
															//--> recipientLastName		to be defined... = FWWS_CONFIG.recipient.getLastName();
															//--> recipientGender		to be defined if recipient undefined
															//--> recipientNumber		to be defined if recipient undefined
															//--> recipientCivility		to be defined if recipient undefined														
															

															//--> sender				to be defined...
															// --> senderGender			to be defined if sender undefined													
															//--> senderNumber			to be defined if sender undefined	
															
															;
											;

							--> mailStyle	-> MailStyle
											//--> vousForm			to be defined
											//--> majestyPlural		to be defined
											//--> speechForm		to be defined
											;

							--> mailCharter	-> MailCharter
											//--> defaultSalutation = SALUTATION_POLITE
											;
							;
		;
		
--> batchStylesheetHref "../dialog/output.xsl"
	
; // complete REQUEST_MANAGER
