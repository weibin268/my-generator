package com.zhuang.generator.util;

import java.io.*;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

/**
 * Created by zhuang on 12/31/2017.
 */
public class FileUtils {

    public static List<String> readLines(String filePath) {
        return readLines(filePath, "UTF-8");
    }

    public static List<String> readLines(String filePath, String charsetName) {
        List<String> result = new ArrayList<String>();
        BufferedReader bufferedReader = null;
        try {
            bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), charsetName));
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                result.add(line);
            }
        } catch (Exception e) {
            throw new RuntimeException("FileUtils.readLines error!", e);
        } finally {
            try {
                bufferedReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static String readText(String filePath) {
        return readText(filePath, "UTF-8");
    }

    public static String readText(String filePath, String charsetName) {
        String result;
        FileInputStream fileInputStream = null;
        try {
            File file = new File(filePath);
            fileInputStream = new FileInputStream(file);
            byte[] bytes = new byte[(int) file.length()];
            fileInputStream.read(bytes);
            result = new String(bytes, charsetName);
        } catch (Exception e) {
            throw new RuntimeException("FileUtils.readText error!", e);
        } finally {
            try {
                fileInputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public static void writeText(String filePath, String text) {
        writeText(filePath, text, "UTF-8");
    }

    public static void writeText(String filePath, String text, String charsetName) {
        FileOutputStream fileOutputStream = null;
        try {
            File file = new File(filePath);
            File parentFile = file.getParentFile();
            if (!parentFile.isDirectory()) {
                parentFile.mkdirs();
            }
            fileOutputStream = new FileOutputStream(file);
            byte[] bytes = text.getBytes(charsetName);
            fileOutputStream.write(bytes);
            fileOutputStream.flush();
        } catch (Exception e) {
            throw new RuntimeException("FileUtils.writeText error!", e);
        } finally {
            try {
                fileOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static String getLineSeparator() {
        return System.getProperty("line.separator");
    }

    public static List<File> enumerateDir(File dir) {
        List<File> fileList = new ArrayList();
        if (dir == null) {
        } else if (dir.isDirectory()) {
            File[] subFiles = dir.listFiles();
            for (File subFile : subFiles) {
                fileList.add(subFile);
                if (subFile.isDirectory()) {
                    fileList.addAll(enumerateDir(subFile));
                }
            }
        } else {
            fileList.add(dir);
        }
        return fileList;
    }

    public static String[] getResources(Class clazz, String name) throws IOException {
        Set<String> resources = new HashSet();
        String classResourceName = clazz.getName().replace(".", "/") + ".class";
        URL classResourceURL = clazz.getClassLoader().getResource(classResourceName);
        String classResourcePath = classResourceURL.getPath();
        if (classResourceURL.getProtocol().equals("file")) {
            // 开发环境里class和resource同位于target/classes目录下
            String classesDirPath = classResourcePath.substring(classResourcePath.indexOf("/") + 1, classResourcePath.indexOf(classResourceName));
            File classesDir = new File(classesDirPath);
            List<File> files = enumerateDir(classesDir);
            for (File file : files) {
                String resourceName = file.getAbsolutePath();
                resourceName = resourceName.substring(classesDirPath.length());
                resourceName = resourceName.replace("//", "/");
                if (!file.isDirectory() && resourceName.matches(name)) {
                    resources.add(resourceName);
                }
            }
        } else if (classResourceURL.getProtocol().equals("jar")) {
            // 打包成jar包时,class和resource同位于jar包里
            String jarPath = classResourcePath.substring(classResourcePath.indexOf("/"), classResourceURL.getPath().indexOf("!"));
            try {
                JarFile jarFile = new JarFile(URLDecoder.decode(jarPath, "UTF-8"));
                Enumeration<JarEntry> jarEntries = jarFile.entries();
                while (jarEntries.hasMoreElements()) {
                    JarEntry jarEntry = jarEntries.nextElement();
                    String resourceName = jarEntry.getName();
                    if (resourceName.matches(name) && !jarEntry.isDirectory()) {
                        resources.add(resourceName);
                    }
                }
            } catch (UnsupportedEncodingException e) {
            }
        }
        return resources.toArray(new String[0]);
    }

}
