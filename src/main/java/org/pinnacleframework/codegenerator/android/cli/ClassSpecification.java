package org.pinnacleframework.codegenerator.android.cli;

import java.util.Collections;
import java.util.List;

public class ClassSpecification {
    private String name;
    private String packageName;
    private List<FieldSpecification> fieldSpecifications;

    public ClassSpecification(String className, String packageName, List<FieldSpecification> fieldSpecifications) {
        this.name = className;
        this.packageName=packageName;
        this.fieldSpecifications = fieldSpecifications;
    }

    public String getName() {
        return name;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public List<FieldSpecification> getFieldSpecifications() {
        return Collections.unmodifiableList(fieldSpecifications);
    }
}
