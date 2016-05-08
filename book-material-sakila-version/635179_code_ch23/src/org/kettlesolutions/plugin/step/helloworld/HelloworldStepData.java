package org.kettlesolutions.plugin.step.helloworld;

import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.trans.step.BaseStepData;
import org.pentaho.di.trans.step.StepDataInterface;

public class HelloworldStepData extends BaseStepData implements StepDataInterface {

	public RowMetaInterface outputRowMeta;

}
