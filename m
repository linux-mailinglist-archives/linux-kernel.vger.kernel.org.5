Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381BF80F647
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377197AbjLLTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjLLTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:13:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB2FD5A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:13:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA342C433C8;
        Tue, 12 Dec 2023 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408417;
        bh=8/hLp1SyzouiwzvoUdUpcbUA5V2wQNYhhSq/i1K7OQc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kBBF/fBhYfvZkyvTksY8zrF8wk/ifyboa+M16bue92o1goq71JJaq34IdT4dtscDF
         w8H4wk74IaYxHcHcq4VnAzp94XRCJjPN6JN80i+YTnJmyJ2fdV8EY7ngwiJvrdIrsW
         cCcOaxH9PunwaYKdAO4e4R2tia7JSaKEAneo05LxonbWPUBqSwrpJagoMEidOcFL/K
         fY8RomOBlzcGF8OdbcZwmis+7cFISsVQZPfliAnCTgnFJvWe4x9lvF51b+3x5HRVv2
         1/5r2RNiYsjsVpj1umIhU0aRPd4tsrnYGM0W6xAb+5h4/eKo86wa15ZMsx/kZWeR5w
         OjvTKp3uQ0lFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8395DFC907;
        Tue, 12 Dec 2023 19:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 6.7-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
References: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpeguzG6EGi2FXspV-sQDrFkyf5umF6jHg3G=9XpWN95Bsug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.7-rc6
X-PR-Tracked-Commit-Id: 3f29f1c336c0e8a4bec52f1e5217f88835553e5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eaadbbaaff74ac9a7f84f412fbaac221a04896c1
Message-Id: <170240841774.26992.1629314593169004589.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Dec 2023 19:13:37 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Dec 2023 16:25:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eaadbbaaff74ac9a7f84f412fbaac221a04896c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
