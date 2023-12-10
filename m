Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9180B894
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjLJDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjLJDjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:39:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF7FE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 19:39:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B82AC433C7;
        Sun, 10 Dec 2023 03:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702179555;
        bh=Yfi8InVXnRHz78EJfOI3vWdOueWfrDP3laxolarXdSA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GwizNV+7I3OFDRNH0DaVBtkR0vqzTLkpkZamX2nhGEogRqoYu2Ors5LWiagOrMWkP
         6YES5YQ5maREDwyfiouc9l9go74vUCwue2bt8EdSwtIQS54pkQVZYXJSdx2Ea5g075
         NVRmEFDHXh4QUn8rpjcpdxB74ruJAPkm6rha4HZb8muFqKkVWnn2VdoSvvbIgK3xcW
         rilN1PW8Cw7ZerTfIk+LjaqbdlXC0wSp3pKLh3ODCItOKCB1QjeQZ5rQ9NRwrqQIuU
         e/+rsJZ2nGCQ7dZ15jjS89pNs0Ebpxz37MXoZpq+wl8H635Tc7aniirusO3P46fVAO
         J2dujiikiJ3oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 561F3C04E32;
        Sun, 10 Dec 2023 03:39:15 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231209193319.6993-1-brgl@bgdev.pl>
References: <20231209193319.6993-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231209193319.6993-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc5
X-PR-Tracked-Commit-Id: 95dd1e34ff5bbee93a28ff3947eceaf6de811b1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99d4cf7659554c2c9c5e4c0808782759b7d32bbd
Message-Id: <170217955534.29712.10074286834085008000.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Dec 2023 03:39:15 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  9 Dec 2023 20:33:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99d4cf7659554c2c9c5e4c0808782759b7d32bbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
