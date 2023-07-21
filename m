Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3575C329
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGUJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGUJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:38:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD55F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:38:03 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6kxg6jWJzBR1P0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:37:59 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689932279; x=1692524280; bh=s6hrHq+4i66w2AiBgRCGMJw/RnQ
        ClA/Vxds/eXz/JfQ=; b=EK4nNgoRUS9mUW6LQ/ze1Q/ITykCUHM2iLZOqFxrsXh
        29x0uieOSUDXifqD3HjIdMPUuzcsqypkQpw/TxKwwObSJAcWn9NHA8A19Htm7NQg
        AeeoW5nt2GO4ZVbI69UgEp8lWa4JOHpYi6fDRHlWFDws8Aqkgx/V+XAG5fA0hZAH
        njRa0ubSNmLoaMtbfU2Nma68HVMMg0HAvWrvOTQHaFxD4W7ivVqhTif5ZYuIyjF+
        CBygfOgFNnGJLoekCHCifIW84IBFBwdwh04mtzv28OFl0TrQe48hiwluhiuX4xgC
        dA/N3sCgm6x9Pw0Ih3WbZqvul6bw7gO95rbmcJ8HPXw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gun16MXUPJbZ for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 17:37:59 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6kxg4nDnzBHXgs;
        Fri, 21 Jul 2023 17:37:59 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 17:37:59 +0800
From:   hanyu001@208suo.com
To:     stf_xl@wp.pl, helmut.schaa@googlemail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wireless: ralink: rt2x00: Remove unnecessary spaces
In-Reply-To: <tencent_0AFA418AB6A31D66F3B0481E8BC58A70A108@qq.com>
References: <tencent_0AFA418AB6A31D66F3B0481E8BC58A70A108@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <c0f897b57f6b05d26f2c006154fa15ed@208suo.com>
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

Fix checkpatch warnings:

./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:168: ERROR: space 
prohibited after that open parenthesis '('
./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:168: ERROR: space 
prohibited before that close parenthesis ')'
./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:169: ERROR: space 
prohibited after that open parenthesis '('
./drivers/net/wireless/ralink/rt2x00/rt2x00reg.h:169: ERROR: space 
prohibited before that close parenthesis ')'

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/net/wireless/ralink/rt2x00/rt2x00reg.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00reg.h 
b/drivers/net/wireless/ralink/rt2x00/rt2x00reg.h
index ffe802b..0e5094a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00reg.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00reg.h
@@ -165,8 +165,8 @@ struct rt2x00_field32 {
   * Note that we cannot use the is_power_of_2() function since this
   * check must be done at compile-time.
   */
-#define is_power_of_two(x)    ( !((x) & ((x)-1)) )
-#define low_bit_mask(x)        ( ((x)-1) & ~(x) )
+#define is_power_of_two(x)    (!((x) & ((x)-1)))
+#define low_bit_mask(x)        (((x)-1) & ~(x))
  #define is_valid_mask(x)    is_power_of_two(1LU + (x) + 
low_bit_mask(x))

  /*
