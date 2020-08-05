package org.pinnacleframework.codegenerator.android.cli;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ComplexCodeGenerator {

    private Configuration cfg;

    public ComplexCodeGenerator() throws IOException {
        cfg = new Configuration(Configuration.VERSION_2_3_28);
        // Set the root of the class path ("") as the location to find templates
        cfg.setClassLoaderForTemplateLoading(getClass().getClassLoader(), "");

        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        cfg.setLogTemplateExceptions(false);
        cfg.setWrapUncheckedExceptions(true);
    }

    public void generate(List<ComplexClassSpecification> specs) throws IOException{
        for(ComplexClassSpecification spec: specs){
            //entity file
            generateRoomEntityFile(spec);
            //generateRoomEntityTestFile(spec);
            //Dao file
            generateDaoFile(spec);
            //generateDaoTestFile(spec);
            //entity repo file
            generateEntityRepoFile(spec);
            //generateEntityRepoTestFile(spec);
            //ViewModel file
            generateViewModelFile(spec);
            //generateViewModelTestFile(spec);
            //Activity file
            generateActivityJavaFile(spec);
            //generateActivityJavaTestFile(spec);
            generateActivityLayoutFile(spec);
            //List Fragment file
            generateListFragmentFile(spec);
            generateRecyclerAdapterFile(spec);
            //generateListFragmentTestFile(spec);
            generateListFragmentLayoutFile(spec);
            generateListFragmentContentFile(spec);
            //Form Fragment file
            generateFormFragmentFile(spec);
            //generateFormFragmentTestFile(spec);
            generateFormFragmentLayoutFile(spec);
            //menu
            generateMenuFile(spec);
        }
    }

    private void generateMenuFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/menu_layout.ftl");
        model.put("classSpecification", spec);
        //String folder = "src/main/res/layout";
        String folder = createFileFolder("src/main/res", "menu");
        File layoutSourceFile = new File(folder, "menu_list_"+spec.getTableName() + ".xml");
        //
        process(template, model, layoutSourceFile);
    }

    private void generateFormFragmentLayoutFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/fragment_form_layout.ftl");
        model.put("classSpecification", spec);
        //String folder = "src/main/res/layout";
        String folder = createFileFolder("src/main/res", "layout");
        File layoutSourceFile = new File(folder, "fragment_form_"+spec.getTableName() + ".xml");
        //
        process(template, model, layoutSourceFile);
    }

    private void generateListFragmentContentFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/content_list_layout.ftl");
        model.put("classSpecification", spec);
        //String folder = "src/main/res/layout";
        String folder = createFileFolder("src/main/res", "layout");
        File layoutSourceFile = new File(folder, "content_list_"+spec.getTableName() + ".xml");
        //
        process(template, model, layoutSourceFile);
    }
    private void generateListFragmentLayoutFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/fragment_list_layout.ftl");
        model.put("classSpecification", spec);
        //String folder = "src/main/res/layout";
        String folder = createFileFolder("src/main/res", "layout");
        File layoutSourceFile = new File(folder, "fragment_list_"+spec.getTableName() + ".xml");
        //
        process(template, model, layoutSourceFile);
    }

    private void generateActivityLayoutFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/activity_layout.ftl");
        model.put("classSpecification", spec);
        //String folder = "src/main/res/layout";
        String folder = createFileFolder("src/main/res", "layout");
        File layoutSourceFile = new File(folder, "activity_"+spec.getTableName() + ".xml");
        //
        process(template, model, layoutSourceFile);
    }

    private void generateFormFragmentFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/fragment_form.ftl");
        model.put("classSpecification", spec);
        String folder = createFileFolder("src/main/java", spec.getPackageName());
        File javaSourceFile = new File(folder, spec.getName() + "FormFragment.java");
        //
        process(template, model, javaSourceFile);
    }

    private void generateRecyclerAdapterFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/recycler_adapter.ftl");
        model.put("classSpecification", spec);
        String folder = createFileFolder("src/main/java", spec.getPackageName());
        File javaSourceFile = new File(folder, spec.getName() + "RecyclerViewAdapter.java");
        //
        process(template, model, javaSourceFile);
    }

    private void generateListFragmentFile(ComplexClassSpecification spec) throws IOException {
        Map<String, Object> model = new HashMap<>();
        Template template = cfg.getTemplate("template/fragment_list.ftl");
        model.put("classSpecification", spec);
        String folder = createFileFolder("src/main/java", spec.getPackageName());
        File javaSourceFile = new File(folder, spec.getName() + "ListFragment.java");
        //
        process(template, model, javaSourceFile);
    }

    private void generateActivityJavaFile(ComplexClassSpecification spec) throws IOException {
        Map<String,Object> model=new HashMap<>();
        Template template=cfg.getTemplate("template/activity.ftl");
        model.put("classSpecification", spec);
        String folder=createFileFolder("src/main/java",spec.getPackageName());
        File javaSourceFile=new File(folder,spec.getName()+"Activity.java");
        //
        process(template, model, javaSourceFile);
    }

    private void generateEntityRepoFile(ComplexClassSpecification spec) throws IOException {
        Map<String,Object> model=new HashMap<>();
        Template template=cfg.getTemplate("template/entity_repo.ftl");
        model.put("classSpecification", spec);
        String folder=createFileFolder("src/main/java",spec.getPackageName());
        File javaSourceFile=new File(folder,spec.getName()+"Repo.java");
        //
        process(template, model, javaSourceFile);
    }

    private void generateViewModelFile(ComplexClassSpecification spec) throws IOException {
        Map<String,Object> model=new HashMap<>();
        Template template=cfg.getTemplate("template/entity_vm.ftl");
        model.put("classSpecification", spec);
        String folder=createFileFolder("src/main/java",spec.getPackageName());
        File javaSourceFile=new File(folder,spec.getName()+"ViewModel.java");
        //
        process(template, model, javaSourceFile);
    }

    private void generateDaoFile(ComplexClassSpecification spec) throws IOException {
        Map<String,Object> model=new HashMap<>();
        Template template=cfg.getTemplate("template/entity_dao.ftl");
        model.put("classSpecification", spec);
        String folder=createFileFolder("src/main/java",spec.getPackageName());
        File javaSourceFile=new File(folder,spec.getName()+"Dao.java");
        //
        process(template, model, javaSourceFile);
    }

    public void generateRoomEntityFile(ComplexClassSpecification spec)throws IOException{
        //load template
        Map<String,Object> model=new HashMap<>();
        Template template=cfg.getTemplate("template/entity.ftl");
        model.put("classSpecification", spec);
        String folder=createFileFolder("src/main/java",spec.getPackageName());
        File javaSourceFile=new File(folder,spec.getName()+".java");
        //generate the file
        process(template, model, javaSourceFile);
    }
    private void process(Template template,Map<String,Object> model, File outputFile)throws IOException{
        Writer writer=new FileWriter(outputFile);
        try {
            template.process(model, writer);
            writer.flush();
            writer.close();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
    }
    private String createFileFolder(String basePath,String packageName){
        String filePath=packageNameToFolder(basePath,packageName);
        File folder=new File(filePath);
        if(!folder.exists())
            folder.mkdirs();
        return filePath;
    }
    private String packageNameToFolder(String rootPath,String packageName){
        String root=rootPath;
        StringBuilder sb=new StringBuilder(packageName);
        List<String> folders=new ArrayList<>();
        int start=0,end=0;
        for(int i=0;i<sb.length();i++){
            end++;
            if(sb.charAt(i)=='.'){
                folders.add(sb.substring(start,(end-1)));
                start=end;
            }
        }
        folders.add(sb.substring(start,end));
        for(String folder:folders){
            root +='/'+folder.toString();
        }
        return root;
    }
}
