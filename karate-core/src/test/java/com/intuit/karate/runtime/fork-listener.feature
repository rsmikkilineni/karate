Feature: log listener example

Scenario: ping
* def pingCount = { value: 0 }
* def listener = 
"""
function(line) { 
  if (line.contains('bytes=')) {
    pingCount.value++;
    karate.log('count is', pingCount.value);
  }
  if (pingCount.value == 3) {
    karate.log('3 pings done, stopping');      
    var proc = karate.get('proc');
    karate.signal(proc.buffer);
  }
}
"""
* def proc = karate.fork({ args: ['ping', 'google.com'], listener: listener, useShell: true })
* def output = karate.listen(10000)
* print 'console output:', output
