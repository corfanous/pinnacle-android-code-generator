<#macro toUnderScore camelCase>
${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")}
</#macro>
package ${classSpecification.packageName};

import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import ${classSpecification.basePackageName}.R;
import ${classSpecification.basePackageName}.util.Config;

public class ${classSpecification.name}Activity extends AppCompatActivity {

    private FloatingActionButton fab;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_<@toUnderScore camelCase="${classSpecification.name}"/>);
        //setup fad
        fab=(FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(v->{
            fab.setVisibility(View.INVISIBLE);
            navigate(Config.VIEW_FORM);
        });
        int viewMode=getIntent().getIntExtra(Config.VIEW_MODE,0);
        navigate(viewMode);
    }

    protected void navigate(int viewMode){
        FragmentManager mgr=getSupportFragmentManager();
        if(viewMode== Config.VIEW_FORM){
            fab.setVisibility(View.INVISIBLE);
            mgr.beginTransaction()
                    .replace(R.id.container,new ${classSpecification.name}FormFragment())
                    .commit();
        }else{
            mgr.beginTransaction()
                    .replace(R.id.container,new ${classSpecification.name}ListFragment())
                    .commit();
        }
    }
}