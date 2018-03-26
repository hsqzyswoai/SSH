package pub.source.hsq;

import pub.source.DataType;
import pub.source.Field;

public enum TbOsProjectBigType implements Field{
	/**ö���ֶζ���*/
	iProjectBigTypeId(DataType.INTEGER),
	
	sProjectBigTypeName(DataType.STRING),
	;

	
	/**����*/
	private TbOsProjectBigType(DataType dataType){
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
		return "tbOsProjectBigType";
	}

}
