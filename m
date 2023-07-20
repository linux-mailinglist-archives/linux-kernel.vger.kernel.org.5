Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9A75AAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGTJdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGTJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:32:53 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3F61B9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:27:35 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R66m50rbTzBRDsL
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:27:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1689845252; x=
        1692437253; bh=1X499CdxT5P1lqr15c+OF5JzFt+I0XrCS2YbFWWUkQk=; b=w
        jDACvxP3KWxBV5IT7e9BsiuF+sXlvhW4EvQkHPiLO/gCtVK9ef/tjBRMeCdEMzkQ
        UGojrmtc8G4lkCRH/urprfSV5WmhHHXl0O3x3jOYasQmp6e4rW+NawZmPyWgoTIf
        0tfrBZ/Mmt8Y1qu1BJcob673VV1FKzaon/rZZp1/9SNmr9cbDH+/NaD+oPeMx/xo
        Croh/qUUD+ya4lrrxYArSNy8/E+UOAb82stlaFhextRw3/6C67I55xJaihANDnjD
        s4oCPtA4GRqYX+Wk9UqTRVL0uiMYVSjiaoPHlt5UW5YmU/TlOf4YVq+/IG+mMBH0
        to5DnIjhy2Y2ayCJTfkXA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a6IpPnvOaE_R for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 17:27:32 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R66m46GppzBHXhQ;
        Thu, 20 Jul 2023 17:27:32 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 17:27:32 +0800
From:   zhangyongle001@208suo.com
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/q40: ERROR: that open brace { should be on the previous
 line
User-Agent: Roundcube Webmail
Message-ID: <ffeb8965fd61f1e9dc313e0f93884b27@208suo.com>
X-Sender: zhangyongle001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix onece occurrences of the checkpatch.pl error:

ERROR: that open brace { should be on the previous line

Signed-off-by: zhangyongle <zhangyongle001@208suo.com>
---
  arch/m68k/q40/config.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index c78ee709b458..54bb2388731d 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -146,8 +146,7 @@ static void q40_get_model(char *model)
  	sprintf(model, "Q40");
  }

-static unsigned int serports[] =
-{
+static unsigned int serports[] = {
  	0x3f8,0x2f8,0x3e8,0x2e8,0
  };

-- 
2.40.1

