Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725377C6EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378475AbjJLNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJLNIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:08:42 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 06:08:34 PDT
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F291CBA;
        Thu, 12 Oct 2023 06:08:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [183.200.20.165])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C3B25800089;
        Thu, 12 Oct 2023 21:00:26 +0800 (CST)
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
To:     corbet@lwn.net
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, src.res.211@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_TW: replace my email address
Date:   Thu, 12 Oct 2023 21:00:08 +0800
Message-Id: <20231012130008.102174-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkNKVkMYQh8aGhhLSExDTVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpDSFVJS0tVSUtVSk1OWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
X-HM-Tid: 0a8b23f95e27b03akuuuc3b25800089
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Cxw5TDwxEAsiTAgROCgd
        SkoaCiNVSlVKTUJMSkpOTUlCS0lKVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpDSFVJS0tVSUtVSk1OWVdZCAFZQU9DT09NNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gmail address will not be used often from now on, and replace it
with the email which is more frequently accessed by myself.

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 .../translations/zh_CN/dev-tools/testing-overview.rst     | 2 +-
 Documentation/translations/zh_TW/IRQ.txt                  | 8 ++++----
 Documentation/translations/zh_TW/admin-guide/README.rst   | 2 +-
 .../translations/zh_TW/admin-guide/bug-bisect.rst         | 2 +-
 .../translations/zh_TW/admin-guide/bug-hunting.rst        | 2 +-
 .../translations/zh_TW/admin-guide/clearing-warn-once.rst | 2 +-
 Documentation/translations/zh_TW/admin-guide/cpu-load.rst | 2 +-
 Documentation/translations/zh_TW/admin-guide/index.rst    | 2 +-
 Documentation/translations/zh_TW/admin-guide/init.rst     | 2 +-
 .../translations/zh_TW/admin-guide/reporting-issues.rst   | 2 +-
 .../translations/zh_TW/admin-guide/security-bugs.rst      | 2 +-
 .../translations/zh_TW/admin-guide/tainted-kernels.rst    | 2 +-
 Documentation/translations/zh_TW/admin-guide/unicode.rst  | 2 +-
 Documentation/translations/zh_TW/arch/arm64/amu.rst       | 2 +-
 Documentation/translations/zh_TW/arch/arm64/booting.txt   | 4 ++--
 .../translations/zh_TW/arch/arm64/elf_hwcaps.rst          | 2 +-
 .../translations/zh_TW/arch/arm64/hugetlbpage.rst         | 2 +-
 Documentation/translations/zh_TW/arch/arm64/index.rst     | 2 +-
 .../translations/zh_TW/arch/arm64/legacy_instructions.txt | 4 ++--
 Documentation/translations/zh_TW/arch/arm64/memory.txt    | 4 ++--
 Documentation/translations/zh_TW/arch/arm64/perf.rst      | 2 +-
 .../translations/zh_TW/arch/arm64/silicon-errata.txt      | 4 ++--
 .../translations/zh_TW/arch/arm64/tagged-pointers.txt     | 4 ++--
 Documentation/translations/zh_TW/dev-tools/sparse.rst     | 6 +++---
 .../translations/zh_TW/dev-tools/testing-overview.rst     | 2 +-
 Documentation/translations/zh_TW/disclaimer-zh_TW.rst     | 2 +-
 Documentation/translations/zh_TW/filesystems/debugfs.rst  | 2 +-
 Documentation/translations/zh_TW/filesystems/index.rst    | 2 +-
 Documentation/translations/zh_TW/filesystems/sysfs.txt    | 2 +-
 Documentation/translations/zh_TW/filesystems/virtiofs.rst | 2 +-
 Documentation/translations/zh_TW/gpio.txt                 | 8 ++++----
 Documentation/translations/zh_TW/index.rst                | 2 +-
 Documentation/translations/zh_TW/io_ordering.txt          | 8 ++++----
 Documentation/translations/zh_TW/process/1.Intro.rst      | 2 +-
 Documentation/translations/zh_TW/process/2.Process.rst    | 2 +-
 .../translations/zh_TW/process/3.Early-stage.rst          | 2 +-
 Documentation/translations/zh_TW/process/4.Coding.rst     | 2 +-
 Documentation/translations/zh_TW/process/5.Posting.rst    | 2 +-
 .../translations/zh_TW/process/6.Followthrough.rst        | 2 +-
 .../translations/zh_TW/process/7.AdvancedTopics.rst       | 2 +-
 Documentation/translations/zh_TW/process/8.Conclusion.rst | 2 +-
 .../zh_TW/process/code-of-conduct-interpretation.rst      | 2 +-
 .../translations/zh_TW/process/code-of-conduct.rst        | 2 +-
 Documentation/translations/zh_TW/process/coding-style.rst | 2 +-
 .../translations/zh_TW/process/development-process.rst    | 2 +-
 .../translations/zh_TW/process/email-clients.rst          | 2 +-
 .../zh_TW/process/embargoed-hardware-issues.rst           | 2 +-
 Documentation/translations/zh_TW/process/howto.rst        | 2 +-
 Documentation/translations/zh_TW/process/index.rst        | 2 +-
 .../zh_TW/process/kernel-driver-statement.rst             | 2 +-
 .../zh_TW/process/kernel-enforcement-statement.rst        | 2 +-
 .../translations/zh_TW/process/license-rules.rst          | 2 +-
 Documentation/translations/zh_TW/process/magic-number.rst | 2 +-
 .../translations/zh_TW/process/management-style.rst       | 2 +-
 .../translations/zh_TW/process/programming-language.rst   | 2 +-
 .../translations/zh_TW/process/stable-api-nonsense.rst    | 2 +-
 .../translations/zh_TW/process/stable-kernel-rules.rst    | 2 +-
 .../translations/zh_TW/process/submit-checklist.rst       | 2 +-
 .../translations/zh_TW/process/submitting-patches.rst     | 2 +-
 .../zh_TW/process/volatile-considered-harmful.rst         | 2 +-
 MAINTAINERS                                               | 2 +-
 61 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
index 69e7e4cb2002..c91f9b60f9f1 100644
--- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -3,7 +3,7 @@
 .. include:: ../disclaimer-zh_CN.rst
 
 :Original: Documentation/dev-tools/testing-overview.rst
-:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
+:Translator: 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 ============
 内核测试指南
diff --git a/Documentation/translations/zh_TW/IRQ.txt b/Documentation/translations/zh_TW/IRQ.txt
index fd78ca720298..8115a7618307 100644
--- a/Documentation/translations/zh_TW/IRQ.txt
+++ b/Documentation/translations/zh_TW/IRQ.txt
@@ -7,7 +7,7 @@ help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
 Maintainer: Eric W. Biederman <ebiederman@xmission.com>
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/core-api/irq/index.rst 的繁體中文翻譯
 
@@ -16,9 +16,9 @@ Documentation/core-api/irq/index.rst 的繁體中文翻譯
 者翻譯存在問題，請聯繫繁體中文版維護者。
 
 英文版維護者： Eric W. Biederman <ebiederman@xmission.com>
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版校譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版維護者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
index 4cb581f5994a..a6e34c200ea3 100644
--- a/Documentation/translations/zh_TW/admin-guide/README.rst
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux內核6.x版本 <http://kernel.org/>
 =========================================
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
index 3f10a9f8f223..1efe913b8da0 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 二分（bisect）缺陷
 +++++++++++++++++++
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
index 631fd2650929..c139ec99cab1 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 追蹤缺陷
 =========
diff --git a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
index 6961006b4a2d..a3e82ff9daac 100644
--- a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
+++ b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
+:Translator: 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 清除 WARN_ONCE
 --------------
diff --git a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
index cc046f3b7ffa..4c25a2105b39 100644
--- a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
+++ b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
+:Translator: 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 ========
 CPU 負載
diff --git a/Documentation/translations/zh_TW/admin-guide/index.rst b/Documentation/translations/zh_TW/admin-guide/index.rst
index aba8939351e0..9335c0e9105d 100644
--- a/Documentation/translations/zh_TW/admin-guide/index.rst
+++ b/Documentation/translations/zh_TW/admin-guide/index.rst
@@ -4,7 +4,7 @@
 
 :Original: :doc:`../../../admin-guide/index`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             胡皓文 Hu Haowen <src.res.211@gmail.com>
+             胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux 內核用戶和管理員指南
 ==========================
diff --git a/Documentation/translations/zh_TW/admin-guide/init.rst b/Documentation/translations/zh_TW/admin-guide/init.rst
index be6e34f5f7fa..4cef1994c650 100644
--- a/Documentation/translations/zh_TW/admin-guide/init.rst
+++ b/Documentation/translations/zh_TW/admin-guide/init.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 解釋“No working init found.”啓動掛起消息
 =========================================
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
index fe5a5a07d51a..bc132b25f2ae 100644
--- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
@@ -9,7 +9,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 
 報告問題
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
index c0e9fc247695..cfe1e58e116b 100644
--- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 安全缺陷
 =========
diff --git a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
index 47629f6b05de..0d8046576d04 100644
--- a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
+++ b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 受污染的內核
 -------------
diff --git a/Documentation/translations/zh_TW/admin-guide/unicode.rst b/Documentation/translations/zh_TW/admin-guide/unicode.rst
index a2b48b5d0a64..f43edb2b5ed0 100644
--- a/Documentation/translations/zh_TW/admin-guide/unicode.rst
+++ b/Documentation/translations/zh_TW/admin-guide/unicode.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Unicode（統一碼）支持
 ======================
diff --git a/Documentation/translations/zh_TW/arch/arm64/amu.rst b/Documentation/translations/zh_TW/arch/arm64/amu.rst
index 1b451eae2bee..3726c1671ab6 100644
--- a/Documentation/translations/zh_TW/arch/arm64/amu.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/amu.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/amu.rst <amu_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res.211@gmail.com>
+            Hu Haowen <2023002089@link.tyut.edu.cn>
 
 ==================================
 AArch64 Linux 中擴展的活動監控單元
diff --git a/Documentation/translations/zh_TW/arch/arm64/booting.txt b/Documentation/translations/zh_TW/arch/arm64/booting.txt
index be0de91ecebd..f1ac96370ace 100644
--- a/Documentation/translations/zh_TW/arch/arm64/booting.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/booting.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 M:	Will Deacon <will.deacon@arm.com>
 zh_CN:	Fu Wei <wefu@redhat.com>
-zh_TW:	Hu Haowen <src.res.211@gmail.com>
+zh_TW:	Hu Haowen <2023002089@link.tyut.edu.cn>
 C:	55f058e7574c3615dea4615573a19bdb258696c6
 ---------------------------------------------------------------------
 Documentation/arch/arm64/booting.rst 的中文翻譯
@@ -23,7 +23,7 @@ Documentation/arch/arm64/booting.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <2023002089@link.tyut.edu.cn>
 本文翻譯提交時的 Git 檢出點爲： 55f058e7574c3615dea4615573a19bdb258696c6
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
index d2c1c2f23812..cada25303e8d 100644
--- a/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res.211@gmail.com>
+            Hu Haowen <2023002089@link.tyut.edu.cn>
 
 ================
 ARM64 ELF hwcaps
diff --git a/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst b/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
index a17858c978d6..b6849935e028 100644
--- a/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/hugetlbpage.rst <hugetlbpage_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res.211@gmail.com>
+            Hu Haowen <2023002089@link.tyut.edu.cn>
 
 =====================
 ARM64中的 HugeTLBpage
diff --git a/Documentation/translations/zh_TW/arch/arm64/index.rst b/Documentation/translations/zh_TW/arch/arm64/index.rst
index a62b5f06b66c..86014346792e 100644
--- a/Documentation/translations/zh_TW/arch/arm64/index.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/index.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/arch/arm64/index.rst <arm64_index>`
 :Translator: Bailu Lin <bailu.lin@vivo.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_arm64_index:
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
index 7d1f0593d7ca..5c664555a71a 100644
--- a/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
@@ -11,7 +11,7 @@ or if there is a problem with the translation.
 Maintainer: Punit Agrawal <punit.agrawal@arm.com>
             Suzuki K. Poulose <suzuki.poulose@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/arch/arm64/legacy_instructions.rst 的中文翻譯
 
@@ -26,7 +26,7 @@ Documentation/arch/arm64/legacy_instructions.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者：胡皓文  Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者：胡皓文  Hu Haowen <2023002089@link.tyut.edu.cn>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/arch/arm64/memory.txt b/Documentation/translations/zh_TW/arch/arm64/memory.txt
index e41c518e71c6..6ee2239c293f 100644
--- a/Documentation/translations/zh_TW/arch/arm64/memory.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/memory.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 Maintainer: Catalin Marinas <catalin.marinas@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/arch/arm64/memory.rst 的中文翻譯
 
@@ -24,7 +24,7 @@ Documentation/arch/arm64/memory.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <2023002089@link.tyut.edu.cn>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/arch/arm64/perf.rst b/Documentation/translations/zh_TW/arch/arm64/perf.rst
index 405d5f66964f..ce083ba63872 100644
--- a/Documentation/translations/zh_TW/arch/arm64/perf.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/perf.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/perf.rst <perf_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res.211@gmail.com>
+            Hu Haowen <2023002089@link.tyut.edu.cn>
 
 =============
 Perf 事件屬性
diff --git a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
index 70371807ca83..16d73b6c309f 100644
--- a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 M:	Will Deacon <will.deacon@arm.com>
 zh_CN:	Fu Wei <wefu@redhat.com>
-zh_TW:	Hu Haowen <src.res.211@gmail.com>
+zh_TW:	Hu Haowen <2023002089@link.tyut.edu.cn>
 C:	1926e54f115725a9248d0c4c65c22acaf94de4c4
 ---------------------------------------------------------------------
 Documentation/arch/arm64/silicon-errata.rst 的中文翻譯
@@ -23,7 +23,7 @@ Documentation/arch/arm64/silicon-errata.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <2023002089@link.tyut.edu.cn>
 本文翻譯提交時的 Git 檢出點爲： 1926e54f115725a9248d0c4c65c22acaf94de4c4
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
index 9812d99549ba..e86ffa893ef6 100644
--- a/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 Maintainer: Will Deacon <will.deacon@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/arch/arm64/tagged-pointers.rst 的中文翻譯
 
@@ -22,7 +22,7 @@ Documentation/arch/arm64/tagged-pointers.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文  Hu Haowen <2023002089@link.tyut.edu.cn>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.rst b/Documentation/translations/zh_TW/dev-tools/sparse.rst
index 11d64709d6a4..81da20858264 100644
--- a/Documentation/translations/zh_TW/dev-tools/sparse.rst
+++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
@@ -6,7 +6,7 @@ communicating in English you can also ask the Chinese maintainer for
 help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/dev-tools/sparse.rst 的繁體中文翻譯
 
@@ -14,8 +14,8 @@ Documentation/dev-tools/sparse.rst 的繁體中文翻譯
 交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
 者翻譯存在問題，請聯繫繁體中文版維護者。
 
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版維護者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/dev-tools/testing-overview.rst b/Documentation/translations/zh_TW/dev-tools/testing-overview.rst
index fb3f691f46c3..3b08aad1da00 100644
--- a/Documentation/translations/zh_TW/dev-tools/testing-overview.rst
+++ b/Documentation/translations/zh_TW/dev-tools/testing-overview.rst
@@ -3,7 +3,7 @@
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: Documentation/dev-tools/testing-overview.rst
-:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
+:Translator: 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 ============
 內核測試指南
diff --git a/Documentation/translations/zh_TW/disclaimer-zh_TW.rst b/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
index 0d0ffb1ca4e8..28b734c223b6 100644
--- a/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
+++ b/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
@@ -7,5 +7,5 @@
 
 .. note::
      如果您發現本文檔與原始文件有任何不同或者有翻譯問題，請聯繫該文件的譯者，
-     或者發送電子郵件給胡皓文以獲取幫助：<src.res.211@gmail.com>。
+     或者發送電子郵件給胡皓文以獲取幫助：<2023002089@link.tyut.edu.cn>。
 
diff --git a/Documentation/translations/zh_TW/filesystems/debugfs.rst b/Documentation/translations/zh_TW/filesystems/debugfs.rst
index 78e2e08af95e..cda7d0e18b9b 100644
--- a/Documentation/translations/zh_TW/filesystems/debugfs.rst
+++ b/Documentation/translations/zh_TW/filesystems/debugfs.rst
@@ -14,7 +14,7 @@ Debugfs
 	中文版維護者： 羅楚成 Chucheng Luo <luochucheng@vivo.com>
 	中文版翻譯者： 羅楚成 Chucheng Luo <luochucheng@vivo.com>
 	中文版校譯者:  羅楚成 Chucheng Luo <luochucheng@vivo.com>
-	繁體中文版校譯者: 胡皓文 Hu Haowen <src.res.211@gmail.com>
+	繁體中文版校譯者: 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 
 
diff --git a/Documentation/translations/zh_TW/filesystems/index.rst b/Documentation/translations/zh_TW/filesystems/index.rst
index d7f9d61f654c..88f0e632bfe2 100644
--- a/Documentation/translations/zh_TW/filesystems/index.rst
+++ b/Documentation/translations/zh_TW/filesystems/index.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
 :Translator: Wang Wenhu <wenhu.wang@vivo.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_filesystems_index:
 
diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Documentation/translations/zh_TW/filesystems/sysfs.txt
index ebe90651fc3b..978462d5fe14 100644
--- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
@@ -22,7 +22,7 @@ Documentation/filesystems/sysfs.rst 的中文翻譯
 中文版維護者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
 中文版翻譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
 中文版校譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
-繁體中文版校譯者：胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者：胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/filesystems/virtiofs.rst b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
index 6150ad964e78..704a0ee44fd2 100644
--- a/Documentation/translations/zh_TW/filesystems/virtiofs.rst
+++ b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
@@ -10,7 +10,7 @@
 	中文版維護者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
 	中文版翻譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
 	中文版校譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
-	繁體中文版校譯者：胡皓文 Hu Haowen <src.res.211@gmail.com>
+	繁體中文版校譯者：胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 ===========================================
 virtiofs: virtio-fs 主機<->客機共享文件系統
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index 555e4b11a5c7..b9b48012c62e 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
 
 Maintainer: Grant Likely <grant.likely@secretlab.ca>
 		Linus Walleij <linus.walleij@linaro.org>
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/admin-guide/gpio 的繁體中文翻譯
 
@@ -18,9 +18,9 @@ Documentation/admin-guide/gpio 的繁體中文翻譯
 
 英文版維護者： Grant Likely <grant.likely@secretlab.ca>
 		Linus Walleij <linus.walleij@linaro.org>
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版校譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版維護者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index 563ac9bfc66b..660a74d2023c 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -15,7 +15,7 @@
 
 .. note::
    內核文檔繁體中文版的翻譯工作正在進行中。如果您願意並且有時間參與這項工
-   作，歡迎提交補丁給胡皓文 <src.res.211@gmail.com>。
+   作，歡迎提交補丁給胡皓文 <2023002089@link.tyut.edu.cn>。
 
 與Linux 內核社區一起工作
 ------------------------
diff --git a/Documentation/translations/zh_TW/io_ordering.txt b/Documentation/translations/zh_TW/io_ordering.txt
index 03f86840c139..00b374092d7e 100644
--- a/Documentation/translations/zh_TW/io_ordering.txt
+++ b/Documentation/translations/zh_TW/io_ordering.txt
@@ -6,7 +6,7 @@ communicating in English you can also ask the Chinese maintainer for
 help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
-Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
+Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
 ---------------------------------------------------------------------
 Documentation/driver-api/io_ordering.rst 的繁體中文翻譯
 
@@ -14,9 +14,9 @@ Documentation/driver-api/io_ordering.rst 的繁體中文翻譯
 交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
 者翻譯存在問題，請聯繫繁體中文版維護者。
 
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
-繁體中文版校譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版維護者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
+繁體中文版校譯者： 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/process/1.Intro.rst b/Documentation/translations/zh_TW/process/1.Intro.rst
index 6e754ac48964..345c4cbe9b55 100644
--- a/Documentation/translations/zh_TW/process/1.Intro.rst
+++ b/Documentation/translations/zh_TW/process/1.Intro.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_process_intro:
 
diff --git a/Documentation/translations/zh_TW/process/2.Process.rst b/Documentation/translations/zh_TW/process/2.Process.rst
index 49385d65c216..f45ddba6238f 100644
--- a/Documentation/translations/zh_TW/process/2.Process.rst
+++ b/Documentation/translations/zh_TW/process/2.Process.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_process:
 
diff --git a/Documentation/translations/zh_TW/process/3.Early-stage.rst b/Documentation/translations/zh_TW/process/3.Early-stage.rst
index a6959e6350f4..a58fc9e0ea99 100644
--- a/Documentation/translations/zh_TW/process/3.Early-stage.rst
+++ b/Documentation/translations/zh_TW/process/3.Early-stage.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_early_stage:
 
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index 7a4e01eabd81..bdd2abe4daf4 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_coding:
 
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index d398dda427aa..7d66a1c638be 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_posting:
 
diff --git a/Documentation/translations/zh_TW/process/6.Followthrough.rst b/Documentation/translations/zh_TW/process/6.Followthrough.rst
index bcc885ae1b8e..f3b195966632 100644
--- a/Documentation/translations/zh_TW/process/6.Followthrough.rst
+++ b/Documentation/translations/zh_TW/process/6.Followthrough.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_followthrough:
 
diff --git a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
index db74d8ca3f3b..b449d67e3ad9 100644
--- a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_advancedtopics:
 
diff --git a/Documentation/translations/zh_TW/process/8.Conclusion.rst b/Documentation/translations/zh_TW/process/8.Conclusion.rst
index a0c00741f912..d1634421b62c 100644
--- a/Documentation/translations/zh_TW/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_TW/process/8.Conclusion.rst
@@ -10,7 +10,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_conclusion:
 
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
index 48df918000e9..fbe66b001322 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/code-of-conduct-interpretation.rst <code_of_conduct_interpretation>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_code_of_conduct_interpretation:
 
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct.rst b/Documentation/translations/zh_TW/process/code-of-conduct.rst
index a7a31de03526..d24f1695bd02 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_code_of_conduct:
 
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 5749363de421..f11dbb65ca21 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -17,7 +17,7 @@
  - 管旭東 Xudong Guan <xudong.guan@gmail.com>
  - Li Zefan <lizf@cn.fujitsu.com>
  - Wang Chen <wangchen@cn.fujitsu.com>
- - Hu Haowen <src.res.211@gmail.com>
+ - Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux 內核代碼風格
 ==================
diff --git a/Documentation/translations/zh_TW/process/development-process.rst b/Documentation/translations/zh_TW/process/development-process.rst
index 7d803d3db89e..6eb49d317046 100644
--- a/Documentation/translations/zh_TW/process/development-process.rst
+++ b/Documentation/translations/zh_TW/process/development-process.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/development-process.rst <development_process_main>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_development_process_main:
 
diff --git a/Documentation/translations/zh_TW/process/email-clients.rst b/Documentation/translations/zh_TW/process/email-clients.rst
index 55e10d3fc28a..a5ac9400a9f5 100644
--- a/Documentation/translations/zh_TW/process/email-clients.rst
+++ b/Documentation/translations/zh_TW/process/email-clients.rst
@@ -15,7 +15,7 @@
  - Yinglin Luan <synmyth@gmail.com>
  - Xiaochen Wang <wangxiaochen0@gmail.com>
  - yaxinsn <yaxinsn@163.com>
- - Hu Haowen <src.res.211@gmail.com>
+ - Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux郵件客戶端配置信息
 =======================
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index b9f6ab7b6666..3cce7db2ab7e 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/embargoed-hardware-issues.rst <embargoed_hardware_issues>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 被限制的硬件問題
 ================
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 306f5b77b4b8..80c416483e73 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -16,7 +16,7 @@
                    鍾宇  TripleX Chung <xxx.phy@gmail.com>
                    陳琦  Maggie Chen <chenqi@beyondsoft.com>
                    王聰  Wang Cong <xiyou.wangcong@gmail.com>
-                   胡皓文 Hu Haowen <src.res.211@gmail.com>
+                   胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 如何參與Linux內核開發
 =====================
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documentation/translations/zh_TW/process/index.rst
index 6a0d98b2f9ee..65922d9faa20 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -9,7 +9,7 @@
 
 :Original: :ref:`Documentation/process/index.rst <process_index>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_process_index:
 
diff --git a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
index e967089d2e1f..23d5cae9685b 100644
--- a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
@@ -6,7 +6,7 @@
 
 :Original: :ref:`Documentation/process/kernel-driver-statement.rst <process_statement_driver>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 內核驅動聲明
 ------------
diff --git a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
index 2861f4a15721..524eb4ac26cc 100644
--- a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
@@ -6,7 +6,7 @@
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux 內核執行聲明
 ------------------
diff --git a/Documentation/translations/zh_TW/process/license-rules.rst b/Documentation/translations/zh_TW/process/license-rules.rst
index 2c43bcf2ac79..594255856b68 100644
--- a/Documentation/translations/zh_TW/process/license-rules.rst
+++ b/Documentation/translations/zh_TW/process/license-rules.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/license-rules.rst <kernel_licensing>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_kernel_licensing:
 
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
index 5657d5cd18d4..199cd5d63973 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -12,7 +12,7 @@
         中文版維護者： 賈威威 Jia Wei Wei <harryxiyou@gmail.com>
         中文版翻譯者： 賈威威 Jia Wei Wei <harryxiyou@gmail.com>
         中文版校譯者： 賈威威 Jia Wei Wei <harryxiyou@gmail.com>
-                      胡皓文 Hu Haowen <src.res.211@gmail.com>
+                      胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux 魔術數
 ============
diff --git a/Documentation/translations/zh_TW/process/management-style.rst b/Documentation/translations/zh_TW/process/management-style.rst
index f3913e3c159d..7cb912e89032 100644
--- a/Documentation/translations/zh_TW/process/management-style.rst
+++ b/Documentation/translations/zh_TW/process/management-style.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/management-style.rst <managementstyle>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_managementstyle:
 
diff --git a/Documentation/translations/zh_TW/process/programming-language.rst b/Documentation/translations/zh_TW/process/programming-language.rst
index e33389676eed..d2c64a5599e8 100644
--- a/Documentation/translations/zh_TW/process/programming-language.rst
+++ b/Documentation/translations/zh_TW/process/programming-language.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res.211@gmail.com>
+             Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_programming_language:
 
diff --git a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
index 6839d25bb22a..4b8597fed5ae 100644
--- a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
@@ -12,7 +12,7 @@
         中文版維護者： 鍾宇  TripleX Chung <xxx.phy@gmail.com>
         中文版翻譯者： 鍾宇  TripleX Chung <xxx.phy@gmail.com>
         中文版校譯者： 李陽  Li Yang <leoyang.li@nxp.com>
-                      胡皓文 Hu Haowen <src.res.211@gmail.com>
+                      胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 Linux 內核驅動接口
 ==================
diff --git a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
index bd82a8ff3969..2f8f064f8629 100644
--- a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
@@ -15,7 +15,7 @@
         中文版校譯者：
             - 李陽  Li Yang <leoyang.li@nxp.com>
             - Kangkai Yin <e12051@motorola.com>
-            - 胡皓文 Hu Haowen <src.res.211@gmail.com>
+            - 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 所有你想知道的事情 - 關於linux穩定版發佈
 ========================================
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index 942962d1e2f4..e57ef0f99e0c 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -6,7 +6,7 @@
 :Translator:
  - Alex Shi <alexs@kernel.org>
  - Wu XiangCheng <bobwxc@email.cn>
- - Hu Haowen <src.res.211@gmail.com>
+ - Hu Haowen <2023002089@link.tyut.edu.cn>
 
 .. _tw_submitchecklist:
 
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index 8272b3218b54..99fa0f2fe6f4 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -14,7 +14,7 @@
 :校譯:
  - 李陽 Li Yang <leoyang.li@nxp.com>
  - 王聰 Wang Cong <xiyou.wangcong@gmail.com>
- - 胡皓文 Hu Haowen <src.res.211@gmail.com>
+ - 胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 
 提交補丁：如何讓你的改動進入內核
diff --git a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
index a609620affb0..e2723f3cbbb0 100644
--- a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
@@ -17,7 +17,7 @@
         中文版校譯者： 張漢輝  Eugene Teo <eugeneteo@kernel.sg>
                        楊瑞  Dave Young <hidave.darkstar@gmail.com>
                        時奎亮 Alex Shi <alex.shi@linux.alibaba.com>
-                       胡皓文 Hu Haowen <src.res.211@gmail.com>
+                       胡皓文 Hu Haowen <2023002089@link.tyut.edu.cn>
 
 爲什麼不應該使用“volatile”類型
 ==============================
diff --git a/MAINTAINERS b/MAINTAINERS
index 0db8c4e3211e..c9b3d8020bbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22045,7 +22045,7 @@ F:	kernel/trace/trace_osnoise.c
 F:	kernel/trace/trace_sched_wakeup.c
 
 TRADITIONAL CHINESE DOCUMENTATION
-M:	Hu Haowen <src.res.211@gmail.com>
+M:	Hu Haowen <2023002089@link.tyut.edu.cn>
 S:	Maintained
 W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
-- 
2.34.1

