Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4E7F857D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjKXVaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjKXVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B145119B6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 580ACC433C7;
        Fri, 24 Nov 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700861419;
        bh=HeFQx2FN3WvgidPuhBPhPbsuPLGbfnhiT/CrdR5o0ck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KvnsXdcIxyIC6LfWJtsUceO1SlUqEEfrM4fpAHPi8BKYe8hv9ThUdBGrR3Rfxj8DY
         fiL9MSTRhexIbFfOifu3+Sk29/wOmkJHJAfc3a9YCCTQX53P25BjyfEpXcE3hGOT/h
         vMXTiH+CUoxdiOtyGpSdyUn4Kyz7oGPqntxwoh6ZeAAXELHzKumIM3ZrDgFo0PXiY1
         20BK9vKX8Xqden070/uLnyH5IE5dhC2/+s2HnWM254jb2aF7GzekSacKPejQIzuc1U
         L3meSpDpMCKjnRdBJTbcFOPW1wBRowwCR5pdCruiSLvHZfb0wr29EdpIxuqJ9jGdc6
         zoGBFcNKHe3og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42A5FC395FD;
        Fri, 24 Nov 2023 21:30:19 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWDeIR0PFAqvYgmU@tuxmaker.boeblingen.de.ibm.com>
References: <ZWDeIR0PFAqvYgmU@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWDeIR0PFAqvYgmU@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-3
X-PR-Tracked-Commit-Id: aab1f809d7540def24498e81347740a7239a74d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f5cc96c367f2e780eb492cc9cab84e3b2ca88da
Message-Id: <170086141926.5054.3986341951717587432.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 21:30:19 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Nov 2023 18:32:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f5cc96c367f2e780eb492cc9cab84e3b2ca88da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
