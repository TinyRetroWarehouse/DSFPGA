namespace Software
{
    partial class Controller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // Controller
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(512, 384);
            this.ControlBox = false;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Controller";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
            this.Text = "Controller";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Controller_KeyDown);
            this.KeyUp += new System.Windows.Forms.KeyEventHandler(this.Controller_KeyUp);
            this.MouseDown += new System.Windows.Forms.MouseEventHandler(this.Controller_MouseDown);
            this.MouseEnter += new System.EventHandler(this.Controller_MouseEnter);
            this.MouseMove += new System.Windows.Forms.MouseEventHandler(this.Controller_MouseMove);
            this.MouseUp += new System.Windows.Forms.MouseEventHandler(this.Controller_MouseUp);
            this.ResumeLayout(false);

        }

        #endregion
    }
}