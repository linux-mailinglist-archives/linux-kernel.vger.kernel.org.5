Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB97A90D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjIUCPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:15:08 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 19:15:01 PDT
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2E6AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:15:00 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id QBI00151;
        Thu, 21 Sep 2023 10:13:51 +0800
Received: from localhost.localdomain.com (10.73.41.97) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.32; Thu, 21 Sep 2023 10:13:51 +0800
From:   huangli05 <huangli05@inspur.com>
To:     <osmtendev@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <speakup@linux-speakup.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=E2=80=9Chuangli05=E2=80=9C?= <huangli05@inspur.com>
Subject: [PATCH] staging: speakup: modify syntax errors in comments
Date:   Thu, 21 Sep 2023 10:13:49 +0800
Message-ID: <20230921021349.3350-1-huangli05@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.73.41.97]
tUid:   2023921101351284cbe0fb7a3b74653109edcf6bee5f9
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

