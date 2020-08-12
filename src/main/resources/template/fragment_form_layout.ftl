<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")}
</#macro>
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/mpt_form"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context="${classSpecification.packageName}.${classSpecification.name}Activity"
    android:orientation="vertical">
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:id="@+id/mpt_form_layout_one">
        <#list classSpecification.fields as field>
        <#if field.name !="id">
        <#if field.type =="boolean">
        <RadioGroup
            android:layout_width="wrap_content"
            android:layout_height="wrap_content">
                <RadioButton
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:id="@+id/<@toUnderScore camelCase="${field.name}"/>"
                    android:text="${field.name}"
                    android:layout_margin="2dp"/>
                <RadioButton
                    android:layout_width="wrap_content"
                    android:layout_height="wrap_content"
                    android:id="@+id/not_<@toUnderScore camelCase="${field.name}"/>"
                    android:text="Not ${field.name}"
                    android:layout_margin="2dp"/>
        </RadioGroup>
        <#elseif field.type =="List">
        <Spinner
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:id="@+id/<@toUnderScore camelCase="${field.name}"/>" />
        <#elseif field.type =="long" || field.type=="int">
        <com.google.android.material.textfield.TextInputLayout
                    android:layout_width="match_parent"
                    android:layout_height="56dp"
                    android:layout_marginTop="20dp">
                    <com.google.android.material.textfield.TextInputEditText
                        android:id="@+id/<@toUnderScore camelCase="${field.name}"/>"
                        android:layout_width="match_parent"
                        android:layout_height="wrap_content"
                        android:inputType="number"
                        android:hint="${field.name}" />
                </com.google.android.material.textfield.TextInputLayout>
        <#else>
        <com.google.android.material.textfield.TextInputLayout
                    android:layout_width="match_parent"
                    android:layout_height="56dp"
                    android:layout_marginTop="20dp">
                    <com.google.android.material.textfield.TextInputEditText
                        android:id="@+id/<@toUnderScore camelCase="${field.name}"/>"
                        android:layout_width="match_parent"
                        android:layout_height="wrap_content"
                        android:hint="@string/label_result" />
                </com.google.android.material.textfield.TextInputLayout>
        </#if>
        </#if>
        </#list>
    </LinearLayout>
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_below="@+id/mt_form_layout_one"
        android:layout_marginTop="259dp"
        android:orientation="horizontal">
        <Button
            android:id="@+id/btn_cancel"
            android:layout_width="181dp"
            android:layout_height="60dp"
            android:text="@string/cancel" />
        <Button
            android:id="@+id/btn_save"
            android:layout_width="181dp"
            android:layout_height="59dp"
            android:text="@string/save" />
    </LinearLayout>
</LinearLayout>