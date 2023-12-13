Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468C811DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379289AbjLMTDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:03:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8BE95
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFD9C433C7;
        Wed, 13 Dec 2023 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702494227;
        bh=zkxV/sJ91hBwZ2pcDcldOS6t/0SJ1DBEmN593qqkP8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsMpltOj8b5LLTVNjVwEqLIsRh8q05n4NT8JLQWlwVypSIKY6eN74NUwjf7yqfpGu
         K5QgM7ZGlZgpO0+2xyPPwj7bykR38c57sfAW+T9Ao8j5z3hwb5zsGYaX2bp4ERAOIq
         Z5wLSbvbkf1poMf7iFSWJqG/+SAJvZeyYvzfeH2S3K7/YAgYvasfi6Pe7ExgKIKrZE
         WDpJQTooHK/zayfuGnOGXGPjkCbLj8B817wwNwwlfOY6fC/vNqRivwT1mVnuksHKVT
         r3q+ype7ln+bWVGHZ2b1VkLaO6j54rq63bhQPDjWe1sKfbbmdfzHqCHP/3eXz3IIpK
         Ff4KF5MNj0fOQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm/damon: update email of SeongJae
Date:   Wed, 13 Dec 2023 19:03:33 +0000
Message-Id: <20231213190338.54146-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae is using his kernel.org account for DAMON development.  Update
the old email addresses on the comments of DAMON source files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h     | 2 +-
 mm/damon/core-test.h      | 2 +-
 mm/damon/core.c           | 2 +-
 mm/damon/dbgfs-test.h     | 2 +-
 mm/damon/dbgfs.c          | 2 +-
 mm/damon/modules-common.c | 2 +-
 mm/damon/vaddr-test.h     | 2 +-
 mm/damon/vaddr.c          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 12510d8c51c6..5881e4ac30be 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -2,7 +2,7 @@
 /*
  * DAMON api
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #ifndef _DAMON_H_
diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6e5e9502d648..876e398557b0 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -4,7 +4,7 @@
  *
  * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #ifdef CONFIG_DAMON_KUNIT_TEST
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2c0cc65d041e..36f6f1d21ff0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2,7 +2,7 @@
 /*
  * Data Access Monitor
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #define pr_fmt(fmt) "damon: " fmt
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 0bb0d532b159..2d85217f5ba4 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -2,7 +2,7 @@
 /*
  * DAMON Debugfs Interface Unit Tests
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #ifdef CONFIG_DAMON_DBGFS_KUNIT_TEST
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index dc0ea1fc30ca..7dac24e69e3b 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -2,7 +2,7 @@
 /*
  * DAMON Debugfs Interface
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #define pr_fmt(fmt) "damon-dbgfs: " fmt
diff --git a/mm/damon/modules-common.c b/mm/damon/modules-common.c
index b2381a8466ec..7cf96574cde7 100644
--- a/mm/damon/modules-common.c
+++ b/mm/damon/modules-common.c
@@ -2,7 +2,7 @@
 /*
  * Common Primitives for DAMON Modules
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #include <linux/damon.h>
diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index dcf1ca6b31cc..83626483f82b 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -4,7 +4,7 @@
  *
  * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index a4d1f63c5b23..a67454b825dc 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -2,7 +2,7 @@
 /*
  * DAMON Primitives for Virtual Address Spaces
  *
- * Author: SeongJae Park <sjpark@amazon.de>
+ * Author: SeongJae Park <sj@kernel.org>
  */
 
 #define pr_fmt(fmt) "damon-va: " fmt
-- 
2.34.1

