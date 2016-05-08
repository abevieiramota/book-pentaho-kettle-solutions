/*
 * Copyright (c) 2007 Pentaho Corporation.  All rights reserved. 
 * This software was developed by Pentaho Corporation and is provided under the terms 
 * of the GNU Lesser General Public License, Version 2.1. You may not use 
 * this file except in compliance with the license. If you need a copy of the license, 
 * please go to http://www.gnu.org/licenses/lgpl-2.1.txt. The Original Code is Pentaho 
 * Data Integration.  The Initial Developer is Pentaho Corporation.
 *
 * Software distributed under the GNU Lesser Public License is distributed on an "AS IS" 
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or  implied. Please refer to 
 * the license for the specific language governing your rights and limitations.
 */
package org.kettlesolutions.plugin.partitioner.hour;

import org.pentaho.di.core.Const;
import org.pentaho.di.core.annotations.PartitionerPlugin;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.exception.KettleStepException;
import org.pentaho.di.core.exception.KettleXMLException;
import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.core.row.ValueMetaInterface;
import org.pentaho.di.core.xml.XMLHandler;
import org.pentaho.di.i18n.BaseMessages;
import org.pentaho.di.repository.ObjectId;
import org.pentaho.di.repository.Repository;
import org.pentaho.di.trans.BasePartitioner;
import org.pentaho.di.trans.Partitioner;
import org.w3c.dom.Node;

@PartitionerPlugin(
		i18nPackageName="org.pentaho.di.sample.partitioner.hour",
		id = "HourPartitioner", 
		name = "HourPartitionerDescription", 
		description = "HourPartitionerTooltip"
	)
public class HourPartitioner extends BasePartitioner {
    private static Class<?> PKG = HourPartitioner.class; // for i18n purposes, needed by Translator2!!   $NON-NLS-1$

	private String	fieldName;
	protected int	partitionColumnIndex	= -1;

	public HourPartitioner() {
		super();
	}

	public Partitioner getInstance() {
		Partitioner partitioner = new HourPartitioner();
		partitioner.setId(getId());
		partitioner.setDescription(getDescription());
		return partitioner;
	}

	public HourPartitioner clone() {
		HourPartitioner modPartitioner = (HourPartitioner) super.clone();
		modPartitioner.fieldName = fieldName;

		return modPartitioner;
	}

	public String getDialogClassName() {
		return HourPartitionerDialog.class.getName();
	}

	public int getPartition(RowMetaInterface rowMeta, Object[] row) throws KettleException {
		init(rowMeta);

		if (partitionColumnIndex < 0) {
			partitionColumnIndex = rowMeta.indexOfValue(fieldName);
			if (partitionColumnIndex < 0) {
				throw new KettleStepException(BaseMessages.getString(PKG, "HourPartitioner.Exception.PartitioningFieldNotFound", fieldName, rowMeta.toString()));
			}
		}
		
		ValueMetaInterface valueMeta = rowMeta.getValueMeta(partitionColumnIndex);
		Object valueData = row[partitionColumnIndex];

		if (!valueMeta.isString()) {
			throw new KettleException(BaseMessages.getString(PKG, "HourPartitioner.Exception.NotAFilename", valueMeta.getName()));
		}
		
		String filename = valueMeta.getString(valueData);
		String hourString = filename.substring(filename.length()-6, filename.length()-4);
		int value = Integer.parseInt(hourString);
		int targetLocation = (int) (value % nrPartitions);

		return targetLocation;
	}

	public String getDescription() {
		String description = "Filename hour partitioner";
		if (!Const.isEmpty(fieldName)) {
			description += "(" + fieldName + ")";
		}
		return description;
	}

	public String getXML() {
		StringBuilder xml = new StringBuilder(150);
		xml.append("           ").append(XMLHandler.addTagValue("field_name", fieldName));
		return xml.toString();
	}

	public void loadXML(Node partitioningMethodNode) throws KettleXMLException {
		fieldName = XMLHandler.getTagValue(partitioningMethodNode, "field_name");
	}

	public void saveRep(Repository rep, ObjectId id_transformation, ObjectId id_step) throws KettleException {
		rep.saveStepAttribute(id_transformation, id_step, "PARTITIONING_FIELDNAME", fieldName); 
	}

	public void loadRep(Repository rep, ObjectId id_step) throws KettleException {
		fieldName = rep.getStepAttributeString(id_step, "PARTITIONING_FIELDNAME");
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
}
