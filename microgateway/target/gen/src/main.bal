
public function main() {
    
    string[] Kindel_Book_Store__1_0_0_service = [ "get_ad31b08b_e902_4e41_bcb4_fc3d9364f856"
                                , "get_c1329a61_7aed_4a04_a7cb_4defd7447ac9"
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
