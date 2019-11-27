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

    public static List<String> getFileNameListByFolderPath(String folderPath) {
        if (isJarPath(folderPath)) {
            return getFileNameListByFolderPathInJar(folderPath);
        } else {
            File file = new File(folderPath);
            File[] files = file.listFiles();
            List<String> fileNameList = new ArrayList<>();
            for (int i = 0; i < files.length; i++) {
                fileNameList.add(files[i].getName());
            }
            return fileNameList;
        }
    }

    public static List<String> getFileNameListByFolderPathInJar(String folderPathInJar) {
        List<String> result = new ArrayList<>();
        String jarPath = folderPathInJar.substring(folderPathInJar.indexOf("/"), folderPathInJar.indexOf("!"));
        String folder = folderPathInJar.substring(folderPathInJar.indexOf("!") + 1).replace("/", "");
        try {
            JarFile jarFile = new JarFile(URLDecoder.decode(jarPath, "UTF-8"));
            Enumeration<JarEntry> jarEntries = jarFile.entries();
            while (jarEntries.hasMoreElements()) {
                JarEntry jarEntry = jarEntries.nextElement();
                String resourceName = jarEntry.getName();
                if (!resourceName.contains(folder)) continue;
                resourceName = resourceName.replace(folder, "");
                resourceName = resourceName.replace("/", "");
                if ("".equals(resourceName)) continue;
                result.add(resourceName);
            }
        } catch (Exception e) {
        }
        return result;
    }

    public static boolean isJarPath(String path) {
        if (path.contains("jar")) {
            return true;
        } else {
            return false;
        }
    }
}
