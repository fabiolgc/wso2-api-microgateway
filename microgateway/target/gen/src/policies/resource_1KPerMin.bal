import ballerina/io;
import ballerina/runtime;
import ballerina/http;
import ballerina/log;
import wso2/gateway;

stream<gateway:IntermediateStream> s1KPerMinintermediateStream = new;
stream<gateway:GlobalThrottleStreamDTO> s1KPerMinresultStream = new;
stream<gateway:EligibilityStreamDTO> s1KPerMineligibilityStream = new;
stream<gateway:RequestStreamDTO> s1KPerMinreqCopy= gateway:requestStream;
stream<gateway:GlobalThrottleStreamDTO> s1KPerMinglobalThrotCopy = gateway:globalThrottleStream;

function initResource1KPerMinPolicy() {

    forever {
        from s1KPerMinreqCopy
        select s1KPerMinreqCopy.messageID as messageID, (s1KPerMinreqCopy.resourceTier == "1KPerMin") as
        isEligible, s1KPerMinreqCopy.resourceKey as throttleKey, 0 as expiryTimestamp
        => (gateway:EligibilityStreamDTO[] counts) {
        foreach var c in counts{
            s1KPerMineligibilityStream.publish(c);
        }
        }

        from s1KPerMineligibilityStream
        throttler:timeBatch(60000)
        where s1KPerMineligibilityStream.isEligible == true
        select s1KPerMineligibilityStream.throttleKey as throttleKey, count() as eventCount, true as
        stopOnQuota, expiryTimeStamp
        group by s1KPerMineligibilityStream.throttleKey
        => (gateway:IntermediateStream[] counts) {
        foreach var c in counts{
            s1KPerMinintermediateStream.publish(c);
        }
        }

        from s1KPerMinintermediateStream
        select s1KPerMinintermediateStream.throttleKey, s1KPerMinintermediateStream.eventCount>= 1000 as isThrottled,
        s1KPerMinintermediateStream.stopOnQuota, s1KPerMinintermediateStream.expiryTimeStamp
        group by s1KPerMineligibilityStream.throttleKey
        => (gateway:GlobalThrottleStreamDTO[] counts) {
        foreach var c in counts{
            s1KPerMinresultStream.publish(c);
        }
        }

        from s1KPerMinresultStream
        throttler:emitOnStateChange(s1KPerMinresultStream.throttleKey, s1KPerMinresultStream.isThrottled)
        select s1KPerMinresultStream.throttleKey as throttleKey, s1KPerMinresultStream.isThrottled,
        s1KPerMinresultStream.stopOnQuota, s1KPerMinresultStream.expiryTimeStamp
        => (gateway:GlobalThrottleStreamDTO[] counts) {
        foreach var c in counts{
            s1KPerMinglobalThrotCopy.publish(c);
        }
        }
    }
}

