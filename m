Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A07F0946
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjKSWD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjKSWDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9825182
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E3A3C43391;
        Sun, 19 Nov 2023 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431390;
        bh=vXMa0sCs5I27qbJxLMwNWDYdeTZJEGwYORtaTKISIGI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u6SD5WlSVUwOqMPPQvYoEeM+Ay+RRr5qZM8dihFIYMG69mdFopBO0BSknJbTIfCr6
         9H09rlXLAvZWtMTIepCmi8sVoX7y0s/uxvam4WWeOCS7uGrHEx/9b0e/6IlPeH7n/v
         YQ/9iOYb/gKT6HqbF9hRsyiIOUjvF5a5Ba2EESvPmE52WLjeVL5kQu/gYuOkgD6Abr
         PjN0jaCk1cH2LV6tQvXRuK3Dr624fOKt9R9YwcGnum0y+K2VGwKScR9azbBd7Gi1T/
         FazAiNpWKu7eCOnxD+NCKgaqFbhwQT3W40Z8B9gCojCsRRoqYkPSW8SBKQC7+VQeJa
         Jlt7qRK0vU1+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D6E9E000A4;
        Sun, 19 Nov 2023 22:03:10 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATS=c2K7Ttg+Sb6gEmfUkrMbTQ0c62niOFzayzRF-rOdw@mail.gmail.com>
References: <CAK7LNATS=c2K7Ttg+Sb6gEmfUkrMbTQ0c62niOFzayzRF-rOdw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATS=c2K7Ttg+Sb6gEmfUkrMbTQ0c62niOFzayzRF-rOdw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.7
X-PR-Tracked-Commit-Id: ae1eff0349f2e908fc083630e8441ea6dc434dc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb3479bc23fafbc408558cd8450b35f07fad2a63
Message-Id: <170043139037.9984.17169970172856896609.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Nov 2023 22:03:10 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Nov 2023 02:01:14 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb3479bc23fafbc408558cd8450b35f07fad2a63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
