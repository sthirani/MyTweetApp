package com.tweet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.google.appengine.api.datastore.FetchOptions;

@SuppressWarnings("serial")
public class toptweets extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		Filter propertyFilter = new Query.FilterPredicate("visitedCount", FilterOperator.GREATER_THAN_OR_EQUAL, 0);
		Query q = new Query("Tweets").setFilter(propertyFilter);
		q.addSort("visitedCount", SortDirection.DESCENDING);
		List<Entity> pq = ds.prepare(q).asList(FetchOptions.Builder.withPrefetchSize(10).chunkSize(10));
		String result = "";		
		for (int i = 0; i < 5; i++) {
			String row[] = pq.get(i).toString().split(System.lineSeparator());
			for (int k = 0; k < row.length; k++) {
				if (row[k].contains("message =")) {
					row[k]=row[k].substring(row[k].indexOf("=")+2, row[k].length());
					result=result + row[k]+"--" ;
				}

				if (row[k].contains("visitedCount =")) {
					row[k] = row[k].substring(row[k].indexOf("=") + 2, row[k].length());
					result = result + row[k] + "--";
				}
			}
			result = result + "---";
		}
		req.setAttribute("usertweets", result);
		resp.setContentType("text/html");
		RequestDispatcher jsp = req.getRequestDispatcher("/WEB-INF/toptweets.jsp");
		jsp.forward(req, resp);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		doGet(req, resp);
	}
}