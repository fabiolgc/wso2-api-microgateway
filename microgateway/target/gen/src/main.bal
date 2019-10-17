
public function main() {
    
    string[] Kindel_Book_Store__1_0_0_service = [ "get_e2170440_cf3b_4f42_8d38_cab1c63b3c41"
                                , "get_540c6898_4120_4ce3_9d1e_3731548504ab"
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
