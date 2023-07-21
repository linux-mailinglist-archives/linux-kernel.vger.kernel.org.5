Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC975BB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGUAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:32:01 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4147E0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:31:59 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6Vqd4Qb6zBRDst
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:31:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689899517; x=
        1692491518; bh=MWoGDdiztOjUGuFbuEqKYbtLTB1P209Y8QkCjJFsz+8=; b=1
        RVJMTw4vC7EOtA5OoYvgwquUE/ozQMB/Lhn/uEHfqPWb5IGGlgkRWlwsu+3nq4K6
        ZGpIEkLpNSJSjPm3wb12Npbzmzz9AyK2IW4wLBtaMR7yq1mW8O4HtQIi/wIuavx8
        HlmHiCmD7xtC4mejRxcXsptDY4SIdEWoHBoO1VryjiG/RVIGiumAuuIRwQJ7Rp0l
        dy4w35ZFA9amQAPh/Iz/3lcewgWGQ4gtg+sY0On0ZdevoiMDmBFc4dB459KTbQnC
        d16lGJS1gBB1MRcFqfDnjaXxCE6LH7Jo2jZNb21/IjDPyGUjzFOnxkE91uymo6Cx
        Gj+mIVqGvhA4N+DFdmlEA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WkmJ49qmLgpP for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 08:31:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6Vqd1tyYzBJqBP;
        Fri, 21 Jul 2023 08:31:57 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:31:57 +0800
From:   zhangyongle001@208suo.com
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh/boards/mach-ap325rxa: ERROR: that open brace { should be
 on the previous line
User-Agent: Roundcube Webmail
Message-ID: <b8c0d283ca1f9b299122d58f51a0d8c2@208suo.com>
X-Sender: zhangyongle001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:
ERROR: that open brace { should be on the previous line

Signed-off-by: zhangyongle <zhangyongle001@208suo.com>
---
  arch/sh/boards/mach-ap325rxa/setup.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c 
b/arch/sh/boards/mach-ap325rxa/setup.c
index 151792162152..45a5ffc5a216 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -305,8 +305,7 @@ static struct platform_device ap325rxa_ceu_device = 
{
  };

  /* Fixed 3.3V regulators to be used by SDHI0, SDHI1 */
-static struct regulator_consumer_supply fixed3v3_power_consumers[] =
-{
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
  	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
  	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
  	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
-- 
2.40.1

