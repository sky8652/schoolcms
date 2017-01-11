# date   : 2017-01-08
# author : Devil
# version: 2.1

# PS 权限部分sql后面再导出添加

# 教师课程 - 添加学期id并且跳转顺序到id后面
ALTER TABLE `sc_course` ADD `semester_id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '学期id' AFTER `id`;

# 教师课程 - 唯一索引修改(加入学期)
ALTER TABLE `sc_course` DROP INDEX `teacher_class_subject_week_interval`;
ALTER TABLE `sc_course` ADD UNIQUE `semester_teacher_class_subject_week_interval` USING BTREE (`semester_id`, `teacher_id`, `class_id`, `subject_id`, `week_id`, `interval_id`);
ALTER TABLE `sc_course` ADD INDEX semester_id(`semester_id`);

# 配置信息更新 - csv变更为excel
UPDATE `sc_config` SET `only_tag`="excel_charset", `describe`="excel模块编码选择", `name`="Excel编码" WHERE `id`=11;

# 学生成绩 - 添加点评字段
ALTER TABLE `sc_fraction` ADD `comment` char(255) NOT NULL DEFAULT '' COMMENT '教师点评' AFTER `score`;