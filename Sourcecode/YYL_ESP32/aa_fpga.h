#ifndef aa_fpga_h
#define aa_fpga_h

#include "aa_esp32.h"
#include "sea_esp32_qspi.h"

#define WAVE_LIMIT  15000
#define COUNT_DELAY 5
#define COUNT_END   5000
class esp32_fpga
{
private:
    int16_t read(int ad)
    {
        uint8_t a[2];
        int16_t *b;
        SeaTrans.read(ad, a, 2);
        b = (int16_t*)a;
        return *b;    
    }
    int8_t wave()
    {
        int16_t temp = read(0);
        if(temp > WAVE_LIMIT)
            return 1;
        else if(temp < -WAVE_LIMIT)
            return -1;
        else
            return 0;
        
    }
public:
    int count()
    {
        unsigned long time_end=millis()+COUNT_END;
        int count = 0;
        int8_t pre = 0;
        int8_t next = 0;
        while(millis()<time_end)
        {
            delay(COUNT_DELAY);
            next = wave();
            if( (1==next) && (1!=pre) )
            {
                pre = next;
                ++count;
            }
            else if( (-1==next) && (-1!=pre) )
            {
                pre = next;
                ++count;
            }
            else
                ;            
        }       
        return count;            
    }
    void begin()
    {
        esp23_start();
        SeaTrans.begin();
    }
};

extern esp32_fpga Fpga;
#endif
