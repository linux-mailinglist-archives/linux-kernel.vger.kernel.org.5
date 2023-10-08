Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619377BCF83
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjJHSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbjJHSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 14:06:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44486B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 11:06:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE00EC433CA;
        Sun,  8 Oct 2023 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696788416;
        bh=ysbu2pye3MfufdtIZ+g0XgubjBLzRlOY4l62MqCbHUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AEVmkop8grcIVrSdj1e+8JVnbEK8OWMjpJAoxek0hiMnZomMnzyZ8A7+pXo3mg+8G
         IMgBLCpHE5u0BxVruRLQ2ngx0XOgPUgGdY3kLxb4TBQ12mSlRNAic57ruGqz0GyYmV
         5+2OH3e0G80mq6diOiQjl/AY2RueuqdxsQf31Lqw3dxD7eLPLMcLzZxj012O8u3hN3
         Bb3AsNaC0Ou4FK4aFxRn6ihzteOPrT6euW1MIlgpzdvu+f/hwSLemFveoAvxxeIF/h
         qGPK09CwNshTdGq4HdQL9ngx6DiFpQBdgaZiBXfNHNHP2u9UBstIE2l+LpI2wA8UoY
         vwqayQih3Tzgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA5C6E632D1;
        Sun,  8 Oct 2023 18:06:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSJ5YIr3w5y24idY@gmail.com>
References: <ZSJ5YIr3w5y24idY@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSJ5YIr3w5y24idY@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-08
X-PR-Tracked-Commit-Id: 62d5e970d022ef4bde18948dd67247c3194384c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e20d344b53532adf60d77cb41873ebdb4f80cf4
Message-Id: <169678841675.1401.18284621874928312411.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Oct 2023 18:06:56 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Oct 2023 11:41:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e20d344b53532adf60d77cb41873ebdb4f80cf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
