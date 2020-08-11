<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")}
</#macro>
package ${classSpecification.packageName};

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.Spinner;
import com.google.android.material.textfield.TextInputEditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProvider;

import ${classSpecification.basePackageName}.R;

public class ${classSpecification.name}FormFragment extends Fragment {

<#list classSpecification.fields as field>
<#if field.name != "id">
<#if field.type =="boolean">
    private RadioButton rb${field.name?cap_first};
    private RadioButton rbNot${field.name?cap_first};
<#elseif field.type =="List">
    //setup checkbox or spinner
    //private CheckBox cb${field.name?cap_first}1;
    //private CheckBox cb${field.name?cap_first}2;
    private Spinner sp${field.name?cap_first};
    private ArrayAdapter<String> adapter${field.name?cap_first};
<#else>
    private TextInputEditText txt${field.name?cap_first};
</#if>
</#if>
</#list>
    //
    private ${classSpecification.name} ${classSpecification.name?uncap_first};
    private ${classSpecification.name}ViewModel m${classSpecification.name}VM;
    //
    public ${classSpecification.name}FormFragment(){
        /*Bundle args=new Bundle();
        args.putLong("patientId", CaseProvider.currentPatientId);
        args.putLong("caseId",CaseProvider.currentCaseId);
        setArguments(args);*/
    }
    /*public static ${classSpecification.name}FormFragment newInstance(long patientId, long caseId){
        ${classSpecification.name}FormFragment fragment=new ${classSpecification.name}FormFragment();
        fragment.getArguments().putLong("patientId",patientId);
        fragment.getArguments().putLong("caseId",caseId);
        return fragment;
    }*/

    @NonNull
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view=inflater.inflate(R.layout.fragment_form_${classSpecification.tableName},
                container,false);
        <#list classSpecification.fields as field>
        <#if field.name != "id">
        <#if field.type =="boolean">
        rb${field.name?cap_first}=view.findViewById(R.id.<@toUnderScore camelCase="${field.name}"/>);
        rb${field.name?cap_first}.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked)
                    ${classSpecification.name?uncap_first}.set${field.name?cap_first}(${classSpecification.name}.PRESCRIBED);
            }
        });
        rbNot${field.name?cap_first}=view.findViewById(R.id.not_<@toUnderScore camelCase="${field.name}"/>);
        rbNot${field.name?cap_first}.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked)
                    ${classSpecification.name?uncap_first}.set${field.name?cap_first}(${classSpecification.name}.NOT_PRESCRIBED);
            }
        });
        <#elseif field.type="List">
        sp${field.name?cap_first}=view.findViewById(R.id.<@toUnderScore camelCase="${field.name}"/>);
        adapter${field.name?cap_first}=new ArrayAdapter<>(getContext(),android.R.layout.simple_list_item_1);
        adapter${field.name?cap_first}.addAll(Arrays.asList("One","Two","Three"));//TODO: IMPLEMENT THE LIST
        sp${field.name?cap_first}.setAdapter(adapter${field.name?cap_first});
        sp${field.name?cap_first}.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                ${classSpecification.name?uncap_first}.set${field.name?cap_first}(adapter${field.name?cap_first}.getItem(position));
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
        <#else>
        txt${field.name?cap_first}=(TextInputEditText) view.findViewById(R.id.<@toUnderScore camelCase="${field.name}"/>);
        </#if>
        </#if>
        </#list>
        //setup cancel button
        Button btnCancel=(Button) view.findViewById(R.id.btn_cancel);
        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });
        Button btnSave=(Button) view.findViewById(R.id.btn_save);
        btnSave.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //
                <#list classSpecification.fields as field>
                <#if field.name != "id">
                <#if field.type !="boolean" && field.type !="List">
                String ${field.name?lower_case}=txt${field.name?cap_first}.getText().toString();
                </#if>
                </#if>
                </#list>
                //save data
                <#list classSpecification.fields as field>
                <#if field.name != "id">
                <#if field.type !="boolean" && field.type !="List">
                <#if field.type =="int" || field.type=="long">
                ${classSpecification.name?uncap_first}.set${field.name?cap_first}(Integer.valueOf(${field.name?lower_case}));
                <#else>
                ${classSpecification.name?uncap_first}.set${field.name?cap_first}(${field.name?lower_case});
                </#if>
                </#if>
                </#if>
                </#list>
                m${classSpecification.name}VM.save(${classSpecification.name?uncap_first});
                //
                getActivity().finish();
            }
        });
        return view;
    }
    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        m${classSpecification.name}VM=new ViewModelProvider(this).get(${classSpecification.name}ViewModel.class);
    }
}