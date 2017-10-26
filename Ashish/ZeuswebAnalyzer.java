package com.cts.bfs.prism.zeus.analyzer;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.cts.bfs.prism.zeus.analyzer.config.AnalyzerConfig;
import com.cts.bfs.prism.zeus.analyzer.config.CallstackConfig;
import com.cts.bfs.prism.zeus.analyzer.model.EventStatistics;
import com.cts.bfs.prism.zeus.analyzer.model.EventStatisticsWeb;
import com.cts.bfs.prism.zeus.analyzer.model.ReportContext;
import com.cts.bfs.prism.zeus.analyzer.util.JSONUtil;

public class ZeuswebAnalyzer {
	
	String jsoninString;
	
	public String returnJSONString(){
		return jsoninString;	
	}
	
	
	public ZeuswebAnalyzer(final File file) throws Exception
	{
		  AnalyzerConfig cfg = new AnalyzerConfig(); ;
	        
	       ReportContext context = new ReportContext( file, cfg ) ;
	       context.getDataModel().parse();
	       
	       // For Event Stats Panel
	       List esw=getEventStatistics(context);
	       jsoninString = JSONUtil.toJson(esw);
	       
	       System.out.println(" Event Stats Data : "+ jsoninString); // var eswStr
	       
	       //For Memmory Statistics
	       List memStats=getMemmoryStatistics(context);
	       String memStatsStr = JSONUtil.toJson(memStats);
	       System.out.println(" Mem Stats Data : "+ memStatsStr);
	       
	       //For Call Graph
	       CallstackConfig userPref = getCallStackUserConfig(context);
	       String userPrefStr = JSONUtil.toJson(userPref);
	       System.out.println(" Call Stack User Pref : "+ userPrefStr);
	       
	       //For Call stacks
	       List allCallstacks= getCallStack(context);
	      // String callStackStr = JSONUtil.toJson(allCallstacks);
	       //System.out.println(" Call Stack : "+ callStackStr);
	       
	}
	
	public List getCallStack(ReportContext context)
	{
		List allCallstacks = context.getDataModel().getCallStacks();
		return allCallstacks;
		
	}
	
	/**
	 * Get User Pref
	 * @param context
	 * @return
	 */
	public CallstackConfig getCallStackUserConfig(ReportContext context)
	{
		CallstackConfig userPref = context.getAnalyzerConfig().getUiConfig().getCallstackConfig() ;
		return userPref;
	}
	
	/**
	 * Get List for Memmory Statistics
	 * @param context
	 * @return
	 */
	public List getMemmoryStatistics(ReportContext context)
	{
		final List      memoryStatisticsList = context.getDataModel().getMemoryStatistics();
		return memoryStatisticsList;
	}
	
	/**
	 * Get the EventStatistics Bean for Web which is simplified form of data
	 * @param context
	 * @return
	 */
	public List getEventStatistics(ReportContext context)
	{
		   final Map eventStatisticsMap = context.getDataModel().getEventStatisticsMap();
	       for (final Iterator iter = eventStatisticsMap.values().iterator(); iter.hasNext();)
	       {
	           ((EventStatistics) iter.next()).postInitialize();
	       }
	       
	       final List      methodStatistics = new ArrayList();
	       methodStatistics.addAll(eventStatisticsMap.values());
	       for (final Iterator iter = methodStatistics.iterator(); iter.hasNext();)
	        {
	            if (((EventStatistics) iter.next()).getTotalExecTime() == 0)
	            {
	                iter.remove();
	            }
	        }
	       
	       List eventStatsList = new ArrayList();
	       for(int i=0;i<methodStatistics.size();i++)
	       {
	    	   EventStatistics es = (EventStatistics) methodStatistics.get(i);
	    	   EventStatisticsWeb esw = new EventStatisticsWeb
	    			   (es.getShortClassName(), es.getMethodName(), es.getMaxTotalExecTime(), 
	    					   es.getMinTotalExecTime(), es.getAvgTotalExecTime(), es.getMaxSelfExecTime(),
	    					   es.getMinSelfExecTime(), es.getAvgSelfExecTime());
	    	   
	    	   eventStatsList.add(esw);
	       }
	       
	       return eventStatsList;
	}
	
	public static void main(String args[]) throws Exception
	{
		new ZeuswebAnalyzer(new File("D:/zeus_2017_09_24_17_14_44.log"));
	}
}
