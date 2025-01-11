MetadataService.MetadataPort service = createService();
MetadataService.CustomField customField = new MetadataService.CustomField();
customField.fullName = 'LinkSquares__Agreement__c.LinkSquares__Renewal_Price_Adjustment__c';
customField.label = 'Renewal Price Adjustment 2';
customField.type_x = 'LongTextArea';
customField.length = 32768;
customField.visibleLines = 3;
List<MetadataService.SaveResult> results =
    service.updateMetadata(
        new MetadataService.Metadata[] { customField });

handleSaveResults(results[0]);

public static MetadataService.MetadataPort createService()
{
    MetadataService.MetadataPort service = new MetadataService.MetadataPort();
    service.SessionHeader = new MetadataService.SessionHeader_element();
    service.SessionHeader.sessionId = UserInfo.getSessionId();
    return service;
}

public static void handleSaveResults(MetadataService.SaveResult saveResult)
{
    // Nothing to see?
    if ((saveResult == null) || saveResult.success) {
        return;
    }
    // Construct error message and throw an exception
    if (saveResult.errors != null)
    {
        List<String> messages = new List<String>();
        messages.add(
            (saveResult.errors.size() == 1 ? 'Error ' : 'Errors ') +
            'occured processing component ' + saveResult.fullName + '.');

        for (MetadataService.Error error : saveResult.errors) {
            messages.add(
                error.message + ' (' + error.statusCode + ').' +
                ( error.fields != null && error.fields.size() > 0 ?
                  ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
        }

        if (messages.size() > 0) {
            // throw new MetadataServiceExamplesException(String.join(messages, ' '));
            System.debug('>>>err: ' + String.join(messages, ' '));
        }
    }
    if (!saveResult.success) {
        // throw new MetadataServiceExamplesException('Request failed with no specified error.');
        System.debug('Request failed with no specified error.');
    }
}