Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712507B44E8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 03:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjJABs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 21:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjJABsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 21:48:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F6A6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 18:48:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2627EC433C8;
        Sun,  1 Oct 2023 01:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696124901;
        bh=TxVIg8c9NmhjqnLPr5DAIpKWgkE7C3POX/uj6Ymxydc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XD00uZQBfCMjnopDXmusQjBVrmHImfNSn4755SK4F4+9ipExkLAv1FZe5D6xNuAZi
         9FD4WfsPZc7Px7FlIC8HxGkVNiJtm1LDvnxtG+oND6/FAD7/nWq/dFQEl1+b9nS7kr
         88COJDJnxl2KfOtNFUvYq3yJ/yJ/DPDfXQ8XjgiM2/INhuM6sA7L/f6WdTsSPaXZHK
         NcOSVOl3Mu7QKZJSS5juq16jIvTkBVwzhuTFE4yQG4mcfocww2GTIBLWEvbIrr85d6
         neqtg2IUS8/Juy0skqRRgwL81Ee8BandooLpzodcHEIzaPeptp/9vwqNeYNLxXoyRG
         Fsig0iQ7H0yVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14131C43158;
        Sun,  1 Oct 2023 01:48:21 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230930164707.4d0e3c33@rorschach.local.home>
References: <20230930164707.4d0e3c33@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230930164707.4d0e3c33@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-rc3
X-PR-Tracked-Commit-Id: 2598bd3ca8dcf5bbca1161ee5b271b432398da37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b347e403210c63d0ba01adf7530da08bc2929f9
Message-Id: <169612490107.20680.9572114519959308003.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 01:48:21 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 16:47:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b347e403210c63d0ba01adf7530da08bc2929f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
