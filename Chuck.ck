
OscIn qc_data; // want to set up an OSC Receiver
OscMsg msg;    // create an OSC message
7000 => qc_data.port; // Specifies the port we want to receive on
qc_data.addAddress( "/Lab_3/test" );

// Set up our sine oscillator
TriOsc s => dac;
0.7 => s.gain;

while(true)
{
    qc_data => now;
    while( qc_data.recv(msg) )
    {
        <<< msg.typetag, msg.getFloat(0), msg.getFloat(1) >>>;
        float freq;
        float gain;
        (100 * msg.getFloat(1)) * msg.getFloat(0) => freq;
        //25 * msg.getFloat(0) => freq;
        Std.mtof(freq) => s.freq;
        msg.getFloat(1) => gain => s.gain;
        
    }
}



