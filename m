Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99675786C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjGRJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjGRJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:49:06 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECF1171A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:49:02 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4vKm2R1lzBR1PF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:49:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689673740; x=1692265741; bh=TctDzT3+olxS6nLFPLTr5LbWtg7
        6T8LYhZ06EKd/PLQ=; b=iwXsN1BNAlju4Hudv35Whm8PobGEb/b+glPxZrfet6k
        gZpqxiSudO2IBfH2CO9kYr3uvIc+DlkRgf7FPPMdoR841l4ZOU6nfdXWFBEBXywy
        XhczobeD4g6cUCCvYPXKsn3U7CuKr5dgLe7F1Aw15Ts9gTDHgt7pAdy9ANhBvVj3
        VFvO06H7SybSqlgdME5W6qU2VmZsrJDAiL1HeRboV2MoSpVThKh42tf06m75+Eze
        kdzPo5mV41rh4DaSy0/xEVjb7REu4cVYkIHQ5e3o/NBV/RgFYo4jdsNrLMFZT2Kv
        rGuL2/dYzyQXXpG+PVW/l06wtPQcB7FIX1XhaNKoIEw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZMhc4Fl7Bq6d for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:49:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4vKl6WKqzBJBfd;
        Tue, 18 Jul 2023 17:48:59 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:48:59 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, windhl@126.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: powermac: insert space before the open parenthesis
 '('
In-Reply-To: <tencent_EA51887C68AF6A7DCE5504EAAB3F2AB5C609@qq.com>
References: <tencent_EA51887C68AF6A7DCE5504EAAB3F2AB5C609@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a475a9b5702e1044296209daec102e69@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch errors:

/platforms/powermac/low_i2c.c:55:ERROR: space required before the open 
parenthesis '('
/platforms/powermac/low_i2c.c:63:ERROR: space required before the open 
parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powermac/low_i2c.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c 
b/arch/powerpc/platforms/powermac/low_i2c.c
index 40f3aa432fba..25cc6eec962f 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -52,7 +52,7 @@
  #ifdef DEBUG
  #define DBG(x...) do {\
          printk(KERN_DEBUG "low_i2c:" x);    \
-    } while(0)
+    } while (0)
  #else
  #define DBG(x...)
  #endif
@@ -60,7 +60,7 @@
  #ifdef DEBUG_LOW
  #define DBG_LOW(x...) do {\
          printk(KERN_DEBUG "low_i2c:" x);    \
-    } while(0)
+    } while (0)
  #else
  #define DBG_LOW(x...)
  #endif
