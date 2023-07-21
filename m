Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2675C1C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGUIeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjGUIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:34:02 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111692D60
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:34:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6jWn5jhKzBRRLC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:33:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689928437; x=1692520438; bh=2GQrqP0A6vo5l/H7gdVYrs/ulVc
        Sw7nNmu9MTpTLmQQ=; b=rxmCapbWAV38x3oZMmnleQNUN0gXf4VjL6y8UguMTD3
        dql6h7g9GQqhoG2sqhICj9z33NAHWvf4k31EfABCj4dhgT4Lgwq5XnCq/1JuGjOa
        QjLVW+SxP9udSUDMcKwACKQNARomvmKtMIcKUQ3nAdZrQXWryld3cKs2fYvavx3p
        QrCsyQmwjHEWD7TXz9JQ7HqmZLXe+ztD7BGyYGaASvlBTsc/nCTsyMW3RbEhFpT/
        x1dlr6QnySkwPFawmOCVz3fyzy2USyQuySP35kPQOB+6b8HqkOTjmtvCY84uBjye
        QR491ulvRR8HtDLHPWaZRovw+VN7leeM9ozScfyF8DQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pXnIcewwl5E7 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:33:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6jWn4PmNzBJnMj;
        Fri, 21 Jul 2023 16:33:57 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 16:33:57 +0800
From:   hanyu001@208suo.com
To:     daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mach-pxa: add require space after that ','
In-Reply-To: <tencent_05B568A5C378391102ED44ADD539AC404F06@qq.com>
References: <tencent_05B568A5C378391102ED44ADD539AC404F06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f57f7072cfaccc6aad71c2d29c4c21c7@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below checkpatch errors:

./arch/arm/mach-pxa/generic.h:18: ERROR: space required after that ',' 
(ctx:VxV)
./arch/arm/mach-pxa/generic.h:18: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/arm/mach-pxa/generic.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index c9c2c46ecead..3775201229ab 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -15,7 +15,7 @@ extern void __init pxa_dt_irq_init(int (*fn)(struct 
irq_data *,
  extern void __init pxa_map_io(void);
  extern void pxa_timer_init(void);

-#define SET_BANK(__nr,__start,__size) \
+#define SET_BANK(__nr, __start, __size) \
      mi->bank[__nr].start = (__start), \
      mi->bank[__nr].size = (__size)
