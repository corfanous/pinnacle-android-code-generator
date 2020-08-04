package org.pinnacleframework.codegenerator.android.cli;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

public class JavaDataClassGenerator {

    private Configuration cfg;
    private String packageName;

    public JavaDataClassGenerator(String packageName) throws IOException {
        this.packageName=packageName;
        cfg = new Configuration(Configuration.VERSION_2_3_28);
        // Set the root of the class path ("") as the location to find templates
        cfg.setClassLoaderForTemplateLoading(getClass().getClassLoader(), "");

        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);
        cfg.setWrapUncheckedExceptions(true);
    }

    public void generateJavaSourceFiles(Collection<ClassSpecification> classSpecifications,
                                        File sourceFileDirectory) throws Exception {
        Map<String, Object> freemarkerDataModel = new HashMap<>();
        // Get the template to generate Java source files
        Template template = cfg.getTemplate("template/entity.ftl");
        //create the folders if they don't exist
        if(!sourceFileDirectory.exists()){
            sourceFileDirectory.mkdirs();
        }
        for (ClassSpecification classSpecification : classSpecifications) {
            // Put the classSpecification into the data model.
            // It can  be accessed in the template through ${classSpecification}
            classSpecification.setPackageName(this.packageName);
            freemarkerDataModel.put("classSpecification", classSpecification);
            File javaSourceFile = new File(sourceFileDirectory, classSpecification.getName() + ".java");
            Writer javaSourceFileWriter = new FileWriter(javaSourceFile);

            // Generate the Java source file
            template.process(freemarkerDataModel, javaSourceFileWriter);
        }
    }
}
