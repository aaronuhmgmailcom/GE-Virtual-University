namespace GE.MyLearning.BL.Interface
{
    using ICSharpCode.SharpZipLib.Zip;
    using System;
    using System.IO;

    public class UnzipClass
    {
        public string UnZip(string[] args)
        {
            string strBack = string.Empty;
            ZipInputStream s = new ZipInputStream(File.OpenRead(args[0]));
            try
            {
                try
                {
                    ZipEntry theEntry;
                    while ((theEntry = s.GetNextEntry()) != null)
                    {
                        bool result;
                        string directoryName = Path.GetDirectoryName(args[1]);
                        string fileName = Path.GetFileName(theEntry.Name);
                        Directory.CreateDirectory(directoryName);
                        if (!(fileName != string.Empty))
                        {
                            goto Label_00C3;
                        }
                        FileStream streamWriter = File.Create(args[1] + @"\" + theEntry.Name);
                        int size = 0x800;
                        byte[] data = new byte[0x800];
                        goto Label_00B5;
                    Label_0082:
                        size = s.Read(data, 0, data.Length);
                        if (size > 0)
                        {
                            streamWriter.Write(data, 0, size);
                        }
                        else
                        {
                            goto Label_00BA;
                        }
                    Label_00B5:
                        result = true;
                        goto Label_0082;
                    Label_00BA:
                        streamWriter.Close();
                    Label_00C3:;
                    }
                }
                catch (Exception ue)
                {
                    strBack = ue.ToString();
                }
            }
            finally
            {
                s.Close();
            }
            return strBack;
        }
    }
}

