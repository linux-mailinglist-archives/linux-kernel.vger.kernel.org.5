Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F737EEDDD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjKQIxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:53:41 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E155A1A5;
        Fri, 17 Nov 2023 00:53:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VwZGmH._1700211211;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VwZGmH._1700211211)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 16:53:35 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] MAINTAINERS: erofs: add EROFS webpage
Date:   Fri, 17 Nov 2023 16:53:29 +0800
Message-Id: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new `W:` field of the EROFS entry points to the documentation
site at <https://erofs.docs.kernel.org>.

In addition, update the in-tree documentation and Kconfig too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst | 4 ++++
 MAINTAINERS                         | 1 +
 fs/erofs/Kconfig                    | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 57c6ae23b3fc..cc4626d6ee4f 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -91,6 +91,10 @@ compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
 
 - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
 
+For more information, please also refer to the documentation site:
+
+- https://erofs.docs.kernel.org
+
 Bugs and patches are welcome, please kindly help us and send to the following
 linux-erofs mailing list:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..cf39d16ad22a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7855,6 +7855,7 @@ R:	Yue Hu <huyue2@coolpad.com>
 R:	Jeffle Xu <jefflexu@linux.alibaba.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
+W:	https://erofs.docs.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 F:	Documentation/ABI/testing/sysfs-fs-erofs
 F:	Documentation/filesystems/erofs.rst
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index e540648dedc2..1d318f85232d 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -21,7 +21,7 @@ config EROFS_FS
 	  performance under extremely memory pressure without extra cost.
 
 	  See the documentation at <file:Documentation/filesystems/erofs.rst>
-	  for more details.
+	  and the web pages at <https://erofs.docs.kernel.org> for more details.
 
 	  If unsure, say N.
 
-- 
2.39.3

