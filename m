Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906F7792CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjHKPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjHKPTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:19:21 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0630F4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:19:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5742EDACA6;
        Fri, 11 Aug 2023 17:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1691767148; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=GPpiLwd7DACg2qyPYTk2tLfOQ4uOlCKUsSZ9i8n1WjE=;
        b=BXfOlQvonEWIR9klK4GVpEIa00n1uVeGNV1+srUqdXIUq5KxOX53A9PRu+CI6AfEhY9Vog
        MRpohRF//GDpJCp2LopwxRqblzZ4zqWN2RnXQuHGau+i5j7QSzdQASsmn+SUPVeylk1uZN
        kiRBkR4Q0zAt1YpBuTDCCAnbhPaqSFyzSCrqvJAIcFRYo7Fy5P2EzYi0c7GovmlTaLXtnF
        pEhgJI7P6tXLh3i6Za5BuPrm4dVq6ZYu2xEHVzuFe0r5r+xZLiWjQ0tg62eZF7v0qIP0IL
        ButKxUoORcjGBrCgaz39c9xAvmXtSGrFdyk2d5SADF9SFFGIkfsbvJd0oaoCuA==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        <linux-rt-users@vger.kernel.org>, <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.291-rt127-rc1
Date:   Fri, 11 Aug 2023 17:19:03 +0200
Message-ID: <20230811151904.16196-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.291-rt127-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2023-08-18.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.288-rt126:


Daniel Wagner (1):
  Linux 4.19.291-rt127-rc1

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0

