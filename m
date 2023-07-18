Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E874875754B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGRH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjGRH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:28:02 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E5AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:28:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4rC26fBZzBR1P6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:27:58 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689665278; x=1692257279; bh=5VRv9ilaWwhiavGlgNYCXJakPKJ
        FJejD3fFBALqFBxs=; b=C5beQ3GE+euEyCbbqkRY76+6X5dYWWq5P99+AKfPfOk
        1jITXCTgT4N9MutEZPP1zFFpZUBlFUGj/a8teiE1Xwn+Uan4pZpapyuYs8pgSdGP
        lSwpKSgcmpr7Kseqp0AIKSkdVq1z4remxImup+e0UsvxSjbwkV63ZBGDyII3FY3T
        MsXu1e2peaxe0qEdVDuK2OlfVSSNXBUYDmfNOfJcL0N6NdQI9bnL8pYo+pNu16zZ
        ALdHaEvjvJD+YXy/ftSPtI4koNRiF06Z2PczmSOfB/ZftQgRo25ptvEJONhs546M
        6wRYjNU0BVK2EupdmfkshLxFW4RwWamIrJJKCSpVREQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vwyXd1wFwgKo for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 15:27:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4rC24mn4zBR0gv;
        Tue, 18 Jul 2023 15:27:58 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 15:27:58 +0800
From:   hanyu001@208suo.com
To:     mchehab@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org
Subject: [PATCH] wifi: av7110: remove space before ')'
In-Reply-To: <tencent_C61A29FA864A05D9D83277F0CF7721A52D0A@qq.com>
References: <tencent_C61A29FA864A05D9D83277F0CF7721A52D0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <89948b0041b6553b65a8cf8e8f1152b4@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following errors detected by checkpatch.pl:

./drivers/staging/media/av7110/av7110.c:2556: ERROR: space prohibited 
before that close parenthesis ')'
./drivers/staging/media/av7110/av7110.c:2558: ERROR: space prohibited 
before that close parenthesis ')'
./drivers/staging/media/av7110/av7110.c:2599: ERROR: space prohibited 
before that close parenthesis ')'

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/staging/media/av7110/av7110.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110.c 
b/drivers/staging/media/av7110/av7110.c
index a5a431c1..6b9df2c 100644
--- a/drivers/staging/media/av7110/av7110.c
+++ b/drivers/staging/media/av7110/av7110.c
@@ -2553,9 +2553,9 @@ static int av7110_attach(struct saa7146_dev* dev,
           * use 0x03 to track RPS1 interrupts - increase by 1 every 
gpio3 is toggled
           * use 0x15 to track VPE  interrupts - increase by 1 every 
vpeirq() is called
           */
-        saa7146_write(dev, EC1SSR, (0x03<<2) | 3 );
+        saa7146_write(dev, EC1SSR, (0x03<<2) | 3);
          /* set event counter 1 threshold to maximum allowed value       
  (rEC p55) */
-        saa7146_write(dev, ECT1R,  0x3fff );
+        saa7146_write(dev, ECT1R,  0x3fff);
  #endif
          /* Setup BUDGETPATCH MAIN RPS1 "program" (p35) */
          count = 0;
@@ -2596,7 +2596,7 @@ static int av7110_attach(struct saa7146_dev* dev,
           * then RPS_THRESH1 should be set to trigger
           * every TS_HEIGHT (512) lines.
           */
-        saa7146_write(dev, RPS_THRESH1, (TS_HEIGHT*1) | MASK_12 );
+        saa7146_write(dev, RPS_THRESH1, (TS_HEIGHT*1) | MASK_12);

          /* Enable RPS1                                                  
(rFC p33) */
          saa7146_write(dev, MC1, (MASK_13 | MASK_29));
