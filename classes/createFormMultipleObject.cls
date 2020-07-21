public class createFormMultipleObject  {
	@AuraEnabled
	public static String save(MOWrapper moWrapper) {
		System.debug('*****'+moWrapper.firstName);
		return 'Success';
	}

	public class MOWrapper{
		@AuraEnabled 
		public String firstName{get;set;}

		@AuraEnabled 
		public String lastName{get;set;}
	}
}