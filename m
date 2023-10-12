Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05217C788C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442974AbjJLVVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442963AbjJLVVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:21:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E919D;
        Thu, 12 Oct 2023 14:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14693C433C8;
        Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697145674;
        bh=t5gVVvn1Bsrtb0z48FQIQt0g4MhtMigapUadB185Lmc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n7aUNijtFtt31Id2OI/UzoltFF+htnWREUMb9fHuJ7khY08RNmujlUgkvTjgIYMJu
         sn5PiMYBYqedJRj7j6xEblysQ4NQnICZG+aEWN0dNo/BCIwTy7V0pgUXwHrNuZLM1z
         AIAdmdFXFJPSpIh0pkCxJhOoKYjkBRQQ1BK3LCKUFVixwQM/3bNX4wA50PfIY2A5bO
         sthTukFgoLVg7wBSNM7ALDK0d0F5wKdOYAp/sVpBvHCahZWAR4QOGV11r+M1/4LJu7
         7FRVGXkLhmimzKCf1uEHBB94PA4rbyRtOUqAHLLZkZwVaRimwzpS4n2qrjxqJ74IzP
         mPncFROCfXDAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04040C39563;
        Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbj9V3S7NWzetOngMyJMygNpiYwZKMM+H4zuX227Sof=Q@mail.gmail.com>
References: <CACRpkdbj9V3S7NWzetOngMyJMygNpiYwZKMM+H4zuX227Sof=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbj9V3S7NWzetOngMyJMygNpiYwZKMM+H4zuX227Sof=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.6-2
X-PR-Tracked-Commit-Id: f055ff23c331f28aa4ace4b72dc56f63b9a726c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82a040a8fa9b4f3845eff73a69a9931a59335902
Message-Id: <169714567401.14457.17369647019641409050.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Oct 2023 21:21:14 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Oct 2023 09:20:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82a040a8fa9b4f3845eff73a69a9931a59335902

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
