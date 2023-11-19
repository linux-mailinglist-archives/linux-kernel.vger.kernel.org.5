Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB52B7F0942
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjKSWDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjKSWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD5138
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B19F2C433C7;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431389;
        bh=gGycz/+AcGAOfjLuxskS9IFTadpo1yJk9mZ9pKitT+I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KeO3XDYitKm33W268vmkbrwUN3N8ImfdxhtPlMz0T0AR/tNCYYD+fZxi9DcfD+Ruz
         RJ1beQqahECXSY791bi1wy2oeU5JEyGyM1xw8xo9x7TqlfbBH3x1amMtdcDmVcFA+e
         7Qmij2jeP6K9K4CikuSqIRHdkcE7e/3LhK9n/AgUK1CHuE45hlOjwFEwtDUkhEzr5Z
         cmbTIJV8CA+B+t2J4xY3QSz2Rav8dqzUEkWYj5qofb5YUzP9z+2htG/rRz3Oy7NYUb
         VPUziu9FsfGgXWAZl3nTPrJG4ODL+viCxqiWSZ/zufQQ0TwrSFa9UQyBdPsLU/BJIU
         l3se8gaShlAkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9568EC4316B;
        Sun, 19 Nov 2023 22:03:09 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231119124911.GBZVoER+18ZrR1geho@fat_crate.local>
References: <20231119124911.GBZVoER+18ZrR1geho@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231119124911.GBZVoER+18ZrR1geho@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.7_rc2
X-PR-Tracked-Commit-Id: c9bd1568d5462f4108417518ce1af7b924acfb6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f84f8232ed3bfb772dcf30d8a0acbb8ee7ffb73
Message-Id: <170043138960.9984.5573485622335050255.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Nov 2023 22:03:09 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Nov 2023 13:49:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.7_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f84f8232ed3bfb772dcf30d8a0acbb8ee7ffb73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
