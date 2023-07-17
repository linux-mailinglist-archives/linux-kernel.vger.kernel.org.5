Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33E755D68
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGQHsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGQHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:48:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569DE72
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:48:39 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4DjK5NBDzBQHHf
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:48:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689580117; x=1692172118; bh=/kxYrL0++3dEyJqHWx6QwRYWm7Q
        FG+zYX+w+fV5AqNk=; b=Tj9LlB/xJxLVJGjDSPttfrSTE+gv7TXZZPCgImVqKOa
        WK2uyONDm/l7Adj3Vb7//rtmmE+u9c0uzxJo1qoZDyZboL5iTEb1fh2Cf/hLk7I4
        Txko/glcLry+TdKAQKtPlMMjKB9zrD3m0XmJgNppI3BtGBifdbUsXobgKcOX8XkW
        J43D/Oz1DqjMAiyq7Woa8tyLGV8csFKDELgzdvBsEM+V5mWLdxNs1nAAL09D1tZW
        bNgSERqZMdXHPbuHt8QtfEFgbzrupZ646e+i8oIEyfYc04QXUrryy33LnTewBvzF
        nrLHqdiZXB99qMw+ofZfP5Iti50m4fl+Rt/4liA1JqQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L727h0zSdN2c for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 15:48:37 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4DjK312czBHXgm;
        Mon, 17 Jul 2023 15:48:37 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:48:37 +0800
From:   hanyu001@208suo.com
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, liaochang1@huawei.com,
        heiko.stuebner@vrull.eu, conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: kernel: remove space before ')'
In-Reply-To: <tencent_6B88A6697F6AB7CEBD04EEABA52ACDC66909@qq.com>
References: <tencent_6B88A6697F6AB7CEBD04EEABA52ACDC66909@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8ef63e3296f5628896f373d696a078f8@208suo.com>
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

Fixes checkpatch errors:

riscv/kernel/probes:ERROR:space prohibited before that close parenthesis 
')'
riscv/kernel/probes:ERROR:space prohibited before that close parenthesis 
')'
riscv/kernel/probes:ERROR:space prohibited before that close parenthesis 
')'

Signed-off-by: ztt <1549089851@qq.com>
---
  arch/riscv/kernel/probes/simulate-insn.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/probes/simulate-insn.c 
b/arch/riscv/kernel/probes/simulate-insn.c
index 7441ac8a6843..60792c79b42e 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -128,10 +128,10 @@ bool __kprobes simulate_auipc(u32 opcode, unsigned 
long addr, struct pt_regs *re
      (((opcode) >> 12) & 0x7)

  #define branch_imm(opcode) \
-    (((((opcode) >>  8) & 0xf ) <<  1) | \
+    (((((opcode) >>  8) & 0xf) <<  1) | \
       ((((opcode) >> 25) & 0x3f) <<  5) | \
-     ((((opcode) >>  7) & 0x1 ) << 11) | \
-     ((((opcode) >> 31) & 0x1 ) << 12))
+     ((((opcode) >>  7) & 0x1) << 11) | \
+     ((((opcode) >> 31) & 0x1) << 12))

  #define branch_offset(opcode) \
      sign_extend32((branch_imm(opcode)), 12)
