import java.util.*;
import java.text.*;


public class Patient
{

    /**  Body temperature in F */
    protected float temperature;

    /** Top int of blood pressure */
    protected int BPSystolic;

    /** Bottom bumber of BP */
    protected int BPDiastolic;

    /** Breaths per minute */
    protected int respRate;

    /** Heartbeats per minute */
    protected int pulse;

    /** Level of oxygen in blood */
    protected int O2Saturation;

    /** Level of pain 1-10 (1=no pain) */
    protected int pain;

    /** Level of consciousness 1-5 (1-sleep) */
    protected int consciousness;

    /** output of urine in oz */
    protected int urineOutput;

    /** the patients name */
    protected String name;

    /** the patient ID */
    protected String id;

    /** the hospital */
    protected String hospital;

    /** Creates a new  healthy patient patient */
    public Patient(String aName, String aID, String aHospital )
    {
	name = aName;
	id = aID;
	hospital = aHospital;

	temperature = 98;
	BPSystolic = 120;
	BPDiastolic = 80;
	pulse = 70;
	O2Saturation = 96;
	pain = 1;
	consciousness = 5;
	urineOutput = 1;
    }

    public void asses()
    {
	temperature += Math.random();
	BPSystolic += 10*(int)Math.random();
	BPDiastolic += 2*(int)Math.random();
	pulse += 2*Math.random();
    }

    public String toString()
    {
	String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date()); 
	StringBuffer sb = new StringBuffer();
	sb.append("(");
	sb.append("'");sb.append(id);sb.append("'");sb.append(",");
	sb.append("'");sb.append(hospital);sb.append("'");sb.append(",");
	sb.append("'");sb.append(name);sb.append("'");sb.append(",");
	sb.append("'");sb.append(temperature);sb.append("'");sb.append(",");
	sb.append("'");sb.append(BPSystolic);sb.append("'");sb.append(",");
	sb.append("'");sb.append(BPDiastolic);sb.append("'");sb.append(",");
	sb.append("'");sb.append(respRate);sb.append("'");sb.append(",");
	sb.append("'");sb.append(pulse);sb.append("'");sb.append(",");
	sb.append("'");sb.append(O2Saturation);sb.append("'");sb.append(",");
	sb.append("'");sb.append(pain);sb.append("'");sb.append(",");
	sb.append("'");sb.append(consciousness);sb.append("'");sb.append(",");
	sb.append("'");sb.append(urineOutput);sb.append("'");sb.append(",");
	sb.append("'");sb.append(timeStamp);sb.append("'");
	sb.append(")");
	return sb.toString();

    }

    public void report()
    {
	System.out.println( this.toString() );
	System.out.println( "Name: " + name );
	System.out.println( "ID: " + id );
	System.out.println( "Temperature: "+ temperature);
	System.out.println( "BP Systolic: "+ BPSystolic);
	System.out.println( "BP Diastolic: "+BPDiastolic );
	System.out.println( "Pulse: "+pulse );
	System.out.println( "Pain: "+pain );
	System.out.println( "Consciousness: "+consciousness );
	System.out.println( "Urine output: "+urineOutput );
    }


   

	
}