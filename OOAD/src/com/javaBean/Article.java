package com.javaBean;

import java.sql.Timestamp;

public class Article {
	
	public String subject, title, author, highlights, abstracts, oldtitle;
	public String comment, user;
	public Timestamp time;
	
	
	public Article() {
		super();
	}
	
	public Article(String subject, String title, String author, String highlights, String abstracts, String oldtitle,
			String comment, String user, Timestamp time) {
		super();
		this.subject = subject;
		this.title = title;
		this.author = author;
		this.highlights = highlights;
		this.abstracts = abstracts;
		this.oldtitle = oldtitle;
		this.comment = comment;
		this.user = user;
		this.time = time;
	}

	@Override
	public String toString() {
		return "Article [subject=" + subject + ", title=" + title + ", author=" + author + ", highlights=" + highlights
				+ ", abstracts=" + abstracts + ", oldtitle=" + oldtitle + ", comment=" + comment + ", user=" + user
				+ ", time=" + time + "]";
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getHighlights() {
		return highlights;
	}
	public void setHighlights(String highlights) {
		this.highlights = highlights;
	}
	public String getAbstracts() {
		return abstracts;
	}
	public void setAbstracts(String abstracts) {
		this.abstracts = abstracts;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getOldtitle() {
		return oldtitle;
	}
	public void setOldtitle(String oldtitle) {
		this.oldtitle = oldtitle;
	}
}
