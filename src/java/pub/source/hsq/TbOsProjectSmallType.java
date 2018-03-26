package pub.source.hsq;

import pub.source.DataType;
import pub.source.Field;

public enum TbOsProjectSmallType implements Field{
	/**ö���ֶζ���*/
	iProjectSmallTypeId(DataType.INTEGER),
	iProjectBigTypeId(DataType.INTEGER),
	sProjectSmallTypeName(DataType.STRING),
	;
	
	/**����*/
	private TbOsProjectSmallType(DataType dataType){
		this.dataType = dataType;
	}
	
	/**���ԣ��ֶ�����*/
	private DataType dataType;
	
	/**get����, ������set����*/
	public DataType getDataType(){
		return this.dataType;
	}
	
	/**�ɿ��Ǽ�һ���˷��������ر����������Ͳ��õ���Ӳ����д�����ˣ�A.A.getTableName()����ȡ��ֵ*/
	public String getTableName(){
		return "tbOsProjectSmallType";
	}

}
