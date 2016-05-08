package example.ch22;

import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;

public class ParameterTrans {
  public static void main(String[] args) throws Exception {
    String filename = args[0];
    
    KettleEnvironment.init();
    
    TransMeta transMeta = new TransMeta(filename);
    
    transMeta.setVariable("VARIABLE_NAME", "value");
    transMeta.setParameterValue("PARAMETER_NAME", "value");
    
    Trans trans = new Trans(transMeta);
    
    
    trans.prepareExecution(null);
    trans.startThreads();
    trans.waitUntilFinished();
    
    if (trans.getErrors()!=0) {
      System.out.println("Error");
    }
  }
}
