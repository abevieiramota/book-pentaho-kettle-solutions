package org.kettlesolutions.plugin.database.mysql51db;

import org.pentaho.di.core.database.DatabaseInterface;
import org.pentaho.di.core.database.MySQLDatabaseMeta;
import org.pentaho.di.core.plugins.DatabaseMetaPlugin;

@DatabaseMetaPlugin(
	type="MYSQL51",
	typeDescription="MySQL 5.1"
  )
public class MySQL51DatabaseMeta extends MySQLDatabaseMeta implements DatabaseInterface {

	@Override
	public String getDriverClass() {
		return "com.mysql.jdbc.Driver";
	}

	@Override
	public String getXulOverlayFile() {
		return "mysql";
	}

        public boolean supportsTransactions() {
         return true;
       }
}
