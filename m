Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4E77A3FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbjIRDiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjIRDhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:37:52 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Sep 2023 20:37:46 PDT
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B711C;
        Sun, 17 Sep 2023 20:37:45 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id NCC00132;
        Mon, 18 Sep 2023 11:36:32 +0800
Received: from localhost.localdomain.com (10.73.42.143) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server id
 15.1.2507.32; Mon, 18 Sep 2023 11:36:31 +0800
From:   Charles Han <hanchunchao@inspur.com>
To:     <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <nick.forrington@arm.com>,
        <ilkka@os.amperecomputing.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] perf vendors events: Remove repeated word in comments
Date:   Mon, 18 Sep 2023 11:36:23 +0800
Message-ID: <20230918033623.159213-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.73.42.143]
tUid:   202391811363267176553b2cf039225ba15baa6f02be2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "of" in comments.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv   | 2 +-
 tools/perf/pmu-events/arch/nds32/mapfile.csv   | 2 +-
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 32674ddd2b63..5b58db5032c1 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -4,7 +4,7 @@
 # where
 #	MIDR	Processor version
 #		Variant[23:20] and Revision [3:0] should be zero.
-#	Version could be used to track version of of JSON file
+#	Version could be used to track version of JSON file
 #		but currently unused.
 #	JSON/file/pathname is the path to JSON file, relative
 #		to tools/perf/pmu-events/arch/arm64/.
diff --git a/tools/perf/pmu-events/arch/nds32/mapfile.csv b/tools/perf/pmu-events/arch/nds32/mapfile.csv
index efb395f26883..c76e5fbdac23 100644
--- a/tools/perf/pmu-events/arch/nds32/mapfile.csv
+++ b/tools/perf/pmu-events/arch/nds32/mapfile.csv
@@ -4,7 +4,7 @@
 # where
 #	MIDR	Processor version
 #		Variant[23:20] and Revision [3:0] should be zero.
-#	Version could be used to track version of of JSON file
+#	Version could be used to track version of JSON file
 #		but currently unused.
 #	JSON/file/pathname is the path to JSON file, relative
 #		to tools/perf/pmu-events/arch/arm64/.
diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index 4abdfc3f9692..a534ff6db14b 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -3,7 +3,7 @@
 #
 # where
 # 	PVR	Processor version
-# 	Version could be used to track version of of JSON file
+# 	Version could be used to track version of JSON file
 # 		but currently unused.
 # 	JSON/file/pathname is the path to JSON file, relative
 # 		to tools/perf/pmu-events/arch/powerpc/.
-- 
2.31.1

