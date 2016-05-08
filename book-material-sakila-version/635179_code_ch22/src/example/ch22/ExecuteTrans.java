package example.ch22;

import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;

public class ExecuteTrans {
  public static void main(String[] args) throws Exception {
    String filename = args[0];
    
    KettleEnvironment.init();
    
    TransMeta transMeta = new TransMeta(filename);
    Trans trans = new Trans(transMeta);
    trans.prepareExecution(null);
    trans.startThreads();
    trans.waitUntilFinished();
    
    if (trans.getErrors()!=0) {
      System.out.println("Error");
    }
  }
}
