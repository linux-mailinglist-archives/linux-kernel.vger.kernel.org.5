Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95FF7DB5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjJ3JMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjJ3JME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:12:04 -0400
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFC6B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:11:58 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8653f735c45d-61d69;
        Mon, 30 Oct 2023 17:11:56 +0800 (CST)
X-RM-TRANSID: 2ee8653f735c45d-61d69
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9653f7359c44-21d77;
        Mon, 30 Oct 2023 17:11:55 +0800 (CST)
X-RM-TRANSID: 2ee9653f7359c44-21d77
From:   zhaimingbing <zhaimingbing@cmss.chinamobile.com>
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] perf tests:FIx spelling mistake "whic" to "which"
Date:   Mon, 30 Oct 2023 15:58:25 +0800
Message-Id: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake, Please fix it.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/tests/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 61186d0d1..97e1bdd6e 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -188,7 +188,7 @@ static int test__attr(struct test_suite *test __maybe_unused, int subtest __mayb
 	if (perf_pmus__num_core_pmus() > 1) {
 		/*
 		 * TODO: Attribute tests hard code the PMU type. If there are >1
-		 * core PMU then each PMU will have a different type whic
+		 * core PMU then each PMU will have a different type which
 		 * requires additional support.
 		 */
 		pr_debug("Skip test on hybrid systems");
-- 
2.33.0



