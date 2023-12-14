Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB521812ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjLNIuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjLNIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:50:06 -0500
X-Greylist: delayed 284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 00:50:07 PST
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E81B6;
        Thu, 14 Dec 2023 00:50:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F890E1D46;
        Thu, 14 Dec 2023 09:50:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1702543804; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=trzbikIGo5arUmckJbXd347gcgx8/VEEHHxuzDcGaco=;
        b=rXm+ddSLfz7BbOKdsA/hf80QJqEsJmnYszCyTdCgannIj1StiwsvG+0yrBlZnM2m6XdsjV
        oewdZEhsIU+0i3KZjTY8LZ5exyqzFrB04n0cay8WhpmYfCzsDvFWj2PdUyOzoWdD3s/GrQ
        VaV1AgEI9I86xp1pnT32KdZKuqxkO1ntg0OE6moG2M5ZY/Of4jWLFIkn5EKXFCRZqpg28m
        gQ2VtIucU99P+t+wXbQbEGkTnXsOAS/Kn0Shl9xUXd4qQi5XHMbcne0ktHRg71b7RFPbqb
        1qGH+o7L6J5prmse/XGuAiYLRGIaXST6304HbE9GC5RqPj9yHcHqfBjb7O7OhQ==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.302-rt131-rc1
Date:   Thu, 14 Dec 2023 09:50:01 +0100
Message-ID: <20231214085002.9264-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.302-rt131-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2023-12-21.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.299-rt130:


Daniel Wagner (1):
  Linux 4.19.302-rt131

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0

