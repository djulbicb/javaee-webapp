package Config;

import javax.swing.filechooser.FileSystemView;

public class Configuration {

    public static void main(String[] args) {
        System.out.println(getImagePath());
    }
    
    public static String getImagePath() {
        String path = FileSystemView.getFileSystemView().getDefaultDirectory().getPath();
        String workingDir = path + "\\NetBeansProjects\\assigment_webshop_bo\\build\\web\\images\\";
        return workingDir;
    }
}

/*mysqldump -uroot --all-databases bojan > bojan.sql;*/
