package org.kettlesolutions.plugin.step.jsoninput;

import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

import org.json.simple.parser.JSONParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.trans.step.BaseStepData;
import org.pentaho.di.trans.step.StepDataInterface;

public class JsonInputData extends BaseStepData implements StepDataInterface {

	public FileChannel fc;
	public ByteBuffer bb;
	public RowMetaInterface convertRowMeta;
	public RowMetaInterface outputRowMeta;
	public int numFields;

	public int preferredBufferSize;
	public String[] filenames;
	public long     rowNumber;

	public int filenameFieldIndex;
	public int rownumFieldIndex;
	public int      filenr;
	public FileInputStream fis;
	public String jsonContent;
	public JSONParser jsonParser;
	public JSONArray jsonArray;
	public int jsonArrayIndex;
	public int jsonArrayLength;
	public JSONObject jsonObject;
	public Object parsedJsonContent;
	
}
