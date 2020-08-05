<#macro toUnderScore camelCase>
<#-- ${camelCase?replace("[A-Z]", "_$0", 'r')?lower_case?replace("^_","","r")} -->
${camelCase?replace("([a-z])([A-Z]+)", "$1_$2", 'r')?lower_case}
</#macro>
package ${classSpecification.packageName};

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import ${classSpecification.basePackageName}.R;
import ${classSpecification.basePackageName}.util.OnNewButtonClickListener;

import java.util.ArrayList;
import java.util.List;

public class ${classSpecification.name}RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder>{

        private List<${classSpecification.name}> list;
        private final LayoutInflater mInflater;
        private OnNewButtonClickListener newButtonClickListener;

        public ${classSpecification.name}RecyclerViewAdapter(@NonNull Context context){
            mInflater=LayoutInflater.from(context);
            list=new ArrayList<>();
        }
        @NonNull
        @Override
        public ItemViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view=mInflater
                    .inflate(R.layout.content_list_${classSpecification.tableName}, parent,false);
            ItemViewHolder holder=new ItemViewHolder(view);
            return holder;
        }

        @Override
        public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
            if(holder instanceof  ItemViewHolder){
                ItemViewHolder item=(ItemViewHolder) holder;
                <#list classSpecification.fields as field>
                <#if field.name != "id">
                item.txt${field.name?cap_first}.setText(list.get(position).get${field.name?cap_first}());
                </#if>
                </#list>
                //item.txtDate.setText(list.get(position).getRequestedDate().format(DateTimeFormatter.ofPattern(Config.DEFAULT_DATE_FORMAT)));
            }
        }
        @Override
        public int getItemCount() {
            if(list!=null) return list.size();
            return 0;
        }
        public void set${classSpecification.name}s(List<${classSpecification.name}> ${classSpecification.name?uncap_first}s){
            if(list instanceof List)
                list.clear();
            list=${classSpecification.name?uncap_first}s;
            notifyDataSetChanged();
        }
        public void setNewButtonClickListener(OnNewButtonClickListener newButtonClickListener){
            this.newButtonClickListener=newButtonClickListener;
        }

        public class ItemViewHolder extends RecyclerView.ViewHolder{

            private final View mView;
            <#list classSpecification.fields as field>
            <#if field.name != "id">
            private final TextView txt${field.name?cap_first};
            </#if>
            </#list>
            public ItemViewHolder(@NonNull View itemView) {
                super(itemView);
                mView=itemView;
                <#list classSpecification.fields as field>
                <#if field.name != "id">
                txt${field.name?cap_first}=mView.findViewById(R.id.<@toUnderScore camelCase="${field.name}"/>);
                </#if>
                </#list>
            }
        }
}