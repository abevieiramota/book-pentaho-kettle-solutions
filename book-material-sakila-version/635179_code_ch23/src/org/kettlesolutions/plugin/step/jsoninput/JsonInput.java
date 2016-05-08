package org.kettlesolutions.plugin.step.jsoninput;

import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.vfs.FileObject;
import org.apache.commons.vfs.provider.local.LocalFile;
import org.json.simple.parser.JSONParser;
import org.pentaho.di.core.Const;
import org.pentaho.di.core.ResultFile;
import org.pentaho.di.core.exception.KettleConversionException;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.exception.KettleFileException;
import org.pentaho.di.core.exception.KettleValueException;
import org.pentaho.di.core.row.RowDataUtil;
import org.pentaho.di.core.row.RowMeta;
import org.pentaho.di.core.row.ValueMetaInterface;
import org.pentaho.di.core.vfs.KettleVFS;
import org.pentaho.di.i18n.BaseMessages;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;
import org.pentaho.di.trans.step.BaseStep;
import org.pentaho.di.trans.step.StepDataInterface;
import org.pentaho.di.trans.step.StepInterface;
import org.pentaho.di.trans.step.StepMeta;
import org.pentaho.di.trans.step.StepMetaInterface;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JsonInput extends BaseStep implements StepInterface {

	private static Class<?> PKG = JsonInput.class; // for i18n purposes, needed by Translator2!!   $NON-NLS-1$

	private JsonInputMeta meta;
	private JsonInputData data;
	
	public JsonInput(StepMeta stepMeta, StepDataInterface stepDataInterface,
			int copyNr, TransMeta transMeta, Trans trans) {
		super(stepMeta, stepDataInterface, copyNr, transMeta, trans);
		// TODO Auto-generated constructor stub
	}

	public boolean processRow(StepMetaInterface smi, StepDataInterface sdi) throws KettleException
	{
		meta=(JsonInputMeta)smi;
		data=(JsonInputData)sdi;

		if (first) {
			data.jsonParser = new JSONParser();
			first=false;
			
			data.outputRowMeta = new RowMeta();
			meta.getFields(data.outputRowMeta, getStepname(), null, null, this);
			data.numFields = data.outputRowMeta.size();

			if (data.filenames==null) {
				// We're expecting the list of filenames from the previous step(s)...
				//
				getFilenamesFromPreviousSteps();
			}
						
			// The conversion logic for when the lazy conversion is turned of is simple:
			// Pretend it's a lazy conversion object anyway and get the native type during conversion.
			//
			data.convertRowMeta = data.outputRowMeta.clone();
			
			// Calculate the indexes for the filename and row number fields
			//
			data.filenameFieldIndex = -1;
			if (!Const.isEmpty(meta.getFilenameField()) && meta.isIncludingFilename()) {
				data.filenameFieldIndex = meta.getInputFields().length;
			}
			
			data.rownumFieldIndex = -1;
			if (!Const.isEmpty(meta.getRowNumField())) {
				data.rownumFieldIndex = meta.getInputFields().length;
				if (data.filenameFieldIndex>=0) {
					data.rownumFieldIndex++;
				}
			}
						
			// Open the next file...
			if (!openNextFile()) {
				setOutputDone();
				return false; // nothing to see here, move along...
			}
			
		}
				
		try {
			Object[] outputRowData = readOneRow(true);    // get row, set busy!
			if (outputRowData==null)  // no more input to be expected...
			{
				if (openNextFile()) {
					return true; // try again on the next loop...
				}
				else {
					setOutputDone(); // last file, end here
					return false;
				}
			}
			else 
			{
				putRow(data.outputRowMeta, outputRowData);     // copy row to possible alternate rowset(s).
		        if (checkFeedback(getLinesInput())) 
		        {
		        	if(log.isBasic()) logBasic(BaseMessages.getString(PKG, "CsvInput.Log.LineNumber", Long.toString(getLinesInput()))); //$NON-NLS-1$
		        }
			}
		}
		catch(KettleConversionException e) {
			if (meta.supportsErrorHandling()) {
				StringBuffer errorDescriptions = new StringBuffer(100);
				StringBuffer errorFields = new StringBuffer(50);
				for (int i=0;i<e.getCauses().size();i++) {
					if (i>0) {
						errorDescriptions.append(", ");
						errorFields.append(", ");
					}
					errorDescriptions.append(e.getCauses().get(i).getMessage());
					errorFields.append(e.getFields().get(i).toStringMeta());
				}
				
				putError(data.outputRowMeta, e.getRowData(), e.getCauses().size(), errorDescriptions.toString(), errorFields.toString(), "CSVINPUT001");
			}
		}
			
		return true;
	}

	protected Object[] readOneRow(boolean doConversions){
		if (data.jsonObject==null){
			return null;
		}
		Object[] outputRowData = RowDataUtil.allocateRowData(data.outputRowMeta.size());
		ValueMetaInterface field;
		Object value;
		for (int i=0; i<data.numFields; i++){
			field = data.outputRowMeta.getValueMeta(i);
			value = data.jsonObject.get(field.getName());
			switch(field.getType()){
				case ValueMetaInterface.TYPE_BIGNUMBER:
					if (value instanceof Integer) {
						outputRowData[i] = new BigDecimal(((Integer)value).intValue());
					} else if (value instanceof Long) {
						outputRowData[i] = new BigDecimal(((Long)value).longValue());
					} else if (value instanceof Float) {
						outputRowData[i] = new BigDecimal(((Float)value).floatValue());
					} else if (value instanceof Double){
						outputRowData[i] = new BigDecimal(((Double)value).doubleValue());
					}					
					break;
				case ValueMetaInterface.TYPE_BINARY:
					outputRowData[i] = data.jsonObject.toJSONString().getBytes();
					break;
				case ValueMetaInterface.TYPE_BOOLEAN:
					if (value instanceof Boolean){
						outputRowData[i] = value;
					} else if (value instanceof String){
					}
					break;
				case ValueMetaInterface.TYPE_DATE:
					break;
				case ValueMetaInterface.TYPE_INTEGER:
					if (value instanceof Integer) {
						outputRowData[i] = new Long((Integer)value);
					} else if (value instanceof Long) {
						outputRowData[i] = value;
					} else if (value instanceof Float) {
						outputRowData[i] = new Long(((Float)value).longValue());
					} else if (value instanceof Double){
						outputRowData[i] = new Long(((Double)value).longValue());
					}
					break;
				case ValueMetaInterface.TYPE_STRING:
					outputRowData[i] = data.jsonObject.toJSONString();
					break;
			}
		}

		data.jsonArrayIndex++;
		if (data.jsonArrayIndex < data.jsonArrayLength){
			data.jsonObject = (JSONObject)data.jsonArray.get(data.jsonArrayIndex);
		}
		else {
			data.jsonObject = null;
		}
		return outputRowData;
	}
	
	private void getFilenamesFromPreviousSteps() throws KettleException {
		List<String> filenames = new ArrayList<String>();
		boolean firstRow = true;
		int index=-1;
		Object[] row = getRow();
		while (row!=null) {
			
			if (firstRow) {
				firstRow=false;
				
				// Get the filename field index...
				//
				String filenameField = environmentSubstitute(meta.getFilenameField());
				index = getInputRowMeta().indexOfValue(filenameField);
				if (index<0) {
					throw new KettleException(BaseMessages.getString(PKG, "JsonInput.Exception.FilenameFieldNotFound", filenameField));
				}
			}
				
			String filename = getInputRowMeta().getString(row, index);
			filenames.add(filename);  // add it to the list...
			
			row = getRow(); // Grab another row...
		}
		
		data.filenames = filenames.toArray(new String[filenames.size()]);
		
		logBasic(BaseMessages.getString(PKG, "JsonInput.Log.ReadingFromNrFiles", Integer.toString(data.filenames.length)));
	}
	
	private boolean openNextFile() throws KettleException {
		try {

			if (data.filenr>=data.filenames.length) {
				return false;
			}

			// Open the next one...
			//
			FileObject fileObject = KettleVFS.getFileObject(data.filenames[data.filenr], getTransMeta());
			data.jsonContent = KettleVFS.getTextFileContent(data.filenames[data.filenr], getTransMeta(), "UTF-8");
			data.parsedJsonContent = data.jsonParser.parse(data.jsonContent);
			data.jsonArrayIndex = 0;
			if (data.parsedJsonContent instanceof JSONObject){
				data.jsonObject = data.parsedJsonContent;
				data.jsonArrayLength = 1;
			}
			else if (data.parsedJsonContent instanceof JSONArray){
				data.jsonArray = (JSONArray)data.parsedJsonContent ;
				data.jsonArrayLength = data.jsonArray.size();				
			}
			
			// Add filename to result filenames ?
			if(meta.isIsaddresult())
			{
				ResultFile resultFile = new ResultFile(ResultFile.FILE_TYPE_GENERAL, fileObject, getTransMeta().getName(), toString());
				resultFile.setComment("File was read by a Json input step");
				addResultFile(resultFile);
			}
			
			// Move to the next filename
			//
			data.filenr++;
						
			// Reset the row number pointer...
			//
			data.rowNumber = 1L;
			
			return true;
		}
		catch(KettleException e) {
			throw e;
		}
		catch(Exception e) {
			throw new KettleException(e);
		}
	}
}
