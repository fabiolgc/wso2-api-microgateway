
public function main() {
    
    string[] Kindel_Book_Store__1_0_0_service = [ "get_c9249101_90d5_47a2_8422_66f07afe513b"
                                , "get_20a1e9c3_1487_4f82_9635_ccbedc9074df"
                                ];
    gateway:populateAnnotationMaps("Kindel_Book_Store__1_0_0", Kindel_Book_Store__1_0_0, Kindel_Book_Store__1_0_0_service);
    

    initThrottlePolicies();

    map<string> receivedRevokedTokenMap = gateway:getRevokedTokenMap();
    boolean jmsListenerStarted = gateway:initiateTokenRevocationJmsListener();

    boolean useDefault = gateway:getConfigBooleanValue(gateway:PERSISTENT_MESSAGE_INSTANCE_ID,
    gateway:PERSISTENT_USE_DEFAULT, false);

    if (useDefault){
        future<()> initETCDRetriveal = start gateway:etcdRevokedTokenRetrieverTask();
    } else {
        initiatePersistentRevokedTokenRetrieval(receivedRevokedTokenMap);
    }
    startupExtension();
}
