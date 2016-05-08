package org.kettlesolutions.plugin.step.jsoninput;

import java.util.List;
import java.util.Map;

import org.pentaho.di.core.CheckResult;
import org.pentaho.di.core.CheckResultInterface;
import org.pentaho.di.core.Const;
import org.pentaho.di.core.Counter;
import org.pentaho.di.core.annotations.Step;
import org.pentaho.di.core.database.DatabaseMeta;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.exception.KettleStepException;
import org.pentaho.di.core.exception.KettleXMLException;
import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.core.row.ValueMeta;
import org.pentaho.di.core.row.ValueMetaInterface;
import org.pentaho.di.core.variables.VariableSpace;
import org.pentaho.di.core.xml.XMLHandler;
import org.pentaho.di.i18n.BaseMessages;
import org.pentaho.di.repository.ObjectId;
import org.pentaho.di.repository.Repository;
import org.pentaho.di.trans.Trans;
import org.pentaho.di.trans.TransMeta;
import org.pentaho.di.trans.step.BaseStepMeta;
import org.pentaho.di.trans.step.StepDataInterface;
import org.pentaho.di.trans.step.StepInterface;
import org.pentaho.di.trans.step.StepMeta;
import org.pentaho.di.trans.step.StepMetaInterface;
import org.pentaho.di.trans.steps.textfileinput.TextFileInputField;
import org.w3c.dom.Node;

@Step(
		id="JsonInput",
		name="name",
		description="description",
		categoryDescription="categoryDescription", 
		image="org/kettlesolutions/plugin/step/jsoninput/JsonInput.png",
		i18nPackageName="org.kettlesolutions.plugin.step.jsoninput"
) 
public class JsonInputMeta extends BaseStepMeta implements StepMetaInterface {

	private static Class<?> PKG = JsonInput.class; // for i18n purposes, needed by Translator2!!   $NON-NLS-1$
	public enum Tag {
		filename,
		filename_field,
		rownum_field,
		include_filename,
		buffer_size,
		add_filename_result,
		//tags for the fields
		fields, field,
		name,
		type,
		format,
		currency,
		decimal,
		group,
		length,
		precision,
		trim_type
	};
	
	private String filename;

	private String filenameField;
	private boolean includingFilename; 
	private String rowNumField;
	private String bufferSize;
	private TextFileInputField[] inputFields;
	private boolean isaddresult;
	
	public JsonInputMeta()
	{
		super(); // allocate BaseStepMeta
		allocate(0);
	}

	/**
	 * @return the filename
	 */
	public String getFilename() {
		return filename;
	}

	/**
	 * @param filename the filename to set
	 */
	public void setFilename(String filename) {
		this.filename = filename;
	}

	/**
	 * @return the filenameField
	 */
	public String getFilenameField() {
		return filenameField;
	}

	/**
	 * @param filenameField the filenameField to set
	 */
	public void setFilenameField(String filenameField) {
		this.filenameField = filenameField;
	}

	/**
	 * @return the includingFilename
	 */
	public boolean isIncludingFilename() {
		return includingFilename;
	}

	/**
	 * @param includingFilename the includingFilename to set
	 */
	public void setIncludingFilename(boolean includingFilename) {
		this.includingFilename = includingFilename;
	}

	/**
	 * @return the rowNumField
	 */
	public String getRowNumField() {
		return rowNumField;
	}

	/**
	 * @param rowNumField the rowNumField to set
	 */
	public void setRowNumField(String rowNumField) {
		this.rowNumField = rowNumField;
	}

	/**
	 * @return the bufferSize
	 */
	public String getBufferSize() {
		return bufferSize;
	}

	/**
	 * @param bufferSize the bufferSize to set
	 */
	public void setBufferSize(String bufferSize) {
		this.bufferSize = bufferSize;
	}

	/**
	 * @return the isaddresult
	 */
	public boolean isIsaddresult() {
		return isaddresult;
	}

	/**
	 * @param isaddresult the isaddresult to set
	 */
	public void setIsaddresult(boolean isaddresult) {
		this.isaddresult = isaddresult;
	}

	public TextFileInputField[] getInputFields() {
		return inputFields;
	}

	public void allocate(int nrFields) {
		inputFields = new TextFileInputField[nrFields];
	}

	public String getXML()
	{
		StringBuffer retval = new StringBuffer(500);

		retval.append("    ").append(XMLHandler.addTagValue(Tag.filename.name(), filename));
		retval.append("    ").append(XMLHandler.addTagValue(Tag.filename_field.name(), filenameField));
		retval.append("    ").append(XMLHandler.addTagValue(Tag.rownum_field.name(), rowNumField));
		retval.append("    ").append(XMLHandler.addTagValue(Tag.include_filename.name(), includingFilename));
		retval.append("    ").append(XMLHandler.addTagValue(Tag.buffer_size.name(), bufferSize));
		retval.append("    ").append(XMLHandler.addTagValue(Tag.add_filename_result.name(), isaddresult));

		retval.append("    ").append(Tag.fields.name()).append(Const.CR);
		for (int i = 0; i < inputFields.length; i++)
		{
			TextFileInputField field = inputFields[i];
			
			retval.append("        ").append(Tag.field.name()).append(Const.CR);
			retval.append("        ").append(XMLHandler.addTagValue(Tag.name.name(), field.getName()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.type.name(), ValueMeta.getTypeDesc(field.getType())));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.format.name(), field.getFormat()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.currency.name(), field.getCurrencySymbol()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.decimal.name(), field.getDecimalSymbol()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.group.name(), field.getGroupSymbol()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.length.name(), field.getLength()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.precision.name(), field.getPrecision()));
			retval.append("        ").append(XMLHandler.addTagValue(Tag.trim_type.name(), ValueMeta.getTrimTypeCode(field.getTrimType())));
			retval.append("        ").append(Tag.field.name()).append(Const.CR);
		}
		retval.append("    ").append(Tag.fields.name()).append(Const.CR);

		return retval.toString();
	}
	
	public void loadXML(Node stepnode, List<DatabaseMeta> databases, Map<String, Counter> counters)
	throws KettleXMLException
	{
		try
		{
			filename = XMLHandler.getTagValue(stepnode, Tag.filename.name());
			filenameField = XMLHandler.getTagValue(stepnode, Tag.filename_field.name());
			rowNumField = XMLHandler.getTagValue(stepnode, Tag.rownum_field.name());
			includingFilename = "Y".equalsIgnoreCase(XMLHandler.getTagValue(stepnode, Tag.include_filename.name()));
			bufferSize  = XMLHandler.getTagValue(stepnode, Tag.buffer_size.name());
			isaddresult= "Y".equalsIgnoreCase(XMLHandler.getTagValue(stepnode, Tag.add_filename_result.name()));
			
			Node fields = XMLHandler.getSubNode(stepnode, Tag.fields.name());
			int nrfields = XMLHandler.countNodes(fields, Tag.field.name());
			
			allocate(nrfields);

			for (int i = 0; i < nrfields; i++)
			{
				inputFields[i] = new TextFileInputField();
				
				Node fnode = XMLHandler.getSubNodeByNr(fields, Tag.field.name(), i);

				inputFields[i].setName( XMLHandler.getTagValue(fnode, Tag.name.name()) );
				inputFields[i].setType(  ValueMeta.getType(XMLHandler.getTagValue(fnode, Tag.type.name())) );
				inputFields[i].setFormat( XMLHandler.getTagValue(fnode, Tag.format.name()) );
				inputFields[i].setCurrencySymbol( XMLHandler.getTagValue(fnode, Tag.currency.name()) );
				inputFields[i].setDecimalSymbol( XMLHandler.getTagValue(fnode, Tag.decimal.name()) );
				inputFields[i].setGroupSymbol( XMLHandler.getTagValue(fnode, Tag.group.name()) );
				inputFields[i].setLength( Const.toInt(XMLHandler.getTagValue(fnode, Tag.length.name()), -1) );
				inputFields[i].setPrecision( Const.toInt(XMLHandler.getTagValue(fnode, Tag.precision.name()), -1) );
				inputFields[i].setTrimType( ValueMeta.getTrimTypeByCode( XMLHandler.getTagValue(fnode, Tag.trim_type.name()) ) );
			}
		}
		catch (Exception e)
		{
			throw new KettleXMLException("Unable to load step info from XML", e);
		}

	}

	public void readRep(Repository rep, ObjectId idStep,
			List<DatabaseMeta> databases, Map<String, Counter> counters)
			throws KettleException {
		try
		{
			filename = rep.getStepAttributeString(idStep, Tag.filename.name());
			filenameField = rep.getStepAttributeString(idStep, Tag.filename_field.name());
			rowNumField = rep.getStepAttributeString(idStep, Tag.rownum_field.name());
			includingFilename = rep.getStepAttributeBoolean(idStep, Tag.include_filename.name());
			bufferSize = rep.getStepAttributeString(idStep, Tag.buffer_size.name());
			isaddresult = rep.getStepAttributeBoolean(idStep, Tag.add_filename_result.name());
			
			int nrfields = rep.countNrStepAttributes(idStep, "field_name");
			allocate(nrfields);

			for (int i = 0; i < nrfields; i++)
			{
				inputFields[i] = new TextFileInputField();
				
				inputFields[i].setName( rep.getStepAttributeString(idStep, i, "field_name") );
				inputFields[i].setType( ValueMeta.getType(rep.getStepAttributeString(idStep, i, "field_type")) );
				inputFields[i].setFormat( rep.getStepAttributeString(idStep, i, "field_format") );
				inputFields[i].setCurrencySymbol( rep.getStepAttributeString(idStep, i, "field_currency") );
				inputFields[i].setDecimalSymbol( rep.getStepAttributeString(idStep, i, "field_decimal") );
				inputFields[i].setGroupSymbol( rep.getStepAttributeString(idStep, i, "field_group") );
				inputFields[i].setLength( (int) rep.getStepAttributeInteger(idStep, i, "field_length") );
				inputFields[i].setPrecision( (int) rep.getStepAttributeInteger(idStep, i, "field_precision") );
				inputFields[i].setTrimType( ValueMeta.getTrimTypeByCode( rep.getStepAttributeString(idStep, i, "field_trim_type")) );
			}
		}
		catch (Exception e)
		{
			throw new KettleException("Unexpected error reading step information from the repository", e);
		}
	}

	public void saveRep(Repository rep, ObjectId idTransformation,
			ObjectId idStep) throws KettleException {
		try
		{
			rep.saveStepAttribute(idTransformation, idStep, Tag.filename.name(), filename);
			rep.saveStepAttribute(idTransformation, idStep, Tag.filename_field.name(), filenameField);
			rep.saveStepAttribute(idTransformation, idStep, Tag.rownum_field.name(), rowNumField);
			rep.saveStepAttribute(idTransformation, idStep, Tag.include_filename.name(), includingFilename);
			rep.saveStepAttribute(idTransformation, idStep, Tag.buffer_size.name(), bufferSize);
			rep.saveStepAttribute(idTransformation, idStep, Tag.add_filename_result.name(), isaddresult);

			for (int i = 0; i < inputFields.length; i++)
			{
				TextFileInputField field = inputFields[i];
				
				rep.saveStepAttribute(idTransformation, idStep, i, "field_name", field.getName());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_type", ValueMeta.getTypeDesc(field.getType()));
				rep.saveStepAttribute(idTransformation, idStep, i, "field_format", field.getFormat());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_currency", field.getCurrencySymbol());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_decimal", field.getDecimalSymbol());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_group", field.getGroupSymbol());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_length", field.getLength());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_precision", field.getPrecision());
				rep.saveStepAttribute(idTransformation, idStep, i, "field_trim_type", ValueMeta.getTrimTypeCode( field.getTrimType()));
			}
		}
		catch (Exception e)
		{
			throw new KettleException("Unable to save step information to the repository for idStep=" + idStep, e);
		}
	}

	public void getFields(RowMetaInterface rowMeta, String origin, RowMetaInterface[] info, StepMeta nextStep, VariableSpace space) throws KettleStepException
	{
		rowMeta.clear(); // Start with a clean slate, eats the input
		
		for (int i=0;i<inputFields.length;i++) {
			TextFileInputField field = inputFields[i];
			
			ValueMetaInterface valueMeta = new ValueMeta(field.getName(), field.getType());
			valueMeta.setConversionMask( field.getFormat() );
			valueMeta.setLength( field.getLength() );
			valueMeta.setPrecision( field.getPrecision() );
			valueMeta.setConversionMask( field.getFormat() );
			valueMeta.setDecimalSymbol( field.getDecimalSymbol() );
			valueMeta.setGroupingSymbol( field.getGroupSymbol() );
			valueMeta.setCurrencySymbol( field.getCurrencySymbol() );
			valueMeta.setTrimType( field.getTrimType() );
		
			// In case we want to convert Strings...
			// Using a copy of the valueMeta object means that the inner and outer representation format is the same.
			// Preview will show the data the same way as we read it.
			// This layout is then taken further down the road by the metadata through the transformation.
			//
			ValueMetaInterface storageMetadata = valueMeta.clone();
			storageMetadata.setType(ValueMetaInterface.TYPE_STRING);
			storageMetadata.setStorageType(ValueMetaInterface.STORAGE_TYPE_NORMAL);
			storageMetadata.setLength(-1,-1); // we don't really know the lengths of the strings read in advance.
			valueMeta.setStorageMetadata(storageMetadata);
			
			valueMeta.setOrigin(origin);
			
			rowMeta.addValueMeta(valueMeta);
		}
		
		if (!Const.isEmpty(filenameField) && includingFilename) {
			ValueMetaInterface filenameMeta = new ValueMeta(filenameField, ValueMetaInterface.TYPE_STRING);
			filenameMeta.setOrigin(origin);
			rowMeta.addValueMeta(filenameMeta);
		}
		
		if (!Const.isEmpty(rowNumField)) {
			ValueMetaInterface rowNumMeta = new ValueMeta(rowNumField, ValueMetaInterface.TYPE_INTEGER);
			rowNumMeta.setLength(10);
			rowNumMeta.setOrigin(origin);
			rowMeta.addValueMeta(rowNumMeta);
		}		
	}
	
	
	public void check(List<CheckResultInterface> remarks, TransMeta transMeta,
			StepMeta stepMeta, RowMetaInterface prev, String[] input,
			String[] output, RowMetaInterface info) {
		CheckResult cr;
		if (prev==null || prev.size()==0)
		{
			cr = new CheckResult(
				CheckResultInterface.TYPE_RESULT_OK, 
				BaseMessages.getString(PKG, "JsonInputMeta.CheckResult.NotReceivingFields"), 
				stepMeta
			); //$NON-NLS-1$
			remarks.add(cr);
		}
		else
		{
			cr = new CheckResult(
				CheckResultInterface.TYPE_RESULT_ERROR, 
				BaseMessages.getString(PKG, "JsonInputMeta.CheckResult.StepRecevingData", prev.size()+""), 
				stepMeta
			); //$NON-NLS-1$ //$NON-NLS-2$
			remarks.add(cr);
		}
		
		// See if we have input streams leading to this step!
		if (input.length>0)
		{
			cr = new CheckResult(
				CheckResultInterface.TYPE_RESULT_ERROR, 
				BaseMessages.getString(PKG, "JsonInputMeta.CheckResult.StepRecevingData2"), 
				stepMeta
			); //$NON-NLS-1$
			remarks.add(cr);
		}
		else
		{
			cr = new CheckResult(
				CheckResultInterface.TYPE_RESULT_OK, 
				BaseMessages.getString(PKG, "CsvInputMeta.CheckResult.NoInputReceivedFromOtherSteps"), 
				stepMeta
			); //$NON-NLS-1$
			remarks.add(cr);
		}
	}

	public String getDialogClassName() {
		return JsonInputDialog.class.getName();
	}

	public StepInterface getStep(StepMeta stepMeta, StepDataInterface stepDataInterface, int cnr, TransMeta tr, Trans trans)
	{
		return new JsonInput(stepMeta, stepDataInterface, cnr, tr, trans);
	}
	
	public StepDataInterface getStepData()
	{
		return new JsonInputData();
	}
		
	public void setDefault() {
		isaddresult=false;
		bufferSize="50000";
	}

}
