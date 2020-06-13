namespace Software
{
    partial class MonitorWindow
    {
        /// <summary>
        /// Erforderliche Designervariable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Verwendete Ressourcen bereinigen.
        /// </summary>
        /// <param name="disposing">True, wenn verwaltete Ressourcen gelöscht werden sollen; andernfalls False.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Vom Windows Form-Designer generierter Code

        /// <summary>
        /// Erforderliche Methode für die Designerunterstützung.
        /// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.button_loadblock = new System.Windows.Forms.Button();
            this.treeView_regs = new System.Windows.Forms.TreeView();
            this.dataGridView_paradetail = new System.Windows.Forms.DataGridView();
            this.Property = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Value = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.webBrowser_doc = new System.Windows.Forms.WebBrowser();
            this.richTextBox_arrayview = new System.Windows.Forms.RichTextBox();
            this.textBox_newvalue = new System.Windows.Forms.TextBox();
            this.button_writevalue = new System.Windows.Forms.Button();
            this.label_regindex = new System.Windows.Forms.Label();
            this.textBox_regindex = new System.Windows.Forms.TextBox();
            this.checkBox_autoupdate = new System.Windows.Forms.CheckBox();
            this.timer_autoupdate = new System.Windows.Forms.Timer(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_paradetail)).BeginInit();
            this.SuspendLayout();
            // 
            // button_loadblock
            // 
            this.button_loadblock.Location = new System.Drawing.Point(541, 12);
            this.button_loadblock.Name = "button_loadblock";
            this.button_loadblock.Size = new System.Drawing.Size(75, 23);
            this.button_loadblock.TabIndex = 0;
            this.button_loadblock.Text = "Load Block";
            this.button_loadblock.UseVisualStyleBackColor = true;
            this.button_loadblock.Click += new System.EventHandler(this.button_loadblock_Click);
            // 
            // treeView_regs
            // 
            this.treeView_regs.Location = new System.Drawing.Point(12, 12);
            this.treeView_regs.Name = "treeView_regs";
            this.treeView_regs.Size = new System.Drawing.Size(273, 552);
            this.treeView_regs.TabIndex = 1;
            this.treeView_regs.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.treeView_regs_AfterSelect);
            // 
            // dataGridView_paradetail
            // 
            this.dataGridView_paradetail.AllowUserToAddRows = false;
            this.dataGridView_paradetail.AllowUserToDeleteRows = false;
            this.dataGridView_paradetail.AllowUserToResizeColumns = false;
            this.dataGridView_paradetail.AllowUserToResizeRows = false;
            this.dataGridView_paradetail.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView_paradetail.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Property,
            this.Value});
            this.dataGridView_paradetail.Location = new System.Drawing.Point(291, 12);
            this.dataGridView_paradetail.MultiSelect = false;
            this.dataGridView_paradetail.Name = "dataGridView_paradetail";
            this.dataGridView_paradetail.ReadOnly = true;
            this.dataGridView_paradetail.RowHeadersVisible = false;
            this.dataGridView_paradetail.RowHeadersWidth = 40;
            this.dataGridView_paradetail.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.CellSelect;
            this.dataGridView_paradetail.Size = new System.Drawing.Size(244, 232);
            this.dataGridView_paradetail.TabIndex = 2;
            // 
            // Property
            // 
            this.Property.Frozen = true;
            this.Property.HeaderText = "Property";
            this.Property.Name = "Property";
            this.Property.ReadOnly = true;
            this.Property.Width = 70;
            // 
            // Value
            // 
            this.Value.Frozen = true;
            this.Value.HeaderText = "Value";
            this.Value.Name = "Value";
            this.Value.ReadOnly = true;
            this.Value.Width = 170;
            // 
            // webBrowser_doc
            // 
            this.webBrowser_doc.Location = new System.Drawing.Point(291, 305);
            this.webBrowser_doc.MinimumSize = new System.Drawing.Size(20, 20);
            this.webBrowser_doc.Name = "webBrowser_doc";
            this.webBrowser_doc.Size = new System.Drawing.Size(713, 259);
            this.webBrowser_doc.TabIndex = 3;
            // 
            // richTextBox_arrayview
            // 
            this.richTextBox_arrayview.Font = new System.Drawing.Font("Lucida Console", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.richTextBox_arrayview.Location = new System.Drawing.Point(541, 41);
            this.richTextBox_arrayview.Name = "richTextBox_arrayview";
            this.richTextBox_arrayview.ReadOnly = true;
            this.richTextBox_arrayview.Size = new System.Drawing.Size(463, 230);
            this.richTextBox_arrayview.TabIndex = 4;
            this.richTextBox_arrayview.Text = "";
            // 
            // textBox_newvalue
            // 
            this.textBox_newvalue.Location = new System.Drawing.Point(291, 279);
            this.textBox_newvalue.Name = "textBox_newvalue";
            this.textBox_newvalue.Size = new System.Drawing.Size(153, 20);
            this.textBox_newvalue.TabIndex = 5;
            // 
            // button_writevalue
            // 
            this.button_writevalue.Location = new System.Drawing.Point(450, 277);
            this.button_writevalue.Name = "button_writevalue";
            this.button_writevalue.Size = new System.Drawing.Size(85, 23);
            this.button_writevalue.TabIndex = 6;
            this.button_writevalue.Text = "Set content";
            this.button_writevalue.UseVisualStyleBackColor = true;
            this.button_writevalue.Click += new System.EventHandler(this.button_writevalue_Click);
            // 
            // label_regindex
            // 
            this.label_regindex.AutoSize = true;
            this.label_regindex.Location = new System.Drawing.Point(292, 251);
            this.label_regindex.Name = "label_regindex";
            this.label_regindex.Size = new System.Drawing.Size(75, 13);
            this.label_regindex.TabIndex = 7;
            this.label_regindex.Text = "Register Index";
            // 
            // textBox_regindex
            // 
            this.textBox_regindex.Location = new System.Drawing.Point(373, 248);
            this.textBox_regindex.Name = "textBox_regindex";
            this.textBox_regindex.Size = new System.Drawing.Size(161, 20);
            this.textBox_regindex.TabIndex = 8;
            this.textBox_regindex.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.textBox_regindex_KeyPress);
            this.textBox_regindex.Leave += new System.EventHandler(this.textBox_regindex_Leave);
            // 
            // checkBox_autoupdate
            // 
            this.checkBox_autoupdate.AutoSize = true;
            this.checkBox_autoupdate.Location = new System.Drawing.Point(653, 279);
            this.checkBox_autoupdate.Name = "checkBox_autoupdate";
            this.checkBox_autoupdate.Size = new System.Drawing.Size(84, 17);
            this.checkBox_autoupdate.TabIndex = 9;
            this.checkBox_autoupdate.Text = "Auto update";
            this.checkBox_autoupdate.UseVisualStyleBackColor = true;
            // 
            // timer_autoupdate
            // 
            this.timer_autoupdate.Enabled = true;
            this.timer_autoupdate.Tick += new System.EventHandler(this.timer_autoupdate_Tick);
            // 
            // MonitorWindow
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1016, 576);
            this.Controls.Add(this.checkBox_autoupdate);
            this.Controls.Add(this.textBox_regindex);
            this.Controls.Add(this.label_regindex);
            this.Controls.Add(this.button_writevalue);
            this.Controls.Add(this.textBox_newvalue);
            this.Controls.Add(this.richTextBox_arrayview);
            this.Controls.Add(this.webBrowser_doc);
            this.Controls.Add(this.dataGridView_paradetail);
            this.Controls.Add(this.treeView_regs);
            this.Controls.Add(this.button_loadblock);
            this.Name = "MonitorWindow";
            this.Text = "MonitorWindow";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView_paradetail)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button_loadblock;
        private System.Windows.Forms.TreeView treeView_regs;
        private System.Windows.Forms.DataGridView dataGridView_paradetail;
        private System.Windows.Forms.WebBrowser webBrowser_doc;
        private System.Windows.Forms.RichTextBox richTextBox_arrayview;
        private System.Windows.Forms.TextBox textBox_newvalue;
        private System.Windows.Forms.Button button_writevalue;
        private System.Windows.Forms.DataGridViewTextBoxColumn Property;
        private System.Windows.Forms.DataGridViewTextBoxColumn Value;
        private System.Windows.Forms.Label label_regindex;
        private System.Windows.Forms.TextBox textBox_regindex;
        private System.Windows.Forms.CheckBox checkBox_autoupdate;
        private System.Windows.Forms.Timer timer_autoupdate;
    }
}

