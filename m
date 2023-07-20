Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660875A6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGTGmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGTGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:42:02 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2239D3A8C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:41:29 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R633J11HczBRDsM
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:40:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689835228; x=1692427229; bh=81G26k9hNAjf4shhHCVSfJDBLgY
        Z547gFCoUSjNeB0c=; b=LHuAnYJOzWDCA/da2pV5Qb0KjplMBIwHY8atuMTVyYG
        5eZEZoOCcKaET0CkCA+JynUb9w5stv+xJ29Dneq8ebToH6hqoFVWRpUzvr65NK+s
        WFUAKevoldzVPZrWVUbCJb4ewmDSsbl/fxdGdVGv5i9PP38OBOenjhSataA31viN
        Ff/4Hjthh52pXhYqqHN+QecAjYF/vVaOluxun1w0Yipvf0/iG3+2VgzPp3VJ8TI0
        hk0UFKt6KgckgLP18IuH31yRsCme+S5e+WR4MLHHa8fQRJ9ELdiK/7LCqSbtJUIY
        +w3T9YenJK2aP+3ugCTsS840hDgGn4aFld9K/tKhmIg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k8esYBGCSnBh for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:40:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R633H6TMDzBRDsD;
        Thu, 20 Jul 2023 14:40:27 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:40:27 +0800
From:   hanyu001@208suo.com
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: kernel: Add require space after that ','
In-Reply-To: <tencent_A984B205A9D93A7668CF1721A52EBA2B820A@qq.com>
References: <tencent_A984B205A9D93A7668CF1721A52EBA2B820A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <6a7de5f72aac9c6e71a5b484e7beb6b1@208suo.com>
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

./arch/parisc/kernel/unaligned.c:475: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:484: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:492: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:497: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:505: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:505: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:510: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:510: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:517: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:517: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:522: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:522: ERROR: space required after that 
',' (ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/parisc/kernel/unaligned.c | 16 ++++++++--------
  1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/parisc/kernel/unaligned.c 
b/arch/parisc/kernel/unaligned.c
index 752d0d0..3d346f2 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -472,7 +472,7 @@ void handle_unaligned(struct pt_regs *regs)
      case OPCODE_LDWA_I:
      case OPCODE_LDW_S:
      case OPCODE_LDWA_S:
-        ret = emulate_ldw(regs, R3(regs->iir),0);
+        ret = emulate_ldw(regs, R3(regs->iir), 0);
          break;

      case OPCODE_STH:
@@ -481,7 +481,7 @@ void handle_unaligned(struct pt_regs *regs)

      case OPCODE_STW:
      case OPCODE_STWA:
-        ret = emulate_stw(regs, R2(regs->iir),0);
+        ret = emulate_stw(regs, R2(regs->iir), 0);
          break;

  #ifdef CONFIG_64BIT
@@ -489,12 +489,12 @@ void handle_unaligned(struct pt_regs *regs)
      case OPCODE_LDDA_I:
      case OPCODE_LDD_S:
      case OPCODE_LDDA_S:
-        ret = emulate_ldd(regs, R3(regs->iir),0);
+        ret = emulate_ldd(regs, R3(regs->iir), 0);
          break;

      case OPCODE_STD:
      case OPCODE_STDA:
-        ret = emulate_std(regs, R2(regs->iir),0);
+        ret = emulate_std(regs, R2(regs->iir), 0);
          break;
  #endif

@@ -502,24 +502,24 @@ void handle_unaligned(struct pt_regs *regs)
      case OPCODE_FLDWS:
      case OPCODE_FLDWXR:
      case OPCODE_FLDWSR:
-        ret = emulate_ldw(regs,FR3(regs->iir),1);
+        ret = emulate_ldw(regs, FR3(regs->iir), 1);
          break;

      case OPCODE_FLDDX:
      case OPCODE_FLDDS:
-        ret = emulate_ldd(regs,R3(regs->iir),1);
+        ret = emulate_ldd(regs, R3(regs->iir), 1);
          break;

      case OPCODE_FSTWX:
      case OPCODE_FSTWS:
      case OPCODE_FSTWXR:
      case OPCODE_FSTWSR:
-        ret = emulate_stw(regs,FR3(regs->iir),1);
+        ret = emulate_stw(regs, FR3(regs->iir), 1);
          break;

      case OPCODE_FSTDX:
      case OPCODE_FSTDS:
-        ret = emulate_std(regs,R3(regs->iir),1);
+        ret = emulate_std(regs, R3(regs->iir), 1);
          break;

      case OPCODE_LDCD_I:
