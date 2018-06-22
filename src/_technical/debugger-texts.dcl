/*
	File:		debugger-texts.dcl
	
	Version:	1.0

	Content:	Trace parameters for texts

	Release notes:

		1.0 (2016/02/28)		
			1) divide old debugger.dcl in several files
		
*/


// ----------------------------------------------------------------------
// ----------   More useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_TEXT

		/* If the value is:
			_SUCCESS:
				Only write calls on texts that are compatible with the field matchTextRun are traced

			_SUCCESS_AND_NOT_EMPTY_STRING:
				Only write calls on texts that are compatible with the field matchTextRun and that generate no empty text are traced

			_BEGIN_END:
				Every input/output for the method write are traced.

			_END:
				Every output for the method write are traced.
		*/
//--> textRun		//_SUCCESS
					//_SUCCESS_AND_NOT_EMPTY_STRING
					//_END
					//_BEGIN_END

; // DEBUGGER_KB_TRACE_TEXT



// ----------------------------------------------------------------------
// ------------ Less useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_TEXT

		// traces only texts txt1 and txt2
//--> matchTextRun		txt1, txt2

//--> excludeTextRun		TextGranuleFragment

		// trace also the empty texts
//--> traceIsEmptyString	true

		// the synonyms are traced
//--> synonyms			true

		// the usages of NlgRepresentant and anaphors are traced
//--> references			true

; // DEBUGGER_KB_TRACE_TEXT



// ----------------------------------------------------------------------
// ----------   More useful parameters: general parameters  -------------
// ----------------------------------------------------------------------

complete DEBUGGER_KB_TRACE_TEXT_EVAL_STRUCTURE

		/* Active the text structure traces */
//--> active	true

		/* If the value is:
			_LITERAL_LOG:
				trace mixee avec contenu textuel
			_EXTERNAL_XML_PATH_WITH_TEXT_CONTENT:
				xx
			_APPEND_LITERAL_LOG:
				xx
			_EXTERNAL_LITERAL_LOG_NATIVE_FORMAT:
				xx
			_EXTERNAL_LITERAL_LOG_XML_FORMAT:
				xx
			_EXTERNAL_XML_PATH_WITH_TEXT_CONTENT:
				xx
			_EXTERNAL_XML_PATH_WITHOUT_TEXT_CONTENT:
				xx
		*/
//--> mode		//_LITERAL_LOG
				//_EXTERNAL_XML_PATH_WITH_TEXT_CONTENT
				//_APPEND_LITERAL_LOG
				//_EXTERNAL_LITERAL_LOG_NATIVE_FORMAT
				//_EXTERNAL_LITERAL_LOG_XML_FORMAT
				//_EXTERNAL_XML_PATH_WITH_TEXT_CONTENT
				//_EXTERNAL_XML_PATH_WITHOUT_TEXT_CONTENT


		/* trace the conditions associated to the written text */
//--> logConditionIfSuccess	true

; // DEBUGGER_KB_TRACE_TEXT_EVAL_STRUCTURE


// ----------------------------------------------------------------------
// ------------ Less useful parameters: text structure      -------------
// ----------------------------------------------------------------------

Style TEXT_TRACE_STYLE
--> xml		"styleerreur"
--> color	DARK_GREY
;

Function startTextTrace (Text || TextTag txt, Boolean successCond)
--> action
{
	\(
		\beginStyle(TEXT_TRACE_STYLE)
			{ \+

			\if (txt.isInstanceOf(TextTag) == true)
				\value(txt.identify())
			\else
				\if (txt.identifier != null)
					\value(txt.identifier)
				\else
					\if (txt.sourceFile != null)
						\value(txt.sourceFile.transliterate('\','/')), \valueIfDefined(txt.sourceLine)
					\else
						\value(txt.extendedIdentifier)
					\endIf
				\endIf
			\endIf

			\+ }->[

			\if (successCond == false)
				<< condition fausse :
					\if (txt.isInstanceOf(TextTag) == true)
						\value(txt.TextTag::condition.extendedIdentifier)
					\else
						\value(txt.Text::condition.extendedIdentifier)
					\endIf
				>>
			\endIf

			\if (successCond == true)
				<< condition vraie :
					\if (txt.isInstanceOf(TextTag) == true)
						\value(txt.TextTag::condition.extendedIdentifier)
					\else
						\value(txt.Text::condition.extendedIdentifier)
					\endIf
				>>
			\endIf

		\endStyle
	\).write();
}
; // startTextTrace

Function endTextTrace (Object txt)
--> action
{
	\(
		\beginStyle(TEXT_TRACE_STYLE)
			]
		\endStyle
		\p
	\).write();
}
;

TextGranule txtInfosData
--> style TEXT_TRACE_STYLE
\(
	 \bl ******* \p INFOS DATA \p ****** \bl
\)
;

complete DEBUGGER_KB_TRACE_TEXT_EVAL_STRUCTURE

//--> externalXmlDirectory	"C:\yseop\workspace\test-debugger\bin"
//--> externalXmlCopyNamespace	true

		/* If the value is:
			_NEVER (default value):
				xx
			_IF_DSL:
				xx
			_NEVER:
				xx
		*/
//--> textEvalOrigin	//_IF_DSL
					// _ALWAYS
					// _NEVER

		/* If the value is:
			_IF_ELT_NOT_INACTIVE (default value):
				xx
			_IF_ELT_ACTIVE_NO_RECURSIVE:
				xx
			_IF_ELT_ACTIVE_RECURSIVE:
				xx
			_ALWAYS:
				xx
		*/
		// Traces the texts that we did not explicitly declared as
//--> filter	//_IF_ELT_NOT_INACTIVE
				//_IF_ELT_NOT_INACTIVE
				//_IF_ELT_ACTIVE_NO_RECURSIVE
				//_IF_ELT_ACTIVE_RECURSIVE
				//_ALWAYS

		/* If the value is:
			_IF_NOT_FALSE (default value):
				xx
			_ALWAYS:
				xx
			_ALWAYS:
				xx
		*/
//--> recursive	//_IF_NOT_FALSE
				//_ALWAYS
				//_NEVER

//--> textGranuleFragmentWithoutIdentifier	true

//--> logClass				false

//--> logIdWrite			false

		/* trace the conditions (and the texts) associated to the not written text */
//--> logConditionIfFailure	true

//--> cdataGeneratedContent	true // default value

--> contextInfo				txtInfosData

--> startSecondLog			\( \bl -------------------------  \bl
								\value(txtInfosData)
								\bl
							 \)

--> endSecondLog			\( \bl -------------------------  \bl \)

//--> startLogFunction		startTextTrace
//--> endLogFunction		endTextTrace

; // DEBUGGER_KB_TRACE_TEXT_EVAL_STRUCTURE

