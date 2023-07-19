Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88D759AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjGSQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGSQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:36:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1622108
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:36:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5hJ62G4szBJDft
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:35:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689784516; x=1692376517; bh=5pj+9SB9XL67KdC10MygRAqL6Th
        a9QqQRVIGmyiPYck=; b=zatPMWo9c6HCa6Ibehg4uJ4yjA8Odd6r/SbN7CBRpwz
        3NwMRUW1tjWGr9IOZwuT1XCx8Vsz2EAr/DbWal+C2FKyCGksZsHhcdcytXnM5LuK
        +IgzV6QYOOM5oy2PIIXQ6vzievg9td1DxbOcTsgH4VBD2hXhV29N2VU/1nqZvzAX
        aom+BvLoKUOEM+hH3BvZbQbc30xKPY7K+rOi534TMvT5iTUG8GTEeCag0kblQaH3
        3WGsixL8xv5BQn8AZX1/YKA8L3tOvAZo/1KAFmUVkFJYtgJIIy03UU5s69xXrc2D
        qJ6MwZJp0Eu8rcTrLxSU3IfqYiMjKtVrZdOvw2aU8Tw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id inxQ71wot0sJ for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 00:35:16 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5TyL4PZHzBHXhP;
        Wed, 19 Jul 2023 16:49:14 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 16:49:14 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: powermac: Add require space after that ','
In-Reply-To: <tencent_D88DA71125D0DAD5369DE30A8055B355A20A@qq.com>
References: <tencent_D88DA71125D0DAD5369DE30A8055B355A20A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <96c612b1e07dfde74413322609dfc4fe@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below checkpatch errors:

platforms/powermac/pfunc_core.c:22: ERROR: space required after that ',' 
(ctx:VxV)
platforms/powermac/pfunc_core.c:22: ERROR: space required after that ',' 
(ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powermac/pfunc_core.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c 
b/arch/powerpc/platforms/powermac/pfunc_core.c
index 22741ddfd5b2..07555c1bb484 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -19,7 +19,7 @@
  /* Debug */
  #define LOG_PARSE(fmt...)
  #define LOG_ERROR(fmt...)    printk(fmt)
-#define LOG_BLOB(t,b,c)
+#define LOG_BLOB(t, b, c)

  #undef DEBUG
  #ifdef DEBUG
