public class CustomLookupController  {
	@AuraEnabled(cacheable=true )
	public static List<sObject> findRecords(String searchKey, String objectName, String searchField) {
		String sosl = 'Find {' + searchKey +' } in ALL FIELDS returning '+objectName + ' ( ' + searchField +' )';

		List<List<sObject>> resultList = Search.query(sosl);
		System.debug('resultList===='+resultList);
		return resultList[0];
	}
}