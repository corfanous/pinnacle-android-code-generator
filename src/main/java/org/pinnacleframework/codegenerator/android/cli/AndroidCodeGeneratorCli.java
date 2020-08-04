package org.pinnacleframework.codegenerator.android.cli;

import org.beryx.textio.TextIO;
import org.beryx.textio.TextIoFactory;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AndroidCodeGeneratorCli {

    private TextIO input= TextIoFactory.getTextIO();

    public static void main(String[] args){
        AndroidCodeGeneratorCli cli=new AndroidCodeGeneratorCli();
        cli.cliQuestions();
    }

    public void cliQuestions(){
        boolean running=true;
        while (running){
            //Ask the type of code to generate
            boolean isFromFile=input.newBooleanInputReader()
                    .withTrueInput("Y")
                    .withFalseInput("N")
                    .withDefaultValue(true)
                    .read("Generate from file?");
            if(!isFromFile){
                cliQuestionsFromCLIOnly();
            }else{
                //complex or simple class
                boolean isComplex=input.newBooleanInputReader()
                        .withTrueInput("Y")
                        .withFalseInput("N")
                        .withDefaultValue(true)
                        .read("Is it complex code generating?");
                if(!isComplex){
                    cliQuestionsForSimpleJavaClassGeneration();
                }else{
                    try{
                        cliQuestionsForComplexJavaClassGeneration();
                    }catch (IOException e){
                        System.out.println(new StringBuilder("Error file system error occurred, make sure your file is correctly specified!").toString());
                        e.printStackTrace();

                    }

                }
            }
            running=input.newBooleanInputReader()
                    .withTrueInput("Y")
                    .withFalseInput("N")
                    .withDefaultValue(true)
                    .read("Do you want to continue generating code?");
        }
    }
    public void cliQuestionsFromCLIOnly(){
        System.out.print("CLI instructions only not implemented yet.\n");
    }
    public void cliQuestionsForSimpleJavaClassGeneration(){
        //specify the file
        String modelFile=input.newStringInputReader()
                .read("Type the full path name of the file(E.g. User.yml)");
        //specify the package name
        String packageName=input.newStringInputReader()
                .read("Type the package name ");
        String sourceFolder=packageNameToFolder(packageName);
        //
        if((modelFile instanceof String) & (modelFile.trim().equals(""))){
            File yamlFile=new File(modelFile);
            try {
                JavaDataClassGenerator generator=new JavaDataClassGenerator(packageName);
                generator.generateJavaSourceFiles(
                        new YamlClassSpecificationReader()
                                .read(yamlFile),new File(sourceFolder));
            }catch (IOException e){
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
            /*catch (Exception e) {
                e.printStackTrace();
            }*/
        }else{
            System.out.print("Enter the correct file name.\n");
        }
    }
    public void cliQuestionsForComplexJavaClassGeneration() throws IOException {
        String modelFile=input.newStringInputReader()
                .read("Type the full path name of the file(E.g. User.yml)");
        ComplexCodeGenerator generator=new ComplexCodeGenerator();
        generator.generate(
                new ComplexYamlClassSpecReader()
                    .read(new File(modelFile)));
    }
    public String packageNameToFolder(String packageName){
        String root="src/main/java";
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
            //root +='/'+folder.toString();
            root +='/'+folder;
        }
        return root;
    }
}