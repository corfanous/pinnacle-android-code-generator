package org.pinnacleframework.codegenerator.android.cli;

import org.yaml.snakeyaml.Yaml;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toMap;

public class ComplexYamlClassSpecReader {

    public ComplexYamlClassSpecReader(){}

    public List<ComplexClassSpecification> read(File yamlFile) throws IOException {
        return read(new FileReader(yamlFile));
    }

    private List<ComplexClassSpecification> read(FileReader reader) throws IOException{
        Yaml yaml=new Yaml();
        Map<String,Map<String,Object>> specMap=(Map<String, Map<String, Object>>) yaml.load(reader);
        //Map<String,Map<String,Object>> specMap=new LinkedHashMap<>();
        List<ComplexClassSpecification> specs=
                specMap.entrySet().stream()
                         .map(this::createSpec)
                            .collect(Collectors.toList());
        return specs;
    }

    private ComplexClassSpecification createSpec(Map.Entry<String,Map<String,Object>> e){
        Map<String,String> fieldParams=(Map<String, String>) e.getValue().get("fields");
        List<FieldSpecification> fields=
                fieldParams.entrySet().stream()
                  .map(o -> new FieldSpecification(o.getKey(), o.getValue().toString()))
                   .collect(Collectors.toList());
        List<String> imports=null;
        try{
            imports=
                    new ArrayList<>((Collection<? extends String>) e.getValue().get("imports"));
        }catch (Exception ex){
            //ex.printStackTrace();
        }
        return new ComplexClassSpecification(e.getKey(),fields, imports,
                                                 e.getValue().get("basePackageName").toString(),
                                                            e.getValue().get("packageName").toString());
    }
}