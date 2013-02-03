<?php
	/*
		Example of using GoogleTranslateSoundScraper class.
		The 'listener' and anonymouse function declaration only work in PHP 5.3.0+ (comment them if not necessary)
	*/
	include_once("gtss.class.php");

	$onScrape = function($file){
		echo "Scraped [$file]\n";
	};

	echo "\n";
	//var_dump($argv);
		
	//list($fileName, $langCode,  $verifyParametersOrExit();
	
//	########################################
//	############# CONFIG PARAMS ############
//	########################################
	$outputDir = "./sounds/"; 							// remember to put FORWARD-slash in the end	
	$phraseFile = "norwegian words 101 utf8 BOM.txt";	// 
	$langCode = "no"; 									// language code (as per google translate spec)	
	
//	########################################
//	#############ENTRY POINT ###############
//	########################################
	
	
	try{

			// $stringArrayForeignPhrases = array(
											// "å lese avisen",
											// "å være glad",
											// "misfornøyd"
										// );

			$stringArrayForeignPhrases = loadNorwegianPhrasesFromFile($phraseFile);

										
			$gScraper = new GoogleTranslateSoundScraper();
			$gScraper->setOutputDirectory($outputDir);
			$gScraper->setForeignPhrases($stringArrayForeignPhrases, $langCode); 
			$gScraper->setOnScrapeListener($onScrape);
			$r = $gScraper->scrape();
			echo "Successfully scraped $r phrases from google into directory $outputDir";
			
	}
	catch (ScraperException $e){
		echo "Error scraping google phrases: " . $e->getMessage();
	}

	/*
		Loads phrases from file. File should be either each line norwegian phrase. 
		Or file with two tab-delimited columns.
		Or each row  [first part: norwegian phrase, can contain spaces.] TAB [second part, whatever else]
	*/
	function loadNorwegianPhrasesFromFile($filename){
				$phraseList = array();
				$strings = file($filename);
				foreach ($strings AS $s){
					 $newS = getSubstringBeforeDelimeter($s, "\t"); // ($string, $delimeter)
					 if  ( $newS != ''){
						$phraseList[] = $newS;
					 }
				}
				
				//var_dump($phraseList);
				return $phraseList;
	}
	
	
	function getSubstringBeforeDelimeter($s, $dlm){
			$s = trim($s);
			if ( b"\xEF\xBB\xBF" == substr($s,0,3) ){
				echo "BOM FOUND and skipped\n";
				$s = substr($s, 3);
			}
			$idx = strpos( $s, $dlm);
			//echo "delimeter[$dlm] found at [" . $idx ."]\n";
			if ( $idx === false ){ // all string there's nothing there
				return $s; 
			}
			return substr($s, 0, $idx);
	}
	
	
	/*
	
	function verifyParametersOrExit(){
		$c = count($argv);
		if ( $c < 2 ){
			echoUsageHelp();
			exit;
		}
		
		if ( $c == 2 ){
			echo 'only one parameter. Need to be "test" ';
			echoUsageHelp();
			exit;
		}
		
		if ( $c >= 3 ){
			
		}
		
	}
	
	function echoUsageHelp(){
		echo "Error, need at least one parameter: \ntest - to test \n filenameUTF8NOBOM_withTabDelimitedStringFirstColumnLanguage.txt - UTF8 NO  & lang" ;
	}
	*/
?>