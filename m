Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA277DC35E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjJ3XuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbjJ3XuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCFCEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A780AC116B4;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709807;
        bh=cF9CAg8PZjSD1N/wQqAZxp91W5DZzmcyJzLCCJiiv6U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LuFeiZm9m88TP3jWKLAoy3dXVDfhoki+DVOA+PpXVpYBcGb4bjXiRayYV0Gxwa9GH
         9a9QWlXZcjYOE053qu/Cfn/FHzbsHyg6u1tO1I2X050MvDszjKRQ53iKYOLOSM5mud
         qRUT66Lwpoiy0ZrNnVVhqvuha9jWMQ6SsxAJ4fYNQdux5v7yuFZjO7iYuNugoBGqAC
         Lr30yVodPbEonUWXqpMqKPh6PUYuNfmKzIalRutcsJmRDQLSom630VaFz7yVNcjysT
         NMLGurYiP0v8Ydlee1W+Wh+UKyvq7BvgM6qhtSxT+0ZvEO+45UPVsq4X1kuzrtmoEW
         XmnnhMavZwBGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BD05EAB08B;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027170151.GOZTvs/wR/47ib4+qe@fat_crate.local>
References: <20231027170151.GOZTvs/wR/47ib4+qe@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027170151.GOZTvs/wR/47ib4+qe@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_6.7_rc1
X-PR-Tracked-Commit-Id: b5034c63858d8cb44587bb1ce5a0790a1b4e4a05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca2e9c3beec67dc90944f3d2a72f77652fb9cefc
Message-Id: <169870980756.17163.3473492276184968328.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 19:01:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_6.7_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca2e9c3beec67dc90944f3d2a72f77652fb9cefc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
