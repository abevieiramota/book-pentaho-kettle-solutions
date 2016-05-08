package example.ch22;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.Result;
import org.pentaho.di.core.RowMetaAndData;
import org.pentaho.di.core.row.ValueMetaInterface;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;

public class PassDataToTransformation {
  public static void main(String[] args) throws Exception {
    String filename = args[0];
    
    KettleEnvironment.init();
    
    TransMeta transMeta = new TransMeta(filename);
    
    Result result = new Result();
    result.setRows(createRows());
    transMeta.setPreviousResult(result);
    
    Trans trans = new Trans(transMeta);
    trans.prepareExecution(null);
    trans.startThreads();
    trans.waitUntilFinished();
    
    if (trans.getErrors()!=0) {
      System.out.println("Error");
    }
  }
  
  private static List<RowMetaAndData> createRows() {
    List<RowMetaAndData> list = new ArrayList<RowMetaAndData>();
    
    RowMetaAndData one = new RowMetaAndData();
    one.addValue("string", ValueMetaInterface.TYPE_STRING, "A sample String");
    one.addValue("date", ValueMetaInterface.TYPE_DATE, new Date());
    one.addValue("number", ValueMetaInterface.TYPE_NUMBER, Double.valueOf(123.456));
    one.addValue("integer", ValueMetaInterface.TYPE_INTEGER, Long.valueOf(123456L));
    one.addValue("big_number", ValueMetaInterface.TYPE_BIGNUMBER, 
        new BigDecimal("1234593943942.39430243953243239434"));
    one.addValue("boolean", ValueMetaInterface.TYPE_BOOLEAN, Boolean.TRUE);
    one.addValue("binary", ValueMetaInterface.TYPE_BINARY, new byte[] { 0x44, 0x50, 0x49, } );

    list.add(one);
    
    return list;
  }
  
}
