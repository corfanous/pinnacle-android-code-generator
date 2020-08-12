package ${classSpecification.packageName};

import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.PrimaryKey;
import androidx.room.TypeConverter;

<#list classSpecification.imports as import>
import ${import};
</#list>

@Entity(tableName="${classSpecification.tableName}")
public class ${classSpecification.name}{

<#list classSpecification.fields as field>
<#if field.type =="boolean">
    @Ignore
    public static final int ${field.name?upper_case}=1;
    @Ignore
    public static final int NOT_${field.name?upper_case}=0;
</#if>
</#list>

    @PrimaryKey(autoGenerate = true)
    private long id;
<#list classSpecification.fields as field>
<#if field.name !="id">
<#if field.type =="boolean">
    @ColumnInfo
    private int ${field.name};
<#elseif field.type =="List">
    @ColumnInfo
    private String ${field.name};
<#else>
    @ColumnInfo
	private ${field.type} ${field.name};
</#if>
</#if>
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
<#if field.name !="id">
<#if field.type =="boolean">
	public int get${field.name?cap_first}(){
		return ${field.name};
	}
	public void set${field.name?cap_first}(int ${field.name}){
		this.${field.name} = ${field.name};
	}
	public boolean is${field.name?cap_first}(){
	    return ${field.name} == ${field.name?upper_case};
	}
<#elseif field.type =="List">
	public String get${field.name?cap_first}(){
		return ${field.name};
	}
	public void set${field.name?cap_first}(String ${field.name}){
		this.${field.name} = ${field.name};
	}
<#else>
	public ${field.type} get${field.name?cap_first}(){
		return ${field.name};
	}
	public void set${field.name?cap_first}(${field.type} ${field.name}){
		this.${field.name} = ${field.name};
	}
</#if>
</#if>
</#list>
}