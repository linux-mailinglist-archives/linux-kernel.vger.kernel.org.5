Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193B7C971D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjJNWuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjJNWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF69D8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 15:49:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17729C433C9;
        Sat, 14 Oct 2023 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697323795;
        bh=+Vx1D+MdiXMoZFqMtN41jGsgfI3tTgPCZCyYa4UKjOU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hDB1qN9bc0V2NFrV2FLLm5BllgNDQ2oB1QQW6RaGTMijLcjBIWCEWvWFJ+A3hO9Ws
         fZegUh30dAUxHdgwXKBrlXTPlGkoCuxVEd0lMK4idvfY74UpBE+ERZI6PpHPkLswkM
         J0xR91rKU5xGXgoY9sWsQ83XMdEZGArfmGIzG5xDzkcw3Asl1gUg60JhNndb1gqDx8
         jDPs0gTdw0lnQVvNz5DOZhpMjjlK9Z6M4kJGjOLItFHf8gIwukktmB70foVO0M9TFV
         DWT+zhIP+PdB0Qp3Usr+qgTa0iOBalUaOgdmuW/UhQ1dusoCa52konJAJ0nAEEQH+e
         KKsjkrRdWVA6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F31A1C1614E;
        Sat, 14 Oct 2023 22:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSsRUR7nXpY7lAWM@gmail.com>
References: <ZSsRUR7nXpY7lAWM@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSsRUR7nXpY7lAWM@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-15
X-PR-Tracked-Commit-Id: d35652a5fc9944784f6f50a5c979518ff8dacf61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc9b2e683bcba017588b9aaad80f442ad004a48f
Message-Id: <169732379499.22000.15450451132129392004.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Oct 2023 22:49:54 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Oct 2023 00:08:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc9b2e683bcba017588b9aaad80f442ad004a48f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
