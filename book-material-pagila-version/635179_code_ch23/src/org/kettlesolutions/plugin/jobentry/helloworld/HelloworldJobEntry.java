package org.kettlesolutions.plugin.jobentry.helloworld;

import java.util.List;

import org.pentaho.di.cluster.SlaveServer;
import org.pentaho.di.core.Result;
import org.pentaho.di.core.annotations.JobEntry;
import org.pentaho.di.core.database.DatabaseMeta;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.exception.KettleXMLException;
import org.pentaho.di.core.xml.XMLHandler;
import org.pentaho.di.job.entry.JobEntryBase;
import org.pentaho.di.job.entry.JobEntryInterface;
import org.pentaho.di.repository.ObjectId;
import org.pentaho.di.repository.Repository;
import org.w3c.dom.Node;

@JobEntry(
		id="Helloworld",
		name="HelloworldJobEntry.name",
		description="HelloworldJobEntry.description",
		categoryDescription="HelloworldJobEntry.category",
		i18nPackageName="org.ketttlesolutions.plugin.jobentry.helloworld",
		image="org/kettlesolutions/plugin/step/helloworld/HelloWorld.png"
		)
public class HelloworldJobEntry extends JobEntryBase implements JobEntryInterface {

	public enum Tag {
		success,
	};
	private boolean success;
	
	/**
	 * @return the success
	 */
	public boolean isSuccess() {
		return success;
	}

	/**
	 * @param success the success to set
	 */
	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Result execute(Result prevResult, int nr) throws KettleException {
		prevResult.setResult(success);
		return prevResult;
	}

	public void loadXML(Node entrynode, List<DatabaseMeta> databases,
			List<SlaveServer> slaveServers, Repository rep)
			throws KettleXMLException {
		super.loadXML(entrynode, databases, slaveServers);
		success = "Y".equalsIgnoreCase(XMLHandler.getTagValue(entrynode, Tag.success.name()));
	}
	
	@Override
	public String getXML() {
		StringBuilder xml = new StringBuilder();
		xml.append(super.getXML());
		xml.append(XMLHandler.addTagValue(Tag.success.name(), success));
		return xml.toString();
	}
	
	@Override
	public void loadRep(Repository rep, ObjectId idJobentry,
			List<DatabaseMeta> databases, List<SlaveServer> slaveServers)
			throws KettleException {
		
		success = rep.getJobEntryAttributeBoolean(idJobentry, Tag.success.name());
	}
	
	@Override
	public void saveRep(Repository rep, ObjectId idJob) throws KettleException {
		rep.saveJobEntryAttribute(idJob, getObjectId(), Tag.success.name(), success);
	}

}
