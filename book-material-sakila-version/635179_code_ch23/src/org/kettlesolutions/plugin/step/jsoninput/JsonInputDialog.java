package org.kettlesolutions.plugin.step.jsoninput;

import org.eclipse.swt.widgets.Shell;
import org.kettlesolutions.plugin.step.jsoninput.JsonInputMeta;
import org.pentaho.di.trans.TransMeta;
import org.pentaho.di.trans.step.BaseStepMeta;
import org.pentaho.di.trans.step.StepDialogInterface;
import org.pentaho.di.ui.trans.step.BaseStepDialog;

public class JsonInputDialog extends BaseStepDialog implements
		StepDialogInterface {

	private static Class<?> PKG = JsonInputMeta.class; // for i18n purposes, needed by Translator2!!   $NON-NLS-1$
	
	private JsonInputMeta input;
	
	public JsonInputDialog (Shell parent, Object baseStepMeta,
			TransMeta transMeta, String stepname) {
		super(parent, (BaseStepMeta)baseStepMeta, transMeta, stepname);
		input = (JsonInputMeta)baseStepMeta;
	}
	
	public String open() {
		// TODO Auto-generated method stub
		return null;
	}

}
