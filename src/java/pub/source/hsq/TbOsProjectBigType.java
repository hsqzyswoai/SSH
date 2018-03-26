package pub.source.hsq;

import pub.source.DataType;
import pub.source.Field;

public enum TbOsProjectBigType implements Field{
	/**枚举字段定义*/
	iProjectBigTypeId(DataType.INTEGER),
	
	sProjectBigTypeName(DataType.STRING),
	;

	
	/**构造*/
	private TbOsProjectBigType(DataType dataType){
		this.dataType = dataType;
	}
	
	/**属性：字段类型*/
	private DataType dataType;
	
	/**get方法, 不开放set方法*/
	public DataType getDataType(){
		return this.dataType;
	}
	
	/**可考虑加一个此方法，返回表名，这样就不用到处硬编码写表名了，A.A.getTableName()就能取到值*/
	public String getTableName(){
		return "tbOsProjectBigType";
	}

}
