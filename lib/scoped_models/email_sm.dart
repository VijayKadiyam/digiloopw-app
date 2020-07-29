// Scoped Models
import 'connected_sm.dart';

// Utils
import '../utils/network.dart';

mixin EmailModel on ConnectedModel {
  void sendEmail(String fromId, String fromName, String sendToEmail,
      String replyToEmail, String subProductId) async {
    setLoading();

    Map<String, dynamic> sendEmailData = {
      'from_id': fromId,
      'from_name': fromName,
      'reply_to_email': replyToEmail,
      'send_to_email': sendToEmail,
      'sub_product_id': subProductId
    };

    Network().post(
      url: 'send_email',
      body: sendEmailData,
    );

    unSetLoading();
  }
}
