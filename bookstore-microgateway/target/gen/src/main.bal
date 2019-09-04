
public function main() {
    
    string[] Kindel_Book_Store__1_0_0_service = [ "get_f7296f4d_2ce8_4258_98d9_e4019d1f6650"
                                , "get_8de3dfa7_9d6a_415e_92a9_fbb5b1c2fbac"
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
