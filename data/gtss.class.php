<?php
/*
 This is class which can scrape google translate for the sounds of specific words.
 USAGE:
	see scrape.php for example
*/

class ScraperException extends Exception{

}

class GoogleTranslateSoundScraper{

	const C_TRAILING_SLASH = '/';
	const C_AUDIO_EXTENSION = '.mp3';
	
	private $G_SILENT = true;

	private $mOutputDir_;
	private $mLangCode;
	private $mPhraseStringar;

	private $mOnScrapeListener = null;
	
	
	function __construct(){
	}
	
	function setOnScrapeListener($onScrapeFunctionStr){
		$this->mOnScrapeListener = $onScrapeFunctionStr;
	}
	
	private function fireOnScrapeEvent($fileName){
		if ( $this->mOnScrapeListener != null){
			$ff = $this->mOnScrapeListener;
			$ff($fileName);
		}
	}
	
	function setOutputDirectory($dir_){
		// test if directory can be opened
		$this->isDirectoryValidOrThrow($dir_);
		$this->mOutputDir_ = $dir_;
	}
	
	
	function setForeignPhrases($phraseStringar, $langCode){
		$this->validateForeignPhraseParametersOrThrow($phraseStringar, $langCode);
		$this->mPhraseStringar = $phraseStringar;
		$this->mLangCode = $langCode;
		
	}
	
	function scrape(){
			$scrapedCount = 0;
			for ($i = 0 ; $i < count($this->mPhraseStringar) ; $i++){
				$phrase = $this->mPhraseStringar[$i];
				$fileNameToSavePath = $this->phraseToSavePath($phrase, $this->mOutputDir_);
				$this->scrapePhrase($phrase, $fileNameToSavePath);		// throws exception in case error
				$this->fireOnScrapeEvent($fileNameToSavePath);
				$scrapedCount++;
			}
			return $scrapedCount;
	}

	
	
	/*
	  Converts phrase to canonical file name (replacing spaces with underscores and stripping special characters)
	*/
	private function phraseToSavePath($phrase, $outputDir_){
		// TODO: 
		//throw new ScrapeException("Not implemented!");
		$len = strlen($outputDir_);
		if ( $len > 0 && substr($outputDir_, $len -1, 1) != self::C_TRAILING_SLASH){
			throw new ScraperException("phraseToSavePath():: the outputDir shoud end only with [" . self::C_TRAILING_SLASH . "] now : [$outputDir_]");
		}
		$phrase = str_replace(' ','_', $phrase);
		//$phrase = mb_convert_encoding($phrase, "UCS2", "UTF-8"); // java will be receiving filename
		return $outputDir_.urlencode($phrase).self::C_AUDIO_EXTENSION;
	}

	
	/*
		Connects to google and retrieves the sounds and saves to given file(path)
	*/
	private function scrapePhrase($sPhraseToScrape, $sFilePathToSaveTo){
				     $word = $sPhraseToScrape;
					 $lang = $this->mLangCode;
					 
					 $wordlen = strlen($word);
					 $word = urlencode($word);
					 
					 $scheme = 'http://';
					 $host = 'translate.google.com';
					 $script = '/translate_tts';
					 
					 
					 //$q = http_build_query($_GET);
					 // $data = "ie=UTF-8&q=welcome&tl=en&total=1&idx=0&textlen=7";
					 $data = "ie=UTF-8&q=$word&tl=$lang&total=1&idx=0&textlen=$wordlen&prev=input";
					 $get_string = $script . '?' . $data;
					 $full_url = $scheme . $host . $get_string;
 	
					 $fp = fsockopen($host, 80, $errno, $errstr, 30 );
					 
					 if ( $fp )
					 {
						  fputs($fp, "GET $get_string HTTP/1.1\r\n");
						  fputs($fp, "Host: $host\r\n");
									
									$requestHeaders = $this->apache_request_headers();
									while ((list($header, $value) = each($requestHeaders))) {
											if($header == "Content-LengthNOMATCh") {
													fputs($fp, "Content-Length: $datalength\r\n");
											} else if($header !== "Connection" 
												   && $header !== "Host" 
													&& $header !== "Content-length" 
													&& $header !== "Referer")
												{
													fputs($fp, "$header: $value\r\n");
												}
									}
									fputs($fp, "Connection: close\r\n\r\n");
									fputs($fp, $data);
									
									
									$f = fopen($sFilePathToSaveTo, "wb");
									if ( $f )
									{
											$result = ''; 
											$emptyLines = 0;
											while ( $emptyLines < 1)
											{
												$s = fgets($fp);
												if ( !$this->G_SILENT)
												{
													echo "got line [$s]<br>\n";
												}
												$s = trim($s);
												if ($s == '')
												{
													if ( !$this->G_SILENT) 
													{
														echo "found empty line";
													}
													$emptyLines++;
													break;
												}
											}
											while(!feof($fp)) {
													// receive the results of the request
													//$result .= fgets($fp, 128);
													$buf = fread($fp, 4096);
													fwrite($f, $buf);
													
													//echo $buf;
											}                    
										
										
										
										
										//fwrite($f, "Hello");
											fclose($f);
										
									}
									
									else
									{
										//echo "error opening file";
										throw new ScrapeException("Cannot open output file [" . $sFilePathToSaveTo ."]");
									}
						  
									fclose($fp);
						  
					 } // if ( $fp ) is oK	
					 else{ // if cannot open socket
						throw new ScrapeException("Cannot open socket of ($host). Error no: $errno, ErrStr: $errstr");
					 }
	
		
	}
	
	private function validateForeignPhraseParametersOrThrow($phraseStringar, $langCode){
		// TODO
	}
	
	
	private function isDirectoryValidOrThrow($dir_){
		// todo
	}
	
	
	// Function is from: http://www.electrictoolbox.com/php-get-headers-sent-from-browser/
    private function apache_request_headers() {
        $headers = array();
        foreach($_SERVER as $key => $value) {
            if(substr($key, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(str_replace('_', ' ', strtolower(substr($key, 5)))))] = $value;
            }
        }
        return $headers;
    }
	
	
}// Class


/*

if(!function_exists('apache_request_headers')) {
// Function is from: http://www.electrictoolbox.com/php-get-headers-sent-from-browser/
    function apache_request_headers() {
        $headers = array();
        foreach($_SERVER as $key => $value) {
            if(substr($key, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(str_replace('_', ' ', strtolower(substr($key, 5)))))] = $value;
            }
        }
        return $headers;
    }
}

*/
?>