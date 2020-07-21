@RestResource(URLMapping='/restTest/*')
global class RestExpose  {
	@HttpGet
	global static void testGet() {
		RestRequest req = RestContext.request;
		RestResponse rep = RestContext.response;

		System.debug(req.params);
		//SObject acc = [Select Id, name from Account limit 1];
		rep.responseBody =Blob.valueOf('Tsting get');
	}

	@HttpPost
	global static SObject testPost(String accId) {
		RestRequest req = RestContext.request;
		RestResponse rep = RestContext.response;

		System.debug(req.params);
		System.debug(accId);
		SObject acc = [Select Id, name from Account limit 1];
		//rep.responseBody =Blob.valueOf('Tsting get');
		return acc;
	}
}