package com.tweet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

@SuppressWarnings("serial")
public class tweetinfo extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		try {		
		String id="";
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();		
		if (req.getParameterMap().containsKey("id")) {		
			id = req.getParameter("id");
			Key tweetKey = KeyFactory.createKey("Tweets", id);
			Entity tweet = ds.get(tweetKey);
			tweet.setProperty("visitedCount", Integer.parseInt(tweet.getProperty("visitedCount").toString())+1);
			ds.put(tweet);
			req.setAttribute("ID", id);
			req.setAttribute("message", tweet.getProperty("message").toString());
			req.setAttribute("createdAt", tweet.getProperty("createdAt").toString());
			req.setAttribute("author", tweet.getProperty("author").toString());
			req.setAttribute("visitedCount", tweet.getProperty("visitedCount").toString());
		}
		resp.setContentType("text/html");
        RequestDispatcher jsp = req.getRequestDispatcher("/WEB-INF/tweetinfo.jsp");
        jsp.forward(req, resp);        
		} 
		catch (EntityNotFoundException e) {			
			e.printStackTrace();
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		doGet(req,resp);
	}
}
