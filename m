Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DB7DC43F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjJaCNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjJaCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04000F4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E44B2C433CD;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718351;
        bh=sKMAhczs/xw80mrlPP9O0wEd3k9oNwhK/C2cs0HVnGA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zcj6lj5FZbbVcHJyAHyruGjNoVKlitesjk+8t3z6GYLsPEzttNmedYoue/dMrGJkl
         o/biOK9Z2wRoblPWXkFyygdUIQ2fhxtuPHIUtilKSR22gT8c2Hrm9T+9JSNgF3n6Eo
         ReIiWx/2wnVtCgo+jbKYXTmWbjORQHDBtTTOsIL4m+5930spum9fo2NGxZPKn6lJU6
         ez82it5hEYEAec/ol9HLirweY8A6GPpk00l/Ko91Kb0vIFOF/vjvKenMxvtfrDIs3j
         ZXEkScdqTV1oCtri/4P9qUKV6Q7UhOfWxx6ci8snLVfHj4rUOE/KCOb0sw9x8CltaY
         balMJaVS7RGjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D33C9EAB08C;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/irq change for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0QC/LQKl4xNji/@gmail.com>
References: <ZT0QC/LQKl4xNji/@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0QC/LQKl4xNji/@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2023-10-28
X-PR-Tracked-Commit-Id: f44075ecafb726830e63d33fbca29413149eeeb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1641b9b04002c22f616a51a164c04b7f679d241f
Message-Id: <169871835186.5591.2868003587395665918.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 02:12:31 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 15:43:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1641b9b04002c22f616a51a164c04b7f679d241f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
