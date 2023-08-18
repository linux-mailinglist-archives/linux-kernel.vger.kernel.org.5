Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6DE781320
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379557AbjHRSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379527AbjHRSz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361743A98;
        Fri, 18 Aug 2023 11:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7858611CF;
        Fri, 18 Aug 2023 18:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3913BC433C8;
        Fri, 18 Aug 2023 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692384927;
        bh=8u62R3MeM8AltBt/wl6OjeJnRdhf4srCxdWNr0Os1kw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hmWWeM/khNBYNvX4Q8WGw9QVokCLzqzIB7zSQE6O3kU79JZls1eUoI9A00TNd6liF
         TLm9rM752TQMXoE8Q8wi62UxmfTrEdAz6CTDNqLnN0Ysh3iKAUXsW9NwNw3BmAPcjq
         j3eEKru9RTEobOvmcR38FCTkxsdlB1BkA67+Eyh14dtZjLV/66TCbSFN9bd6LEByia
         7HMQ/FsFs/VeD8KnBUmdZ7yufyGmtezfG0Hz0O1bTmMNEUGmkBcrnoSzrbF+NU68dh
         YumgSlUf1yX+lY2rI707xeI4Xw+vVSfdH4dxBdjNn5pcBIdcBTr33ia0gk334lUlXJ
         j4D/Eolh8OOkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21162C395DC;
        Fri, 18 Aug 2023 18:55:27 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230818181649.20814-1-brgl@bgdev.pl>
References: <20230818181649.20814-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230818181649.20814-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc7
X-PR-Tracked-Commit-Id: 3386fb86ecdef0d39ee3306aea8ec290e61b934f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e13eee10521b236b6b96a0e1d7f29c6bf2fd989
Message-Id: <169238492712.16005.6989992896963565949.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 18:55:27 +0000
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

The pull request you sent on Fri, 18 Aug 2023 20:16:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e13eee10521b236b6b96a0e1d7f29c6bf2fd989

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
