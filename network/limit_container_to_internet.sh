#delete all routing table rules and add new rules
gw=$(route -n | tail -n +3 | grep U | grep G | awk '{print $2}')
route del default gw $gw

#add new a rule to your routing table.
route add -net 172.17.0.0 netmask 255.255.255.0 gw $gw
