# Supported tags and respective `Dockerfile` links

-	[`1.0` (*Dockerfile*)](https://github.com/dphiggs01/docker-tesseract/blob/master/Dockerfile)

# Tesseract
This project creates a base tesseract server for OCR processing. The server contains ImageMagic for image pre-processing and pytesseract for python integration.


## Processing
To build the server first make sure you have a proper docker engine running and your environment is configured

	$ docker-machine ls
	NAME      ACTIVE   DRIVER       STATE     URL                         
	default   -        virtualbox   Running   tcp://138.91.253.232:2376
	
	$ docker-machine env default 
	$ eval $(docker-machine env default)                            
	

Next use the following commands to build and test locally

	$ docker build -t tesseract .
	$ docker run -i -v `pwd`/data:/data -t tesseract bash
Note: the *-v \`pwd\`/data:/data* mounts a locally drive which is not neccasary to test as we have loaded a couple of test files when we created the image. 

To test:

	# tesseract -v
	tesseract 3.04.01
	leptonica-1.73 libjpeg 8d (libjpeg-turbo 1.3.0)...
	# tesseract /data/test2.png stdout
	the (quick) [brown] {fox} jumps!
	Over the $43,456.78 <lazy> #90 dog
	& duck/goose, as 12.5% of E-mail
	. . . 
	
	# python
	>>> Import pyterresact
	>>> exit()
	
If __Import pytesseract__ command returns with no errors this means the library was able to load ans is available for use.

## Publish
Once you have a good server we can publish it to **dockerhub**

	$ docker tag 'tesseract' 'dphiggs01/tesseract:1.0'
	$ docker tag 'tesseract' 'dphiggs01/tesseract:newest'
	$ docker login -u dphiggs01 -p *********
	$ docker push 'dphiggs01/tesseract:1.0'
	$ docker push 'dphiggs01/tesseract:newest'
	
Note: replace `dphiggs01` with an appropriate user name.	
	
	
	
	

