package org.kettlesolutions.plugin.jobentry.helloworld;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.ModifyEvent;
import org.eclipse.swt.events.ModifyListener;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.ShellAdapter;
import org.eclipse.swt.events.ShellEvent;
import org.eclipse.swt.layout.FormAttachment;
import org.eclipse.swt.layout.FormData;
import org.eclipse.swt.layout.FormLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;
import org.pentaho.di.core.Const;
import org.pentaho.di.i18n.BaseMessages;
import org.pentaho.di.job.JobMeta;
import org.pentaho.di.job.entry.JobEntryDialogInterface;
import org.pentaho.di.job.entry.JobEntryInterface;
import org.pentaho.di.repository.Repository;
import org.pentaho.di.ui.core.gui.WindowProperty;
import org.pentaho.di.ui.job.dialog.JobDialog;
import org.pentaho.di.ui.job.entry.JobEntryDialog;
import org.pentaho.di.ui.trans.step.BaseStepDialog;

public class HelloworldJobEntryDialog extends JobEntryDialog implements JobEntryDialogInterface {

	private static Class<?> PKG = HelloworldJobEntry.class; // for i18n purposes, needed by Translator2!!   $NON-NLS-1$

	private HelloworldJobEntry jobEntry;
	
	private Text  wName;
	private Button wSuccess;
	
    private Button wOK, wCancel;

    private Shell shell;
    private SelectionAdapter lsDef;

    private boolean changed;

	public HelloworldJobEntryDialog(Shell parent, JobEntryInterface jobEntry, Repository rep, JobMeta jobMeta) {
		super(parent, jobEntry, rep, jobMeta);
		this.jobEntry = (HelloworldJobEntry) jobEntry;
        if (this.jobEntry.getName() == null)
            this.jobEntry.setName(BaseMessages.getString(PKG, "HelloworldJobEntry.name"));
	}

	public JobEntryInterface open() {

        Shell parent = getParent();
        Display display = parent.getDisplay();

        shell = new Shell(parent, props.getJobsDialogStyle());
        props.setLook(shell);
        JobDialog.setShellImage(shell, jobEntry);

        ModifyListener lsMod = new ModifyListener()
        {
            public void modifyText(ModifyEvent e)
            {
                jobEntry.setChanged();
            }
        };
        changed = jobEntry.hasChanged();

        FormLayout formLayout = new FormLayout();
        formLayout.marginWidth = Const.FORM_MARGIN;
        formLayout.marginHeight = Const.FORM_MARGIN;

        shell.setLayout(formLayout);
        shell.setText(BaseMessages.getString(PKG, "HelloworldJobEntryDialog.Title"));

        int middle = props.getMiddlePct();
        int margin = Const.MARGIN;

        
        // Job entry name
        //
        Label wlName = new Label(shell, SWT.RIGHT);
        wlName.setText(BaseMessages.getString(PKG, "HelloworldJobEntryDialog.Name.Label"));
        props.setLook(wlName);
        FormData fdlName = new FormData();
        fdlName.left = new FormAttachment(0, 0);
		fdlName.right = new FormAttachment(middle, -margin);
        fdlName.top = new FormAttachment(0, margin);
        wlName.setLayoutData(fdlName);
        wName = new Text(shell, SWT.SINGLE | SWT.LEFT | SWT.BORDER);
        props.setLook(wName);
        wName.addModifyListener(lsMod);
        FormData fdName = new FormData();
        fdName.left = new FormAttachment(middle, 0);
        fdName.top = new FormAttachment(0, margin);
        fdName.right = new FormAttachment(100, 0);
        wName.setLayoutData(fdName);
        Control lastControl = wName;

        // The success button!
        //
        Label wlSuccess = new Label(shell, SWT.RIGHT);
        wlSuccess.setText(BaseMessages.getString(PKG, "HelloworldJobEntryDialog.Success.Label"));
        props.setLook(wlSuccess);
        FormData fdlSuccess = new FormData();
        fdlSuccess.left = new FormAttachment(0, 0);
		fdlSuccess.right = new FormAttachment(middle, -margin);
        fdlSuccess.top = new FormAttachment(lastControl, margin);
        wlSuccess.setLayoutData(fdlSuccess);
        wSuccess = new Button(shell, SWT.CHECK);
        props.setLook(wSuccess);
        FormData fdSuccess = new FormData();
        fdSuccess.left = new FormAttachment(middle, 0);
        fdSuccess.top = new FormAttachment(lastControl, margin);
        fdSuccess.right = new FormAttachment(100, 0);
        wSuccess.setLayoutData(fdSuccess);
        lastControl = wSuccess;

		wOK = new Button(shell, SWT.PUSH);
        wOK.setText(BaseMessages.getString(PKG, "System.Button.OK"));
        wOK.addSelectionListener(new SelectionAdapter() { public void widgetSelected(SelectionEvent e) { ok(); }});
        wCancel = new Button(shell, SWT.PUSH);
        wCancel.setText(BaseMessages.getString(PKG, "System.Button.Cancel"));
        wCancel.addSelectionListener(new SelectionAdapter() { public void widgetSelected(SelectionEvent e) { cancel(); }});

        // at the bottom
        BaseStepDialog.positionBottomButtons(shell, new Button[] { wOK, wCancel }, margin, lastControl);

        lsDef = new SelectionAdapter() {
            public void widgetDefaultSelected(SelectionEvent e)
            {
                ok();
            }
        };

        wName.addSelectionListener(lsDef);

        // Detect X or ALT-F4 or something that kills this window...
        shell.addShellListener(new ShellAdapter()
        {
            public void shellClosed(ShellEvent e)
            {
                cancel();
            }
        });


        getData();

        BaseStepDialog.setSize(shell);
        
        shell.open();
        props.setDialogSize(shell, "JobAbortDialogSize");
        while (!shell.isDisposed())
        {
            if (!display.readAndDispatch())
                display.sleep();
        }

		return jobEntry;
	}
	
	private void dispose() {
        WindowProperty winprop = new WindowProperty(shell);
        props.setScreen(winprop);

		shell.dispose();
	}
	
	public void getData()
	{
		wName.setText(jobEntry.getName());
		wSuccess.setSelection(jobEntry.isSuccess());
	}
	
	private void cancel()
	{
	    jobEntry.setChanged(changed);
		jobEntry=null;

		dispose();
	}
	
	private void ok()
	{
		jobEntry.setName(wName.getText());
		jobEntry.setSuccess(wSuccess.getSelection());
		dispose();
	}
}
