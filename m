Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74305792FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjIEUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjIEUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:15:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66688E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:14:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 065F0C433BF;
        Tue,  5 Sep 2023 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693944842;
        bh=QqBmefe/G4tiF0x0RfuchpxM6KA27P7L6VGkggK7CpE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VPtErLJZCaRUCvW9QuHM65y3cdLJyLpzvFgCYyr8vxEepEMFwvFaQPoK4kLXGAvWa
         utKZ5hbu3TJt1KliMe4gkKlDwEAM/5bI8pdhR5a2a9o+9oKvM+FmVjOCbtVXpuKPME
         YmCG5064+Ezi/nXLwu9yF4ob2qfP+jvI8WJH/uLhVKTI8fBtLtjabAoXyU3pumQZfr
         SFXdLPNbh3EqogtBY/LKo8VRh21VkG8STaswi6iKtZJtqOXzzjawIbopb2bWBkwVye
         UqFaTczBG7KZ0F2uoEGjRX5UgSB1ANvwRwUPtVqLNItXGTi73V8phJDgA511vb6IXO
         VFo3uxetUTrug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7F09C04E24;
        Tue,  5 Sep 2023 20:14:01 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230905161246.2042842-1-agruenba@redhat.com>
References: <20230905161246.2042842-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230905161246.2042842-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.5-rc5-fixes
X-PR-Tracked-Commit-Id: 2938fd750e8b73a6dac4d9339fb6f7f1cd624a2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
Message-Id: <169394484194.28658.6576619504433985005.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 20:14:01 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, gfs2@lists.linux.dev,
        David Teigland <teigland@redhat.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  5 Sep 2023 18:12:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.5-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
