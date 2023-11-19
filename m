Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520587F0944
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjKSWDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjKSWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597B13A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:03:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23CE8C43395;
        Sun, 19 Nov 2023 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700431390;
        bh=ZXx/OMFXNDEvaI+5vdNhpy5zobLoExSj4ewLTWhVQPU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J6iJ21mhn9QpiDB46T52crBPzLXHHhNInGIR3g5oNdJXRxw2zYQ1jX7Rl1JRd8fn/
         d+9fKrYX7PqUiG+f33QcnizNUydqjisPuAZue4MNLEiELhlWKyxP4QAYUkaAoYWZM8
         KMGPET1GduU2vkyTn5bOzUCBG0Bur7J0Ob4tUWRYNvXfWxgMxiIX31s+4++U9Y53a5
         olGUSBXyskUUtLadkCRaeG3e5afy1aBB6F1xTl+HXE+laKhbl4mXGgSb3H/C4qteIp
         9Fsjvla1OMowhBiuJvcKVT7/ttpccHf4MShbzNgT+An0m72v+D4Q0WWN5vM5qmuf2e
         3ShNCutjXqJCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12F7EC4316B;
        Sun, 19 Nov 2023 22:03:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231119131543.GEZVoKf4zenbDfcTG6@fat_crate.local>
References: <20231119131543.GEZVoKf4zenbDfcTG6@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231119131543.GEZVoKf4zenbDfcTG6@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.7_rc2
X-PR-Tracked-Commit-Id: ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd557bc0a2d0f36c41b6040c27f31da5c5b76f49
Message-Id: <170043139007.9984.536328967580221257.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 19 Nov 2023 14:15:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.7_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd557bc0a2d0f36c41b6040c27f31da5c5b76f49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
