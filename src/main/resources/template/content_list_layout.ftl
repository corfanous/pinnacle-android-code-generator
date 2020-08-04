<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")}
</#macro>
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:orientation="horizontal">
    <#list classSpecification.fields as field>
    <TextView
        android:id="@+id/<@toUnderScore camelCase="${field.name}"/>"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_margin="@dimen/card_text_margin"
        android:textAppearance="?attr/textAppearanceListItem" />
    </#list>
</LinearLayout>