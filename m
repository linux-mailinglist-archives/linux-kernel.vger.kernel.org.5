Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867D7A5B76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjISHn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjISHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:43:28 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:43:20 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B010100
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:43:19 -0700 (PDT)
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id OGJ00108;
        Tue, 19 Sep 2023 15:42:08 +0800
Received: from localhost.localdomain.com (10.73.41.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.32; Tue, 19 Sep 2023 15:42:09 +0800
From:   huangli05 <huangli05@inspur.com>
To:     <w.d.hubbs@gmail.com>
CC:     <chris@the-brannons.com>, <kirk@reisers.ca>,
        <samuel.thibault@ens-lyon.org>, <speakup@linux-speakup.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=E2=80=9Chuangli05=E2=80=9C?= <huangli05@inspur.com>
Subject: [PATCH] staging: speakup: modify syntax errors in comments
Date:   Tue, 19 Sep 2023 15:42:06 +0800
Message-ID: <20230919074206.36909-1-huangli05@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.73.41.97]
tUid:   2023919154208931587fee5cfb781f0281e21167b65c1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: “huangli05“ <huangli05@inspur.com>

Change "/* We want to set the the speech synthesis" to "/* We want to set the speech synthesis"

Signed-off-by: “huangli05“ <huangli05@inspur.com>
---
 drivers/accessibility/speakup/speakup_soft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 6d446824677b..6549bfb96e7f 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -446,7 +446,7 @@ static int softsynth_adjust(struct spk_synth *synth, struct st_var_header *var)
 	if (var->var_id != PUNC_LEVEL)
 		return 0;
 
-	/* We want to set the the speech synthesis punctuation level
+	/* We want to set the speech synthesis punctuation level
 	 * accordingly, so it properly tunes speaking A_PUNC characters */
 	var_data = var->data;
 	if (!var_data)
-- 
2.31.1

