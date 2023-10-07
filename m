Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4B7BC98A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjJGSMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 14:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjJGSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 14:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E0B9;
        Sat,  7 Oct 2023 11:12:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70406C433CA;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702354;
        bh=YE2927SzhdPNefVxdWYVlF0nx0Qt4tA8lLodVCbqAbE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nQXBk7BXrrBVlFs3SMu6xQ+JUuPGfsWF38NjjOT/X8XLvKfq57YiqieRnz77eEnXs
         Ehb02RyQpUnNDMcoQphI2S+Pl4OcSU5NCoXkgFlKB2WF/WygCVOFQtqoWkb/qnVh1q
         qOL53V+bIzGOlQUe9xiI4OgdpP5lSf7lGYGife009WqW4S7ThFU3B6MpMAWWRnioNR
         5FU5oKiJ3CvwKj15qpK5+8xi3sZHcfqYd8KqCK81g6QGzEwyBJELixNKM733tC9vK4
         ivpjXSbKHwBC9jyw/QNRlKRv3yK81sS2uqsbmPVNNQHc14O46pdP9x0mhsgomKpT9g
         L05VxFxgke4zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59AE3C41671;
        Sat,  7 Oct 2023 18:12:34 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231006185734.39969-1-brgl@bgdev.pl>
References: <20231006185734.39969-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231006185734.39969-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc5
X-PR-Tracked-Commit-Id: f9315f17bf778cb8079a29639419fcc8a41a3c84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22823378add28f439ff43170a00f3cc92e000356
Message-Id: <169670235436.17695.10277262851941121724.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:34 +0000
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

The pull request you sent on Fri,  6 Oct 2023 20:57:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22823378add28f439ff43170a00f3cc92e000356

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
