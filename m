Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718387B37F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjI2Q3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjI2Q3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D739199;
        Fri, 29 Sep 2023 09:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27569C433C7;
        Fri, 29 Sep 2023 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696004959;
        bh=HGaubEFyHjFkx2AmofjsCzBkvCMaPK1NwOEc9AhPVW0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XGTUIXAXBZl9o7UzE2xUp3g9vAq+BpSlRNDeeS4dezIssVLO/kbZDUqtTioGj9poQ
         OTUogpWX5prBHjprqsaLVYcAQwAEoj+sHmEZNuy1k/nalncn5vmXQszi/rWUpTjZvF
         nfEhbTZ6ghRgbuWYGnxH5AOVVPCmq2EVY1RiMIT0N/7TaCciPXIE6Cs3cX9bFibH8p
         MCyk4c+GJ6wiGs9dhEga8pPuceTuQ/Cz7sVyPPlxQR7JnLI3CIieMNSP9AJaONdrdV
         bidWEOkL6wPpy+oN7kNKo1fKb0oPJ66mbJ2BD8dON48QwU4hifBaqIuSBrNi20bB06
         hfieFHHmvRX9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13D8FC395C8;
        Fri, 29 Sep 2023 16:29:19 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230929123124.19060-1-brgl@bgdev.pl>
References: <20230929123124.19060-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230929123124.19060-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.6-rc4
X-PR-Tracked-Commit-Id: 26d9e5640d2130ee16df7b1fb6a908f460ab004c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71e58659bfc02e4171345f80b13d6485e9cdf687
Message-Id: <169600495906.31534.3526579830746784111.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 16:29:19 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 14:31:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71e58659bfc02e4171345f80b13d6485e9cdf687

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
