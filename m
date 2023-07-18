Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D396E758230
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjGRQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjGRQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:33:27 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAAE124
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:33:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R54JM0YLVzBR1PW
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:33:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689698002; x=1692290003; bh=nA3GRmY9/RJ0ro40xfeW+19T8CU
        NNZdAf1PzP3UoOcI=; b=MFgaviVGz77zVPMVV34Gt8JBjM/dV6Dqka0dS61DQqy
        Osyb1oITaJ4rncVKHeQ7B9cur3m0lxX+cTJJjwucsXcMl8c4yzboiiVqYrgBAvIT
        0CLSnpVNs1zRJooPrgNuu68Yf65XiU1hAHzseFRpkKzKlRgNrcG9mmW0M7kT3Cqx
        Vt4UKOewQJhn6YygEGq41FPaSGuUhEn0SFYki9jqDxHLhDqpHmRvs4mnw/kZJlIr
        esGyahWkTrjoOjLxcL62YN548hpHDfXJAysKT1it8tGWQOu0r/Oxy+CQ0vyixtW/
        kpGelU7jlRhEqIwuSnRu95geZXY33l+jA8n+qfZNHOQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cgs9ZiXw7KjM for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:33:22 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R54JL64cQzBR1PQ;
        Wed, 19 Jul 2023 00:33:22 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:33:22 +0800
From:   pangzizhen001@208suo.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] include/asm: Fix comment typo
In-Reply-To: <0538c3e01d0991bc6bbca1aecca18044@208suo.com>
References: <20230712093011.17133-1-wangjianli@cdjrlc.com>
 <0538c3e01d0991bc6bbca1aecca18044@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <dccf64fe83278e44df6bff4de42cdca5@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  arch/arm/include/asm/unwind.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unwind.h 
b/arch/arm/include/asm/unwind.h
index d60b09a5acfc..a75da9a01f91 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@

  #ifndef __ASSEMBLY__

-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
  enum unwind_reason_code {
      URC_OK = 0,            /* operation completed successfully */
      URC_CONTINUE_UNWIND = 8,
