package example.ch22;

import java.io.DataOutputStream;
import java.util.ArrayList;
import java.util.List;

import org.pentaho.di.core.Const;
import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.RowMetaAndData;
import org.pentaho.di.core.exception.KettleStepException;
import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.core.row.ValueMetaInterface;
import org.pentaho.di.core.vfs.KettleVFS;
import org.pentaho.di.core.xml.XMLHandler;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransHopMeta;
import org.pentaho.di.trans.TransMeta;
import org.pentaho.di.trans.step.RowAdapter;
import org.pentaho.di.trans.step.RowListener;
import org.pentaho.di.trans.step.StepInterface;
import org.pentaho.di.trans.step.StepMeta;
import org.pentaho.di.trans.steps.csvinput.CsvInputMeta;
import org.pentaho.di.trans.steps.dummytrans.DummyTransMeta;
import org.pentaho.di.trans.steps.textfileinput.TextFileInputField;

public class CsvFileReader {
  
  private static String STEP_READ_A_FILE = "Read a file";
  private static String STEP_DUMMY = "Dummy";
  
  private String filename;
  private TextFileInputField[] inputFields;
  private List<RowMetaAndData> rows;

  public CsvFileReader(String filename, TextFileInputField[] inputFields) {
    this.filename = filename;
    this.inputFields = inputFields;
  }
  
  public void read() throws Exception {
    
    KettleEnvironment.init();
    
    // Create a new transformation...
    //
    TransMeta transMeta = new TransMeta();
    transMeta.setName("sample04");
    
    // Create the step to read the file
    //
    CsvInputMeta inputMeta = new CsvInputMeta();
    inputMeta.setDefault(); // comma separated, " enclosed with header.
    inputMeta.setFilename(filename);
    inputMeta.setInputFields(inputFields);
    
    StepMeta inputStep = new StepMeta(STEP_READ_A_FILE, inputMeta);
    inputStep.setLocation(50, 50);
    inputStep.setDraw(true);
    transMeta.addStep(inputStep);
    
    // Create the dummy place-holder step
    //
    DummyTransMeta dummyMeta = new DummyTransMeta();
    StepMeta dummyStep = new StepMeta(STEP_DUMMY, dummyMeta);
    dummyStep.setLocation(150, 50);
    dummyStep.setDraw(true);
    transMeta.addStep(dummyStep);
    
    // Create a hop between the 2 steps
    //
    TransHopMeta hop = new TransHopMeta(inputStep, dummyStep);
    transMeta.addTransHop(hop);

    String xml = XMLHandler.getXMLHeader() + transMeta.getXML();
    DataOutputStream dos = new DataOutputStream(KettleVFS.getOutputStream("csv-reader.ktr", false));
    dos.write(xml.getBytes(Const.XML_ENCODING));
    dos.close();
    
    // Now we can execute the transformation
    //
    Trans trans = new Trans(transMeta);
    trans.prepareExecution(null);
    
    rows = new ArrayList<RowMetaAndData>();
    RowListener rowListener = new RowAdapter() {
      public void rowWrittenEvent(RowMetaInterface rowMeta, Object[] row) throws KettleStepException {
        rows.add(new RowMetaAndData(rowMeta, row));
      }
    };
    StepInterface stepInterface = trans.findRunThread(STEP_DUMMY);
    stepInterface.addRowListener(rowListener);
    
    trans.startThreads();
    trans.waitUntilFinished();
    
    if (trans.getErrors()!=0) {
      System.out.println("Error");
    } else {
      System.out.println("We read "+rows.size()+" rows from step "+STEP_DUMMY);
    }
  }
  
  public List<RowMetaAndData> getRows() {
    return rows;
  }

  
  public static void main(String[] args) throws Exception {
    TextFileInputField id = new TextFileInputField("id", -1, 8);
    id.setTrimType(ValueMetaInterface.TRIM_TYPE_BOTH);
    id.setFormat("#");
    id.setType(ValueMetaInterface.TYPE_INTEGER);
    
    TextFileInputField firstname = new TextFileInputField("firstname", -1, 50);
    firstname.setType(ValueMetaInterface.TYPE_STRING);
    
    TextFileInputField name = new TextFileInputField("name", -1, 50);
    name.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField zip = new TextFileInputField("zip", -1, 15);
    zip.setTrimType(ValueMetaInterface.TRIM_TYPE_LEFT);
    zip.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField city = new TextFileInputField("city", -1, 50);
    city.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField birthdate = new TextFileInputField("birthdate", -1, -1);
    birthdate.setFormat("yyyy/MM/dd");
    birthdate.setType(ValueMetaInterface.TYPE_DATE);

    TextFileInputField street = new TextFileInputField("street", -1, 50);
    street.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField housenr = new TextFileInputField("housenr", -1, 15);
    housenr.setTrimType(ValueMetaInterface.TRIM_TYPE_LEFT);
    housenr.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField statecode = new TextFileInputField("statecode", -1, 2);
    statecode.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField state = new TextFileInputField("state", -1, 50);
    state.setType(ValueMetaInterface.TYPE_STRING);

    TextFileInputField[] inputFields = new TextFileInputField[] {
        id, firstname, name, zip, city, birthdate, street, housenr, statecode, state,
    };
    String filename = "/home/matt/svn/kettle/trunk/samples/transformations/files/customers-100.txt";
    CsvFileReader reader = new CsvFileReader(filename, inputFields);
    reader.read();
  }
 
}
