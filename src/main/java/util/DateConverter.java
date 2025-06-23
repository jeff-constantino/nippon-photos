package util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class DateConverter {

    // LocalDate -> java.util.Date
    public static Date toUtilDate(LocalDate localDate) {
        if (localDate == null) return null;
        return Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    // LocalDateTime -> java.util.Date
    public static Date toUtilDate(LocalDateTime localDateTime) {
        if (localDateTime == null) return null;
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

    // java.util.Date -> LocalDate
    public static LocalDate toLocalDate(Date date) {
        if (date == null) return null;
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

    // java.util.Date -> LocalDateTime
    public static LocalDateTime toLocalDateTime(Date date) {
        if (date == null) return null;
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
    }

    // LocalDate -> java.sql.Date
    public static java.sql.Date toSqlDate(LocalDate localDate) {
        if (localDate == null) return null;
        return java.sql.Date.valueOf(localDate);
    }

    // java.sql.Date -> LocalDate
    public static LocalDate fromSqlDate(java.sql.Date sqlDate) {
        if (sqlDate == null) return null;
        return sqlDate.toLocalDate();
    }

    // LocalDateTime -> java.sql.Timestamp
    public static java.sql.Timestamp toSqlTimestamp(LocalDateTime localDateTime) {
        if (localDateTime == null) return null;
        return java.sql.Timestamp.valueOf(localDateTime);
    }

    // java.sql.Timestamp -> LocalDateTime
    public static LocalDateTime fromSqlTimestamp(java.sql.Timestamp timestamp) {
        if (timestamp == null) return null;
        return timestamp.toLocalDateTime();
    }
}
