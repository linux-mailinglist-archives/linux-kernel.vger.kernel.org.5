Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13C7DC361
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjJ3Xuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjJ3XuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3C110
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C349C43397;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709807;
        bh=KDVAe6SEQa/XzcKPhamSht99FDSy+JstROMyPf7bNwg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GYcAcMxt0K2ra00KpzihiSYM4XrvuFjTL+OJEqqRw6PWUv1bqwcKq/lUKGi8casMt
         z29ElO1BkzT3eDsYPhaqvhgUadFiJIW3NIxRXP4g1yPAc/34d3zHfBIAIUXWy43JU+
         VcL0Y/D7aw9jCTOAK6jJBRnjXzAc2G6uFu2f8DRN3aQZ3XZjhKkpwfkTJK2AlbM7XQ
         OwXFS+tVoFkK1bEn75lID3apsYDYkUyAuJVi9OHpGyRNZpJqZAtOXjoW0mLzF82jdI
         0cI8EgXqf5mvcVyN78m1StpR/IK3VN+RL1pNwE4JbdA7OqhR8Q3fEW6zLhDkLadGmM
         yuDkZvSMgJL6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51977EAB08C;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027110316.GCZTuY9A06lb8w49c9@fat_crate.local>
References: <20231027110316.GCZTuY9A06lb8w49c9@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027110316.GCZTuY9A06lb8w49c9@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_bugs_for_6.7_rc1
X-PR-Tracked-Commit-Id: 9d9c22cc444af01ce254872b729af26864c43a3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f84a52eef5c35b49947b132ddd9b79d6767469af
Message-Id: <169870980732.17163.1281094439853991668.pr-tracker-bot@kernel.org>
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

The pull request you sent on Fri, 27 Oct 2023 13:03:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_bugs_for_6.7_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f84a52eef5c35b49947b132ddd9b79d6767469af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
