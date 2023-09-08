Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8179911F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjIHUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbjIHUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB6AA3;
        Fri,  8 Sep 2023 13:40:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E7B2C433C9;
        Fri,  8 Sep 2023 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205643;
        bh=eToUIZTHu2FYs248Jnfi2mgVqBrYnyTvIrftHHxI7t4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cnk8wZxrcznJsAfNu+bQ4R4e0pnlp5l+ijvv8xTWA0tbyWtgrs/MCViR6Z6XG7Fre
         8crdCEus83DilRMvNYhCZnVvwwbFczeMktd59AQ5KPqlxkKX86qVlFrDt5cNwlelDz
         RRya2nV4kK4crS6QZfCb7Djr3u+HJ6C6kBPoZpud8ow8lnnLnSmJr8nPOaYpb3m5eB
         ZKHTjXhUtU3TXp4bon0O2VwckAKbRgRIQEzVPeh2DsAPsOCuxNZhyVXw9vk6grADDG
         uxrFD0tk6bc9KxhF+MLuYubegIeTzH00QKMx3HotgyT/GExvWEEdOtxQlIiEEF5SJT
         1Q0fuEvKBCQXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0787DE53805;
        Fri,  8 Sep 2023 20:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230908110622.9503-1-brgl@bgdev.pl>
References: <20230908110622.9503-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230908110622.9503-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc1
X-PR-Tracked-Commit-Id: 180b10bd160b014448366e5bc86e0558f8acb74f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d30c0d326b43614c4ca9d31b7e31e806160f1817
Message-Id: <169420564302.32167.538681804103502843.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:40:43 +0000
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

The pull request you sent on Fri,  8 Sep 2023 13:06:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d30c0d326b43614c4ca9d31b7e31e806160f1817

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
