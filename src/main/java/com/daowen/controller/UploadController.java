package com.daowen.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.StyledEditorKit;

import com.daowen.util.JsonResult;
import com.daowen.util.SequenceUtil;
import com.daowen.util.StringUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.util.SingleFileUpload;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class UploadController {

    @RequestMapping("/admin/uploadmanager.do")
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        SingleFileUpload upload = new SingleFileUpload();
        try {
            upload.parseRequest(request);
        } catch (UnsupportedEncodingException e1) {

            e1.printStackTrace();
        }
        String temp = request.getSession().getServletContext().getRealPath("/") + "upload\\temp\\"; //临时目录
        System.out.print("上传路径：" + temp);
        String loadpath = request.getSession().getServletContext().getRealPath("/") + "upload\\"; //上传文件存放目录
        File file = new File(temp);
        if (!file.exists())
            file.mkdirs();
        try {
            upload.upload(file);
            response.getWriter().write(upload.getFileItem().getName());
        } catch (org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException e) {
            // 文件大小超出最大值
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;

    }


    private String getUploadDirectory() {
        if (request == null)
            return "";
        String uploadDir = request.getServletContext().getRealPath("/") + "upload\\temp\\"; //临时目录
        File file = new File(uploadDir);
        if (!file.exists())
            file.mkdirs();
        return uploadDir;
    }

    @ResponseBody
    @PostMapping("/admin/upload")
    public JsonResult uploadFile() {
        FileItemFactory fileItemFactory = new DiskFileItemFactory();
        String uploadDir = getUploadDirectory();
        List<UploadExpress> listExpress = new ArrayList<>();
        ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
        try {
            List<FileItem> listFileItem = servletFileUpload.parseRequest(request);
            for (FileItem fileItem : listFileItem) {
                if (!fileItem.isFormField()) {
                    String timeStamp = SequenceUtil.buildSequence("F");
                    String fileName=fileItem.getName();

                    if(StringUtil.containChinese(fileName)) {
                        fileName = UUID.randomUUID().toString();
                    }
                    fileItem.write(new File(uploadDir + "\\" + fileName));
                    UploadExpress uploadExpress = new UploadExpress();
                    uploadExpress.setFileName(fileName);
                    uploadExpress.setRelativeUrl("/upload/temp/" + fileName);
                    uploadExpress.setUrl(this.getHostHead() + uploadExpress.getRelativeUrl());
                    listExpress.add(uploadExpress);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JsonResult.success(1, "上传成功", listExpress);
    }

    private class UploadExpress {
        private String url;
        private String fileName;
        private String relativeUrl;

        public String getRelativeUrl() {
            return relativeUrl;
        }

        public void setRelativeUrl(String relativeUrl) {
            this.relativeUrl = relativeUrl;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getFileName() {
            return fileName;
        }

        public void setFileName(String fileName) {
            this.fileName = fileName;
        }
    }



    public String getHostHead() {
        return this.request == null ? "" : this.request.getScheme() + "://" + this.request.getServerName() + ":" + this.request.getServerPort() + this.request.getContextPath();
    }

    @Autowired
    private HttpServletRequest request;


}
