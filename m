Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813F07DC50A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbjJaDxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjJaDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041EE8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39E6BC43397;
        Tue, 31 Oct 2023 03:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698724345;
        bh=LGKnxkZ1/BZcPzbAp2y/DfweDWTjLf94lgjRJURbZeU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JtkOvrPdVO8St+2c0yYO11NBXonflWohwCdlPOf1hJPkgy2dif671ebtkD8i7FAeH
         zucVgnc2IVqc/xL3WzHsCkirR1ilUKurTtTHuNGf/N5D63NsEE8/4OTfLHQlWlZ2un
         +EwIS8UPMEw4zbYp9CHQ+Y3lFL89mw3yt3GoSCqs4oeiH2JjochzPQ4QlS8LrezFKi
         btT1iqac+pM54JFg3jPaKtBf7FB1Kq9hlSlMReBRpnlrSiWlCGrxF1g6wYPg5HiUzi
         MgS9381ig8OC9/6maJ1HEQc/BbTBJ5p9YgRaKRifQyla47lONbmm70G1Ln/7rmaSGl
         uBGck90H0NBFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 264C4C3959F;
        Tue, 31 Oct 2023 03:52:25 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169861501181.181063.11456638002426777407.tglx@xen13>
References: <169861500709.181063.7816209662289132093.tglx@xen13> <169861501181.181063.11456638002426777407.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169861501181.181063.11456638002426777407.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-10-29-v2
X-PR-Tracked-Commit-Id: f4febfdbb45ad2322a508d3d650b3af7c8286cb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63a3f11975997e0851b108b49d7b5f4e84a18d08
Message-Id: <169872434515.24385.6721285658378781189.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 03:52:25 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Oct 2023 22:33:29 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023-10-29-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63a3f11975997e0851b108b49d7b5f4e84a18d08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
