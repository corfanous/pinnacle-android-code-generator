package org.pinnacleframework.codegenerator.android.cli;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

public class ComplexClassSpecification {

    private String name;
    private String tableName;
    private List<FieldSpecification> fields;
    private List<String> imports;
    private String basePackageName;
    private String packageName;

    public ComplexClassSpecification(){}
    public ComplexClassSpecification(String name, List<FieldSpecification> fields,
                                     List<String> imports, String basePackageName,String packageName){
        this.name=name;
        this.tableName= this.name
                .replaceAll("([a-z])([A-Z]+)", "$1_$2")
                .toLowerCase();
        this.fields=fields;
        if(imports instanceof ArrayList){
            this.imports=imports;
        }else{
            this.imports=new ArrayList<>();
        }
        this.basePackageName=basePackageName;
        this.packageName=packageName;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getTableName() {
        if(!(tableName instanceof String)){
            tableName=name.replaceAll("([a-z])([A-Z]+)","$1_$2")
                    .toLowerCase();
        }
        return tableName;
    }
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
    public List<FieldSpecification> getFields() {
        return Collections.unmodifiableList(fields);
    }
    public void setFields(List<FieldSpecification> fields) {
        this.fields = fields;
    }
    public List<String> getImports() {
        return Collections.unmodifiableList(imports);
    }
    public void setImports(List<String> imports) {
        this.imports = imports;
    }
    public String getBasePackageName() {
        return basePackageName;
    }
    public void setBasePackageName(String basePackageName) {
        this.basePackageName = basePackageName;
    }

    public String getPackageName() {
        return packageName;
    }
    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }
}
