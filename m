Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136DD7ABA71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIVUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjIVUTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:19:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31119E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:19:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC4B0C433CC;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695413948;
        bh=/4p0T6R1jZ1F85q9CoEPjaOJY1jyfMjV/m6bNDmq2+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gz8skoFvVEmHjOe11mDSYfTVQ/7ixy8SFjSsicb1c1azJwZMBH619W8R89Q5jxVRj
         FWxEsLuOQZx8tWMawPTZw6JL4juTO4Klbq8ozKp1ggvZoY4t27E/Sfo+sHxDHJ/wgo
         ZyFn8h/WiYolHkOCnWqDc5qZsrNqczHP6W3QxVVBqMIwACz1l501b7z1IpQ31txofA
         AlWKZYEENo/8fv0Jt8Oe3xUjy7gRHuUZvxhIS37kzL2txgOgRBjMhQy5eHkQzA+u92
         GKW3byPORvpB1KwiSmK9HZYotq7HilQobXRR7+974VvBabHh/YXY7gDeGP3fw+9Pws
         z+6kT6JJ40Z0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5C6AE11F40;
        Fri, 22 Sep 2023 20:19:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQ1tbDIt+a6viYFc@gmail.com>
References: <ZQ1tbDIt+a6viYFc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQ1tbDIt+a6viYFc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-22
X-PR-Tracked-Commit-Id: 509ff51ee652c41a277c2b439aea01a8f56a27b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e583bffeb8bc3a7b64455b14376afd5fad71d62f
Message-Id: <169541394874.8311.7801803615186275646.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 20:19:08 +0000
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

The pull request you sent on Fri, 22 Sep 2023 12:33:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e583bffeb8bc3a7b64455b14376afd5fad71d62f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
