/*
	File:		debugger-rules.dcl
	
	Version:	1.0

	Content:	Trace parameters for rules

	Release notes:

		1.0 (2016/02/28)		
			1) divide old debugger.dcl in several files
		
*/


// ----------------------------------------------------------------------
// ----------   More useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_RULE

		/* If the value is:
			_RULE_SUCCESS:
				Only rules that are compatible with the field matchRuleRun and that are executed with success are traced.
				Input and output inside the ruleset are also traced. 

			_RULE_SUCCESS_WITH_KB_CHANGES:
				Only rules that are compatible with the field matchRuleRun and that are executed with success and that have an impact on the KB are traced.
				Input and output inside the ruleset are also traced. 

			_RULE_END:
				Every rules compatible with the field matchRuleRun and that have been tried are traced.
				Input and output inside the ruleset are also traced.

			_RULE_BEGIN_END:
				Every rules compatible with the field matchRuleRun and that have been tried are traced.
				Input and output inside the ruleset are also traced.
					
			_RULESET_BEGIN_END:
				Every input/output in ruleset are traced.
				But rules are not traced.

			_RULESET_END:
				Every ruleset's outputs (and maybe generated results) are traced.
				But rules are not traced.

			_RULESET_SUCCESS:
				Only ruleset's outputs where at least one rule has been successful are traced.
				But rules are not traced.

			_RULESET_SUCCESS_WITH_KB_CHANGES:
				Only ruleset's outputs where at least one rule has been successful with a KB modification are traced.
				But rules are not traced.
		*/
//--> ruleRun		//_RULE_SUCCESS
					//_RULE_SUCCESS_WITH_KB_CHANGES
					//_RULE_END
					//_RULE_BEGIN_END
					//_RULESET_SUCCESS
					//_RULESET_SUCCESS_WITH_KB_CHANGES
					//_RULESET_BEGIN_END
					//_RULESET_END


		/* Displays data that have been modified by a ruleset */
//--> rulesetDataChanges		true

		/* Displays data that have been modified at every round by a ruleset */
//--> rulesetRoundDataChanges	true

		/* Displays, for each rule, data that have been modified */
//--> ruleDataChanges		true

; // DEBUGGER_KB_TRACE_RULE



// ----------------------------------------------------------------------
// ------------ Less useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_RULE

		/* traces anytime it goes through a ruleset
		   If the value is:
			_NEVER:
				xx

			_BEGIN:
				xx

			_BEGIN_END:
				xx

			_END:
				xx
		*/
//--> rulesetRound			//_BEGIN
							//_BEGIN_END
							//_END
							//_NEVER

		/* traces only rules r1, r3 and everyrules within ruleset rulesetA */
//--> matchRuleRun	r1, r3, rulesetA

		/* doesn't trace the rules r1, r3 and everyrules within ruleset rulesetA */
//--> excludeRuleRun	r1, r3, rulesetA

		/* Notify every time a rule is activated or deactivated (at the end of the ruleset execution, Yseop Rules re-activates every rules) */
//--> ruleActivate			true

		/* Trace the backword mode */
//--> backwardRun			true

; // DEBUGGER_KB_TRACE_RULE



// ----------------------------------------------------------------------
// ------------ Less useful parameters: filter parameters   -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_FILTER

		/* 
			Warning, this attribute is taken into account only if there is a filter that is in an ongoing detailed trace (cf attribute details)
			It indicated if the input and the output of the filter have to be traced			
			If the value is:
			_NEVER
				filter's input is not traced
			
			_IF_DETAILS
				filter's input is traced
			
			_IF_DETAILS_AND_NOT_RULE
			filter's input is traced only if it is not a rule filter	
		*/
//--> inOut				//_IF_DETAILS
						//_IF_DETAILS_AND_NOT_RULE
						//_NEVER

//--> conditionsIfDetails

		/* 	On each "elementary trigger" of the order 1 filter, or of the rule containing it, 
			a trace is generated and the filter's variables values are displayed
		*/
//--> thenDetails			_NEVER


		/* 	
			EN: Warning, if there is a rule filter in progress, the attribute will be taken into account only if
			the rule entry has been traced.
			
			FR: Attention, si filtre d'une regle en cours, l'attribut ne sera pris en compte que si l'entrée
			dans la règle a été tracé afin que cette trace n'apparaisse pas comme un cheveu dans la soupe
			If the value is:
			_NEVER (default value):
				No detailld trace of the filter's evaluation

			_IF_RULE:
				Like in the _ALWAYS mode, but does execute only if it is a rule filter (does not concern the forall, as ...)

			_IF_NOT_RULE:
				Like the _ALWAYS mode, but does execute only if it is not a rule filter (does apply to forall, as ...)

			_ALWAYS:
				Detailed trace of the filter's evaluation: variable instanciation, propagation, etc.
		*/
//--> details				//_IF_RULE
						//_IF_NOT_RULE
						//_IF_NOT_RULE
						//_ALWAYS

//--> veryDetailed		false

; // DEBUGGER_KB_TRACE_FILTER

