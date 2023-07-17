Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E2755E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjGQIQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGQIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:15:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4DDE7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:15:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4FJg6cYQzBQt25
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689581747; x=1692173748; bh=ozlsgD8cLIItEKumH0yEkzP4K76
        ts4okNGENiCozKNc=; b=dxqv1soy4plHkm0LxyT0EH3st42PDXPQexG/MQ7Mcg9
        QGNq4i0SaIwIAt9oeHw6+5W+mc2PUVFpiLsmE+rG4uxlzZbZexaKuR6vAdDf+Dgi
        U5HBi78L74e10q0FMIwZRY9DjoZlDvbd7G9A5hZUTRTBREFHekxXVGxM5Bopj2gg
        CptquSoDnv0huhX0SP73w+mg62F2CWj8464odQ2uEHniOUpQU2IKUgC1FDXoKvR1
        llgLO6RTrS3LmCkA1v00BLgDp0/jXGqWyT9jeIJ8mRD+mz/3q7xAT5CQp48rWhZ1
        rTfupLy5h6T8TNsmpi+5BcRss7krkikMnOmDdSYfXrQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BX4CAZFXMMR8 for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 16:15:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4FJg3KWczBQt1h;
        Mon, 17 Jul 2023 16:15:47 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 16:15:47 +0800
From:   hanyu001@208suo.com
To:     toke@toke.dk, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] taging: fbtft: Add space around '='
In-Reply-To: <tencent_1D773A0CE6639082173515B942C9821A6D09@qq.com>
References: <tencent_1D773A0CE6639082173515B942C9821A6D09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a8b204f8562cb5d4ad837f6df0c14b74@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

./drivers/staging/media/av7110/dvb_filter.c:105: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/staging/media/av7110/dvb_filter.c:106: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/staging/media/av7110/dvb_filter.c:108: ERROR: spaces required 
around that '=' (ctx:VxV)
./drivers/staging/media/av7110/dvb_filter.c:112: ERROR: spaces required 
around that '=' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/staging/media/av7110/dvb_filter.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/av7110/dvb_filter.c 
b/drivers/staging/media/av7110/dvb_filter.c
index 8c2eca5..014fa1f 100644
--- a/drivers/staging/media/av7110/dvb_filter.c
+++ b/drivers/staging/media/av7110/dvb_filter.c
@@ -102,14 +102,14 @@ int dvb_filter_pes2ts(struct dvb_filter_pes2ts 
*p2ts, unsigned char *pes,
      }
      if (!len)
          return 0;
-    buf[3]=0x30|((p2ts->cc++)&0x0f);
-    rest=183-len;
+    buf[3] = 0x30|((p2ts->cc++)&0x0f);
+    rest = 183-len;
      if (rest) {
-        buf[5]=0x00;
+        buf[5] = 0x00;
          if (rest-1)
              memset(buf+6, 0xff, rest-1);
      }
-    buf[4]=rest;
+    buf[4] = rest;
      memcpy(buf+5+rest, pes, len);
      return p2ts->cb(p2ts->priv, buf);
  }
