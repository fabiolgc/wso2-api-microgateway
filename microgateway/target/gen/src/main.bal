
public function main() {
    
    string[] Kindel_Book_Store__1_0_0_service = [ "get_5253c222_92da_4e82_9300_651c561f9b74"
                                , "get_8741450d_b525_4a15_913b_c704f3422954"
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
