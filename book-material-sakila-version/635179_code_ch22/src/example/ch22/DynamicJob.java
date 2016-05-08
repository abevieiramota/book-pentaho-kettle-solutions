package example.ch22;

import java.util.HashSet;
import java.util.List;

import org.pentaho.di.core.ObjectLocationSpecificationMethod;
import org.pentaho.di.core.Result;
import org.pentaho.di.core.SQLStatement;
import org.pentaho.di.core.database.DatabaseMeta;
import org.pentaho.di.job.Job;
import org.pentaho.di.job.JobHopMeta;
import org.pentaho.di.job.JobMeta;
import org.pentaho.di.job.entries.sql.JobEntrySQL;
import org.pentaho.di.job.entries.trans.JobEntryTrans;
import org.pentaho.di.job.entry.JobEntryCopy;
import org.pentaho.di.trans.TransMeta;

public class DynamicJob {
  
  public static JobMeta generateJobMeta(String transFilename) throws Exception {
    JobMeta jobMeta = new JobMeta();
    jobMeta.setName("sample05");

    int x = 50;
    int y = 50;
    
    // Add the start entry...
    //
    JobEntryCopy startCopy = JobMeta.createStartEntry();
    startCopy.setLocation(x, y);
    startCopy.setDrawn();
    jobMeta.addJobEntry(startCopy);
    JobEntryCopy lastCopy = startCopy;

    // Determine the SQL and databases needed to execute the transformation
    //
    TransMeta transMeta = new TransMeta(transFilename);
    HashSet<DatabaseMeta> databases = new HashSet<DatabaseMeta>();
    List<SQLStatement> sqlStatements = transMeta.getSQLStatements();
    for (SQLStatement stat : sqlStatements) {
      databases.add(stat.getDatabase());
    }
    
    
    // Add "Execute SQL script" for every used database...
    //
    for (DatabaseMeta databaseMeta : databases) {
      JobEntrySQL jobEntrySql = new JobEntrySQL();
      jobEntrySql.setDatabase(databaseMeta);
      
      String sql = "";
      for (SQLStatement sqlStatement : sqlStatements) {
        if (sqlStatement.getDatabase().equals(databaseMeta)) {
          if (!sqlStatement.hasError() && sqlStatement.hasSQL())
          {
              sql += sqlStatement.getSQL();
          }
        }
      }
      jobEntrySql.setSQL(sql);
      
      JobEntryCopy sqlCopy = new JobEntryCopy(jobEntrySql);
      sqlCopy.setName("SQL for "+databaseMeta.getName());
      x+=100;
      sqlCopy.setLocation(x, y);
      sqlCopy.setDrawn();
      jobMeta.addJobEntry(sqlCopy);
      
      JobHopMeta sqlHop = new JobHopMeta(lastCopy, sqlCopy);
      jobMeta.addJobHop(sqlHop);
      lastCopy = sqlCopy;
    }
    
    // Now execute the transformation as well...
    //
    JobEntryTrans jobEntryTrans = new JobEntryTrans();
    jobEntryTrans.setSpecificationMethod(ObjectLocationSpecificationMethod.FILENAME);
    jobEntryTrans.setFileName(transFilename);
    
    JobEntryCopy transCopy = new JobEntryCopy(jobEntryTrans);
    transCopy.setName("Execute "+transFilename);
    x+=100;
    transCopy.setLocation(x, y);
    transCopy.setDrawn();
    jobMeta.addJobEntry(transCopy);
   
    JobHopMeta transHop = new JobHopMeta(lastCopy, transCopy);
    jobMeta.addJobHop(transHop);
    lastCopy = transCopy;
    
    return jobMeta;
  }
  
  public static Result executeTransformation(String transFilename) throws Exception {
    JobMeta jobMeta = generateJobMeta(transFilename);
    Job job = new Job(null, jobMeta);
    job.start();
    job.waitUntilFinished();
    return job.getResult();
  }
  
}
