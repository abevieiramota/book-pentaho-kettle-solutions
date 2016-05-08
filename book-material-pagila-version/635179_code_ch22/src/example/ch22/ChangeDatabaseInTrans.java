package example.ch22;

import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.database.DatabaseMeta;
import org.pentaho.di.shared.SharedObjects;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;

public class ChangeDatabaseInTrans {
  public static void main(String[] args) throws Exception {
    String filename = args[0];
    
    KettleEnvironment.init();
    
    DatabaseMeta databaseMeta = new DatabaseMeta("DB", "MySQL", "JDBC", "localhost", "test", "3306", "user", "password");
    
    SharedObjects sharedObjects = new SharedObjects();
    sharedObjects.storeObject(databaseMeta);
    sharedObjects.setFilename("/tmp/shared.xml");
    sharedObjects.saveToFile();
    
    // System.setProperty(Const.KETTLE_SHARED_OBJECTS, "/tmp/shared.xml");
    
    TransMeta transMeta = new TransMeta(filename);
    transMeta.setSharedObjectsFile("/tmp/shared.xml");
    transMeta.readSharedObjects();
    
    Trans trans = new Trans(transMeta);
    trans.prepareExecution(null);
    trans.startThreads();
    trans.waitUntilFinished();
    
    if (trans.getErrors()!=0) {
      System.out.println("Error");
    }
  }
}
