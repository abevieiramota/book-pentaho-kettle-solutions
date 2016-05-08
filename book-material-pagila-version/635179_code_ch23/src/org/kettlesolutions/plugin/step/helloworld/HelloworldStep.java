package org.kettlesolutions.plugin.step.helloworld;

import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.row.RowDataUtil;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;
import org.pentaho.di.trans.step.BaseStep;
import org.pentaho.di.trans.step.StepDataInterface;
import org.pentaho.di.trans.step.StepInterface;
import org.pentaho.di.trans.step.StepMeta;
import org.pentaho.di.trans.step.StepMetaInterface;

public class HelloworldStep extends BaseStep implements StepInterface {

	public HelloworldStep(StepMeta stepMeta, StepDataInterface stepDataInterface,
			int copyNr, TransMeta transMeta, Trans trans) {
		super(stepMeta, stepDataInterface, copyNr, transMeta, trans);
		// TODO Auto-generated constructor stub
	}

	
	public boolean processRow(StepMetaInterface smi, StepDataInterface sdi) throws KettleException {

		HelloworldStepMeta meta  = (HelloworldStepMeta) smi;
		HelloworldStepData data = (HelloworldStepData) sdi;
		
		Object[] row = getRow();
		if (row==null) {
			setOutputDone();
			return false;
		}
		
		if (first) {
			first=false;
			
			data.outputRowMeta = getInputRowMeta().clone();
			meta.getFields(data.outputRowMeta, getStepname(), null, null, this);
		}
		
		String value = "Hello, world!";
		
		Object[] outputRow = RowDataUtil.addValueData(row, getInputRowMeta().size(), value);
		
		putRow(data.outputRowMeta, outputRow);
		
		return true;
	}
}
