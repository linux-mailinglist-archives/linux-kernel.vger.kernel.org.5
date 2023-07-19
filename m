Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B750759AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGSQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGSQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:35:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887FA2116
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:35:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5W9D5gfPzBRDr9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:43:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689759824; x=1692351825; bh=yaRaGHcnBkbORd6IN9IHydHnSCp
        1BEf0fgBlVh76Vrs=; b=QmJ746LcdjAlU4uS1K1J4omBm1jsy0Ayc+4KObm3b/C
        eYSexvHjjsW0Z8AEYp/2Wd4crsOj/RijeLsn1+YlBYncRcgCIuOra64giYufZY8N
        qPT+GFPkY+Xl7P7Iqld6zV7my4lgEa53VeIvP1kypk/FvVEucwq+sxQPq+f2Bpuf
        KA89kASNI/4IL2z2RzLKgo6sx6ZoVNwkqEH5WVUNEUP+dQwk14wFOxHT0iapWjbL
        JntZh2WKYV4TF/MrrCZIRbsmi3IF7BKKzzB2bFCrOfO2b59gqTJES53u3ob8P1Mw
        sIphwYhl7Z3g8YL6iR0Wql7yAb7Yhq0DUkm/kcBD6UQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ofwJJFgSi33k for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:43:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5W9D4J8JzBR9tV;
        Wed, 19 Jul 2023 17:43:44 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:43:44 +0800
From:   hanyu001@208suo.com
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] abiv2: inc: abi: add require space around that ','
In-Reply-To: <tencent_31290484AAC72A43C64D89F468636B75CF09@qq.com>
References: <tencent_31290484AAC72A43C64D89F468636B75CF09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ae522198c5e2e1a9d1a289c5b07f6047@208suo.com>
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

Fix below checkpatch errors:

./arch/csky/abiv2/inc/abi/entry.h:288: ERROR: spaces required around 
that ':' (ctx:VxE)
./arch/csky/abiv2/inc/abi/entry.h:297: ERROR: spaces required around 
that ':' (ctx:VxE)
./arch/csky/abiv2/inc/abi/entry.h:312: ERROR: spaces required around 
that ':' (ctx:VxE)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/csky/abiv2/inc/abi/entry.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h 
b/arch/csky/abiv2/inc/abi/entry.h
index cca63e699b58..704724154a87 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -285,7 +285,7 @@
      mtcr    r8, cr<8, 15> /* Set MCIR to write TLB */

      br    2f
-1:
+1 :
      /*
       * MMU on: use origin MSA value from bootloader
       *
@@ -294,7 +294,7 @@
       *   BA     Reserved  SH  WA  B   SO SEC  C   D   V
       */
      mfcr    r6, MSA_SET /* Get MSA */
-2:
+2 :
      lsri    r6, 29
      lsli    r6, 29
      addi    r6, 0x1ce
@@ -309,6 +309,6 @@
      mtcr    r6, cr18

      jmpi    3f /* jump to va */
-3:
+3 :
  .endm
  #endif /* __ASM_CSKY_ENTRY_H */
