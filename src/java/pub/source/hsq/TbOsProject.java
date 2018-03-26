package pub.source.hsq;
import pub.source.DataType;
import pub.source.Field;

public enum TbOsProject implements Field{
	/**ö���ֶζ���*/
	iProjectId(DataType.LONG),
	iProjectBigTypeId(DataType.INTEGER),
	iProjectSmallTypeId(DataType.INTEGER),
	sProjectName(DataType.STRING),
	dEndDate(DataType.TIME_STAMP),
	dCreateDate(DataType.TIME_STAMP),
	iPeopleCount(DataType.INTEGER),
	sPmName(DataType.STRING),
	sRemark(DataType.STRING);
	
	/**����*/
	private TbOsProject(DataType dataType){
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
		return "TbOsProject";
	}

}
