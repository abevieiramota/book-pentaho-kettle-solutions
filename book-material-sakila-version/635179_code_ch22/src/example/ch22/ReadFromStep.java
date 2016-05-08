package example.ch22;

import java.util.ArrayList;
import java.util.List;

import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.RowMetaAndData;
import org.pentaho.di.core.exception.KettleStepException;
import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;
import org.pentaho.di.trans.step.RowAdapter;
import org.pentaho.di.trans.step.RowListener;
import org.pentaho.di.trans.step.StepInterface;

public class ReadFromStep {
  public static void main(String[] args) throws Exception {
    String filename = args[0];
    String stepname = args[1];
    
    KettleEnvironment.init();
    
    TransMeta transMeta = new TransMeta(filename);
    Trans trans = new Trans(transMeta);
    trans.prepareExecution(null);
    
    final List<RowMetaAndData> rows = new ArrayList<RowMetaAndData>();
    RowListener rowListener = new RowAdapter() {
      public void rowWrittenEvent(RowMetaInterface rowMeta, Object[] row) throws KettleStepException {
        rows.add(new RowMetaAndData(rowMeta, row));
      }
    };
    StepInterface stepInterface = trans.findRunThread(stepname);
    stepInterface.addRowListener(rowListener);
    
    trans.startThreads();
    trans.waitUntilFinished();
    
    if (trans.getErrors()!=0) {
      System.out.println("Error");
    } else {
      System.out.println("We read "+rows.size()+" rows from step "+stepname);
    }
  }
}
