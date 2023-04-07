package com.backend;

import MergeTests.Merge;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import static org.junit.jupiter.api.Assertions.*;

class MainTest {
    // This first test uses a directory that exists
    @Test
    void mergeFiles1() throws IOException {
        Path relative = Paths.get("TransactionFiles");
        Merge m = new Merge(relative.toString(), "Merged_Transaction.txt");
        assertEquals("Merged_Transaction.txt", m.mergeFiles(relative.toString(), "Merged_Transaction.txt"));
    }

    // This second test uses a directory that does not exist
    @Test
    void mergeFiles2() throws IOException {
        Path relative = Paths.get("notAFile");
        Merge m = new Merge(relative.toString(), "Merged_Transaction.txt");
        assertEquals("ERROR! No files to merge.", m.mergeFiles(relative.toString(), "Merged_Transaction.txt"));
    }
}