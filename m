Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433C7DFE14
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjKCCUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjKCCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:20:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728361A6;
        Thu,  2 Nov 2023 19:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B5B1C433C9;
        Fri,  3 Nov 2023 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698978027;
        bh=2QYrDimbfgdF4tvctZJ6gNsT+lng5gPd+SVEQw29VBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dwk8TVoSyLjQK3wcvDoRO1HgowgZBwuqLDcTiT/q4ZH3GWOZjoGK64M3plRCgn1Cb
         CfnY7RQO+yLx63aIkuxDF59S8eHjSC+6+J6jeEypXHrxXXiRltRtQal7rU65IIo08q
         Og2p52ACXsDHXCWdsSy37MWYQn4j0PJixRaufMfTmHaNfYRCGOg/1nQ01qXx3zWATu
         ieR+Lp88LTv4GtuKlzmcJV8x+kGlfzEiJc5tVRrV+3d5Bi917n4d5qUnLIsTsaI3Ck
         Irfq3QO3S7g0baJnvlULxN9ArjidttGvgXGlc4QcjuWK3UUgn5f1aRl2EzNR8cVOEY
         G0//F8irkxcRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9344C43168;
        Fri,  3 Nov 2023 02:20:26 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <72eadf93a7b7d70ad47b72b6a70bc5f2a62e6ae8.camel@physik.fu-berlin.de>
References: <72eadf93a7b7d70ad47b72b6a70bc5f2a62e6ae8.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <72eadf93a7b7d70ad47b72b6a70bc5f2a62e6ae8.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.7-tag1
X-PR-Tracked-Commit-Id: 63f1ee206170ad2363aa25fd99bd5ae529c690ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5be9911406ada8fe6187db7ce402f7ff4c21ebdf
Message-Id: <169897802695.29625.7093146712728880240.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 02:20:26 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 Nov 2023 17:11:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.7-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5be9911406ada8fe6187db7ce402f7ff4c21ebdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
