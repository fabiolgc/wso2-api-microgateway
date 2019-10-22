
public function main() {
    
    string[] null__1_0_0_service = [ "get_b3d36254_6ded_4944_a65b_41ce5aac299e"
                                , "get_86e78e5b_8693_44f3_9613_3a8b5b33d3e1"
                                ];
    gateway:populateAnnotationMaps("null__1_0_0", null__1_0_0, null__1_0_0_service);
    

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
