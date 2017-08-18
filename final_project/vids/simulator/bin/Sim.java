import java.util.*;
import java.io.*;

public class Sim implements Runnable 
{

    public PatientTransport transport;
    protected ArrayList<Patient> patientList;
    protected Timer timer;


    public Sim(String aConfFile )
    {
	patientList = new ArrayList<Patient>();
	transport = new HivePatientTransport();
	try{
	    BufferedReader reader = new BufferedReader( new FileReader(aConfFile ) );
	    String line;
	    while( (line = reader.readLine()) != null ){
		StringTokenizer st = new StringTokenizer( line );
		String hospital = st.nextToken();
		String id = st.nextToken();
		String name = st.nextToken();
		Patient p = new Patient(name,id,hospital);
		patientList.add(p);
	    }
	}catch( Exception e ){
	    e.printStackTrace();
	    System.exit(0);
	}
	
    }

	
    public void run()
    {
	while( true ){
	    try{
		Thread.sleep(69999);
		report();
	    }
	    catch( Exception e ){
		e.printStackTrace();
	    }
	}
    }

    public void report()
    {
	for( Patient patient : patientList ){
	    patient.asses();
	    String s = patient.toString();
	    transport.load(s);
	}
	transport.transport();
    }

    public static void main(String[] arg )
    {
	Sim s = new Sim(arg[0] );
	Thread t = new Thread( s );
	t.start();
    }

} // end class

