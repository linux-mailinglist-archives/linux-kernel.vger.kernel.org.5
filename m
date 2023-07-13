Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F56751A78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjGMHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjGMHzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:55:39 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 00:55:28 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1D2170E;
        Thu, 13 Jul 2023 00:55:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1606DE5A0;
        Thu, 13 Jul 2023 09:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1689234434; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=GKBVYJpSmfoLCuPfe168qbJEbjBAcNV+XFnUZ5B7gNY=;
        b=DuQ5rr8T+akZvwCZqiFmxR+OSw4dv2sPi1RA6SGDGh7k5HHUD0VGhxkVpIavCtyDPOLZhv
        PbOMgO4yhrNIEYm5r46XkFCfSoLDz1NMSBVw3rpLOTHP47DGbgMY1SLhiVhhZ9gAt0FcWU
        vZ48NuM/6hoqZeHgiMCyHwT4jy9CyEA/4xthXqsb1OO8yjTMzG+NkMy8YN4lIaEWzwem7m
        6CRhd8TCo674k76yZdqQTpFPQ8krUJuupoRbcvL/9TBAc1RCKOGUTKmTU/SWrU8WUQBZe/
        +yRWK29zzPyzEPrrwb/RfsEH8B1QwpnORM3pPMMoghFyrsmyhuNQquTIQPHm8w==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.288-rt126-rc1
Date:   Thu, 13 Jul 2023 09:47:06 +0200
Message-ID: <20230713074707.1188-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.288-rt126-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2023-07-20.

To build 4.19.288-rt126-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.288.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.288-rt126-rc1.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.284-rt125:


Daniel Wagner (1):
  Linux 4.19.288-rt126

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0

