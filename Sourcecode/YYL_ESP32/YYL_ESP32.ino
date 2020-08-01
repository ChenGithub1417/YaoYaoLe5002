#include "aa_fpga.h"
#include "aa_aws.h"
////////
//extern Fpga
////////
void setup()
{
  Fpga.begin();
  aws_begin();
  aws_receive();
}
void loop()
{
  int a;
  a = Fpga.count();
  char s[512];
  sprintf(s,"YYL count in last five seconds: %d",a);
  aws_print(s);
}
