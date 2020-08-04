package ${classSpecification.packageName};

import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverter;

<#list classSpecification.imports as import>
import ${import};
</#list>

@Entity(tableName="${classSpecification.tableName}")
public class ${classSpecification.name}{

    @PrimaryKey(autoGenerate = true)
    private long id;
<#list classSpecification.fields as field>
    @ColumnInfo
	private ${field.type} ${field.name};
</#list>

	public ${classSpecification.name}(){
	}

    public long getId() {
       return id;
    }
    public void setId(long id) {
       this.id = id;
    }
<#list classSpecification.fields as field>
	public ${field.type} get${field.name?cap_first}(){
		return ${field.name};
	}
	public void set${field.name?cap_first}(${field.type} ${field.name}){
		this.${field.name} = ${field.name};
	}
</#list>
}