Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4FD7E4E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344170AbjKHBGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbjKHBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:06:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D0181;
        Tue,  7 Nov 2023 17:06:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF60BC433C8;
        Wed,  8 Nov 2023 01:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405588;
        bh=W9FJeNOl27WMdf9j00bZjas4/oW4h65PfFvWmZEmKh0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N9HwmGbg553eE8f1KxMJLxyGEa2IBrMIdsIDRu/+AAf+955NrEWDOnfNmdZc3bf34
         CYuGk0DFQpOp5tyhsYIe1nc+WFBouyE5oIYgrzTFNRo+Y65WLL2i8LQVOQhWa98JNG
         Z/+0SRiFQmF/Ed8FeLd5L292QUXpCzqOFb/SeXww7yU4DyHt7pFP/7457wGuW8xaxl
         BV7pxUS6zxiziWyg3qnpPozba80afu3WlGoH2xCpOVVuS7jMfslqnGP+GatTbZ7IIM
         lTgEBZzGMD7HpjVqhzbj322mKsBzExKDgQzDyYSl/pKZj4E7BYUi8jbv3biZOmqpC8
         kAFgqL/cMPhdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC244E00083;
        Wed,  8 Nov 2023 01:06:28 +0000 (UTC)
Subject: Re: [GIT PULL] gpio/pinctrl: updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231106091436.10946-1-brgl@bgdev.pl>
References: <20231106091436.10946-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231106091436.10946-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-pinctrl-updates-for-v6.7-rc1
X-PR-Tracked-Commit-Id: 5be55473a06475cc1128ccd93831ff57a068a81e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc1434801d2ee8b57286f587877e67d2f9b699d6
Message-Id: <169940558869.17903.8322954910336919928.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:06:28 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 Nov 2023 10:14:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-pinctrl-updates-for-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc1434801d2ee8b57286f587877e67d2f9b699d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
