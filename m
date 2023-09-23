Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C484C7AC4A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjIWTI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIWTIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:08:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54EC136;
        Sat, 23 Sep 2023 12:08:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D9E3C433C7;
        Sat, 23 Sep 2023 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695496096;
        bh=67Kfr5HV9SA6cpEXoDCCiVD6+M7wA9DGXAF8B7a6NqY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VAm/H9o1J1V0h0EDYU7bdFOxLlEyJKspPsPBYFvfBv0nMqtIUihjbflbAme9uaprA
         fjbJLdfsN1dTXBXIgmO+WF5b/X7ODHkgSK649o3Hx/Uy601g2T5lAx5FGzWvGnsg5D
         YUNPPybDyWHEIaiVEoKuJ/HWY2RF5RtScczhsJqWQddA6IEJ0jl4m87TJkX5TbcyTJ
         lllKKHOpB+GJmYHhpR782aMNInx9q1ob0WLU5Bb90GoG1KYH4MuOCf1xkPwqsasOGu
         J9BZlgqoXo3ICKQ84ABY8XPs9hemLPlr088maBRnFeZ2vbm2jFXmoAs6QCLrgoDB3x
         2IzgAHf3oT6mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38863C561EE;
        Sat, 23 Sep 2023 19:08:16 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230923185226.6218-1-brgl@bgdev.pl>
References: <20230923185226.6218-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230923185226.6218-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc3
X-PR-Tracked-Commit-Id: 5cb9606a901a41f2ffe37fb8528bb6fbfb5d90e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aba70aed91f2b283f7952be152ad76ec5c34975
Message-Id: <169549609622.2215.4308803228959521082.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Sep 2023 19:08:16 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
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

The pull request you sent on Sat, 23 Sep 2023 20:52:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aba70aed91f2b283f7952be152ad76ec5c34975

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
