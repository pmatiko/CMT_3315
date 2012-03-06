	function loadXMLString(txt){
		if (window.DOMParser) {  
			parser=new DOMParser();  	
			xmlDoc=parser.parseFromString(txt,"text/xml");  
		}
		else // Internet Explorer  
		{
		xmlDoc= new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async="false";  
		xmlDoc.loadXML(txt); 
		}
		return xmlDoc;
	}
	
	function loadXMLDoc(docname){
		if (window.XMLHttpRequest)
		{
			xhttp=new XMLHttpRequest();  	
		}
		xhttp.open("GET",docname,false);
		xhttp.send("");
		return xhttp.responseXML;
	}
	function displayPoll(){
		xml=loadXMLDoc("xmlPoll.xml");   
		xsl=loadXMLDoc("xmlPollTransform.xml");   
		
		var resultDocument;

		// code for IE   
		if (window.ActiveXObject)  
		{    
			ex=xml.transformNode(xsl);     
			document.getElementById("poll").innerHTML=ex;  
		}   

		// code for Mozilla, Firefox, Opera, etc.   
		else if (document.implementation && document.implementation.createDocument)
		{
		 	xsltProcessor=new XSLTProcessor();       
			xsltProcessor.importStylesheet(xsl);    
			resultDocument = xsltProcessor.transformToFragment(xml,document);      
			document.getElementById("poll").appendChild(resultDocument); 
			
		}
		
		return resultDocument;
	}
	function displayResults(){
		
		xml=loadXMLDoc("xmlPoll.xml");   
		xsl=loadXMLDoc("xmlPollTransform2.xml");   

		// code for IE   
		if (window.ActiveXObject)  
		{    
			ex=xml.transformNode(xsl);     
			document.getElementById("poll").innerHTML=ex;  
		}   

		// code for Mozilla, Firefox, Opera, etc.   
		else if (document.implementation && document.implementation.createDocument)
		{
		 	xsltProcessor=new XSLTProcessor();       
			xsltProcessor.importStylesheet(xsl);    
			resultDocument = xsltProcessor.transformToFragment(xml,document);      
			document.getElementById("results").appendChild(resultDocument);		
			document.getElementById("poll").style.visibility='hidden'; 
		}
	}
	function getSelectedItem() {
		
		len=document.radioList.answer.length;
		chosen = "";
		
		for (i = 0; i <len; i++) {
			if (document.radioList.answer[i].checked) {
			chosen = document.radioList.answer[i].value
			}
		}
		
		if (chosen == "") {
			alert("Please select an answer to continue voting")
		}
		else{
		//traverse through XML file and increment desired value
			
		xml=loadXMLDoc("xmlPoll.xml");
		x=xml.getElementsByTagName("answer")[chosen].childNodes[0]
		var value=x.nodeValue;
		value++;
		x.nodeValue=value;
		
		alert("Before increment"+x.nodeValue+"After increment"+value);
		}
	}		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	