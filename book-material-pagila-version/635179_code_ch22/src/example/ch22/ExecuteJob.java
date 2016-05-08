package example.ch22;

import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.job.Job;
import org.pentaho.di.job.JobMeta;

public class ExecuteJob {
  public static void main(String[] args) throws Exception {
    String filename = args[0];
    
    KettleEnvironment.init();
    
    JobMeta jobMeta = new JobMeta(filename, null);
    Job job = new Job(null, jobMeta);
    job.start();
    job.waitUntilFinished();
    
    if (job.getErrors()!=0) {
      System.out.println("Error encountered!");
    }
  }
}