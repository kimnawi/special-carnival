package com.eg.vo;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;



/*
 * 페이징 처리에 관련된 속성의 집합.
 */

@NoArgsConstructor
@Getter
@ToString
public class PagingVO<T> {
// 제네릭에 T를 넣으면 PagingVO를 만드는 순간 Type checking이 일어난다.
// (즉, 타입이 컴파일시에 정해지는 것이 아닌 런타임 상황에서 정해진다.)
	// ex) PagingVO<MemberVO>로 하면 dataList도 List<MemberVO>가 되는 것이다.
	
	public PagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}
	
	private int totalRecord; // DB의 레코드 건 수
	private int screenSize= 15; // 한 화면에 보여줄 레코드 수  
	private int blockSize = 5;  // 한 화면에 보여줄 페이지 수
	private int totalPage;
	private int currentPage;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	
	private ExtendSearchVO simpleSearch; // 단순 키워드 검색
	private T detailSearch; // 상세검색(T 안에 있는 프로퍼티를 검색 데이터로 하는 것이므로)
	private List<T> dataList; // T는 PagingVO가 만들어질때 결정된다.
	
	private String sortCondition;
	
	public void setSortCondition(String sortCondition) {
		this.sortCondition = sortCondition;
	}
	
	public void setSimpleSearch(ExtendSearchVO simpleSearch) {
		this.simpleSearch = simpleSearch;
	}
	
	public void setDetailSearch(T detailSearch) {
		this.detailSearch = detailSearch;
	}
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (int)(Math.ceil(totalRecord/(double)screenSize));
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize - 1);
		startPage = blockSize * ((currentPage -1) / blockSize) + 1;
		endPage = startPage + (blockSize - 1);
		
	}
	private static final String LINKPTRN = "<a class='pageLink' href='#' data-page='%d'>%s</a> \n";
	public String getPagingHTML() {
		// <a href="?page="></a>
		StringBuffer html = new StringBuffer();
		// 이전 버튼
		if(startPage > 1) {
			html.append(String.format(LINKPTRN, startPage-1,"<&ensp;&ensp;"));
		}
		endPage = endPage > totalPage ? endPage = totalPage : endPage;
		for(int page = startPage ; page <= endPage; page++) {
			if(page == currentPage) {
				html.append("["+page+"]");
			}else {
				html.append(String.format(LINKPTRN, page, page));
			}
		}
		// 다음 버튼
		if(endPage < totalPage ) {
			html.append(String.format(LINKPTRN, endPage+1, "&ensp;&ensp;>"));
		}
		return html.toString();
	}
	
	private Integer emplNo;	//사원번호
	
	public void setEmplNo(Integer emplNo) {
		this.emplNo = emplNo;
	}
}
