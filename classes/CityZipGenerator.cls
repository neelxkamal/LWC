public class CityZipGenerator {
    private static Pattern spaceInJSONKey = pattern.compile('(?<="[a-z]+) (?=[a-z]+": )');
    
    @InvocableMethod(label='Get CityZip Mankato' description='Returns a response about Mankato from the public API Zippopotam.us')
    public static List<CityZip> getCityZip() {
        List<CityZip> czs = new List<CityZip>{getMankatoCityZip()};
        return czs;
    }
    
    private static CityZip getMankatoCityZip() {
        CityZip cz = new CityZip();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.zippopotam.us/us/mn/mankato');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            cz = (CityZip)JSON.deserialize(
                spaceInJSONKey.matcher(response.getBody()).replaceAll(''),
                CityZip.class
            );
        }
        return cz;
    }
}