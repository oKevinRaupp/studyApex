public with sharing class EmailManager {
    public static void sendMail(String address, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
            new Messaging.SingleEmailMessage[] { mail });
         inspectResults(results);
    }
    private static Boolean inspectResults(Messaging.SendEmailResult[] results) {
        Boolean sendResult = true;
             for (Messaging.SendEmailResult res :results) {
            if (res.isSuccess()) {
                System.debug('Email Enviado com suuuuucesso!!!');
            } else {
                sendResult = false;
                System.debug('Deu ruim, segui os b.o' + res.getErrors());                 
            }
        }
        return sendResult;
    }
}