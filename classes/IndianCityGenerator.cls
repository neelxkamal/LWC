public class IndianCityGenerator {
    
    private static List<IndianCity> allIndianCities = new List<IndianCity>();
    
    @InvocableMethod(label='Get Random Indian City' description='Returns a response from the public Indian Cities API')
    public static List<IndianCity> getIndianCity() {
        List<IndianCity> indCit = new List<IndianCity>{getRandomIndianCity()};
            return indCit;
    }
    
    private static IndianCity getRandomIndianCity() {
        if ( allIndianCities.isEmpty() ) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://indian-cities-api-nocbegfhqg.now.sh/cities');
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) {
                // Deserialize the JSON string into collections of primitive data types.
                allIndianCities = (List<IndianCity>)JSON.deserialize(response.getBody(), List<IndianCity>.class);
            }
        }
        if ( allIndianCities.isEmpty() ) {
            return new IndianCity();
        } else {
            Integer randomNumber = Math.mod(Math.abs(Crypto.getRandomLong().intValue()),allIndianCities.size());
            return allIndianCities[randomNumber]; 
        }
    }
}