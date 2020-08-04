package ${classSpecification.packageName};

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;

@Dao
public interface ${classSpecification.name}Dao {

    @Insert
    void insert(${classSpecification.name} ${classSpecification.name?uncap_first});

    @Update
    void update(${classSpecification.name} ${classSpecification.name?uncap_first});

    @Query("SELECT * FROM ${classSpecification.tableName} WHERE id=:id")
    LiveData<${classSpecification.name}> findById(long id);

    @Query("SELECT * FROM ${classSpecification.tableName} WHERE id=:id")
    ${classSpecification.name} findByIdBlocked(long id);

    @Query("SELECT * FROM ${classSpecification.tableName}")
    LiveData<List<${classSpecification.name}>> findAll();

    @Query("SELECT * FROM ${classSpecification.tableName}")
    List<${classSpecification.name}> findAllBlocked();

    @Query("DELETE FROM ${classSpecification.tableName} WHERE id=:id")
    void delete(long id);
}