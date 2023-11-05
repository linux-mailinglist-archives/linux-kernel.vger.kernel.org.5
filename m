Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE57E15ED
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjKESxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjKESxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8BCDD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:53:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB229C433C9;
        Sun,  5 Nov 2023 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699210419;
        bh=8MWsJqdVgjuSYyPM7c1t6bp0LvdXVgfqfNodNjUqYbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j5df6uK6Rt87ENdj+d4LY2O+heiqHA2/EdI/7/wEvHDjB2sZXv2ZeUi8tZ2Qa6kcQ
         xaFNCO0St2UR5Y9zukYzqN93E25CM3I7+G6IRftIyR6+bAxFMR4Tqak8j9OwO7O04t
         KBMjDhlJM3A2ipQHfaFF+cySuRrjGqq6i7cmW3ucZayjje3gLQZ1WqkwceW+8xmuXd
         LX76PjDanLfwCH5JCkZFEibgxNzLwnMJoWdm3ejB5Aa1GP41P70JocgauNXACMMf/W
         F+OyVAm/vfwYKEFjoOXRCqPonPI8otyhHd7gQYfZxa5ZaVJ+JtCzkhVd3WkxiA7Z0W
         0Bh+ui6wR+pLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B31A7E00086;
        Sun,  5 Nov 2023 18:53:39 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231105144852.GA165906@workstation.local>
References: <20231105144852.GA165906@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231105144852.GA165906@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.7
X-PR-Tracked-Commit-Id: c12d7aa7ffa4c61443241fbc1ee405acf4aa17de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cfb751165ef685b80635218beff38d6afbce4e2
Message-Id: <169921041972.20864.13809135649355568466.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 18:53:39 +0000
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Nov 2023 23:48:52 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cfb751165ef685b80635218beff38d6afbce4e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
