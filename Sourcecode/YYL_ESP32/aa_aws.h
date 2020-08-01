#ifndef aa_aws_h
#define aa_aws_h

#include "aa_aws_setup.h"
#include <AWS_IOT.h>
#include <WiFi.h>

    AWS_IOT hornbill;
    int status = WL_IDLE_STATUS;
    int tick=0,msgCount=0,msgReceived = 0;
    char payload[512];
    char rcvdPayload[512];
    void mySubCallBackHandler (char *topicName, int payloadLen, char *payLoad)
    {
        strncpy(rcvdPayload,payLoad,payloadLen);
        rcvdPayload[payloadLen] = 0;
        msgReceived = 1;
    }

    void aws_begin() 
    {
        Serial.begin(115200);
        delay(2000);

        while (status != WL_CONNECTED)
        {
            Serial.print("Attempting to connect to SSID: ");
            Serial.println(WIFI_SSID);
            // Connect to WPA/WPA2 network. Change this line if using open or WEP network:
            status = WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    
            // wait 5 seconds for connection:
            delay(5000);
        }

        Serial.println("Connected to wifi");

        if(hornbill.connect(HOST_ADDRESS,CLIENT_ID)== 0)
        {
            Serial.println("Connected to AWS");
            delay(1000);

            if(0==hornbill.subscribe(TOPIC_NAME,mySubCallBackHandler))
            {
                Serial.println("Subscribe Successfull");
            }
            else
            {
                Serial.println("Subscribe Failed, Check the Thing Name and Certificates");
                while(1);
            }
        }
        else
        {
            Serial.println("AWS connection failed, Check the HOST Address");
            while(1);
        }

        delay(2000);

    }
    void aws_print(char temp[])
    {
        if(hornbill.publish(TOPIC_NAME,temp) == 0)
            {        
                Serial.print("Publish Message:");
                Serial.println(temp);
            }
            else
            {
                Serial.println("Publish failed");
            }        
    }
    void aws_receive() 
    {
        if(msgReceived == 1)
        {
            msgReceived = 0;
            Serial.print("Received Message:");
            Serial.println(rcvdPayload);
        }
    }
    
#endif
