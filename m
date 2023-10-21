Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0E7D1F4A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjJUUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjJUUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:04:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B3E1A8;
        Sat, 21 Oct 2023 13:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88D77C433C8;
        Sat, 21 Oct 2023 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697918649;
        bh=edF7HgVFXCsjn+Nkmeq1Y5LTQ2/2dxV4GJfVJ1I6iQY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oQ4LlLEA2vjUv3kCQjx1Vvynq+gAUlegIEKtNYT94dF7gQ+FgB48PCrvZk7zkvCwL
         SAo3hbdgoGT2ZXnH/W01ocF31Sju/e7ifXZdmQukAIug62/yyp95SDOl2wzFBCpxnA
         rO/e6PMDYOa+orJ1eYqwTJ1mhg6cDwi7NFy6z7OoHGVCgNE1sDVR3N+FjbUCupRzZU
         GJr8MIeNwQgglqVRLfm8WRH2jeCYSbOU52J8G5vh1H52JH0LwffLO/2LwaBPPPxtfr
         vBHl94DDVgB5COCkgMbwzy+eTOpE28aHADNqqS2w2lfRojn1kiHQuIniFNX0n/F0B3
         NobyuU7SyrqoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 759EAC04DD9;
        Sat, 21 Oct 2023 20:04:09 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231021183925.22831-1-brgl@bgdev.pl>
References: <20231021183925.22831-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231021183925.22831-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc7
X-PR-Tracked-Commit-Id: 479ac419206b5fe4ce4e40de61ac3210a36711aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d537ae43f8a107761fb5a85c3f0cfce5ca79bcb1
Message-Id: <169791864947.17709.5454949955924110702.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 20:04:09 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 20:39:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d537ae43f8a107761fb5a85c3f0cfce5ca79bcb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
