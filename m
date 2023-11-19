Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD957F0940
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjKSWDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjKSWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66713E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5192AC4339A;
        Sun, 19 Nov 2023 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431390;
        bh=V7cTK9YpFSLljzPyOmVKzUabxeNxb+HqswmcS8xNBrM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jNGIfDdAOy4g0CwRsbCTmtZ36O+lUyaqixz3mY0tmFzAATu7QGacyqhUZ9aqC+yWM
         4Wo5fj/PvHwetoF0EjQRwx28ASYRQUdFAfQyveMHwdDuNvSR/2+3ZHJXAJ3hMWZgLl
         EXc1oFsuESRHab/FeFOEEjgS09ApYDf/Yru9aCxFnPQmAYGqUDus7i5vsp1AMQUNXB
         Tw1DZZDljJvqd3JlHU+G1PnIu6PnvzjOnXVFuUW3H7fYC5bcSHaFeckyvN5pgIfc1y
         xSVoLUxWNXtZwTD577Ag4DNPIW3J4mS18WSFXnxqxi1YqcqsOQPv+HjEb7Jmy5hOqG
         qDKCuD6z9y8AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E349C3274D;
        Sun, 19 Nov 2023 22:03:10 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231119140805.GAZVoWxXNTMoe+M/zD@fat_crate.local>
References: <20231119140805.GAZVoWxXNTMoe+M/zD@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231119140805.GAZVoWxXNTMoe+M/zD@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.7_rc2
X-PR-Tracked-Commit-Id: d3badb15613c14dd35d3495b1dde5c90fcd616dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46a29dd1462198e67bf939c32a2faf4e9bf9ac63
Message-Id: <170043139025.9984.486588030715883788.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Nov 2023 22:03:10 +0000
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

The pull request you sent on Sun, 19 Nov 2023 15:08:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.7_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46a29dd1462198e67bf939c32a2faf4e9bf9ac63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
