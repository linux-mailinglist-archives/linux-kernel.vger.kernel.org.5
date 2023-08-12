Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FDE77A1DD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjHLShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHLShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D81BD2;
        Sat, 12 Aug 2023 11:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A685C61EB1;
        Sat, 12 Aug 2023 18:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165B4C433C8;
        Sat, 12 Aug 2023 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691865431;
        bh=5tdx5IjG8w0LOT3JK7EyuuFp4VNSwl/Ifij9X7GWy3M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G2W9wb7JEMRg5MSi89c2VvXlwVBh9j/+9uA9a5Nzkzy/rf6+6Y8eZvI+8wj8PP0PH
         5nZqosqZuWHpyAx0zTBCsv0ENISy9gwKGeeH21lt7J62jwZVvm8AerHi1IXQQAN7uN
         nSzhoPgzY4julrmBF5es7T927nO/h1jAVO7WQujs06cerCsFez+rnlF2pFmqAHQANh
         IfV+36fJodcuK2+U7R3IgJp8RVfNk+yfvSX1GAPd4HGBCcBBrmDGtxfNXaAXEpfT2B
         ZMczmGyODNc1WPMtQukEOeUegroYXCsBUXmivaaLRzmPfA6LzCq3if37frMH6Dpcxv
         gnNdJpWiMudYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0329CC3274B;
        Sat, 12 Aug 2023 18:37:11 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230812182625.5059-1-brgl@bgdev.pl>
References: <20230812182625.5059-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230812182625.5059-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc6
X-PR-Tracked-Commit-Id: 33f83d13ded164cd49ce2a3bd2770115abc64e6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae545c3283dc673f7e748065efa46ba95f678ef2
Message-Id: <169186543100.31272.3331439682746532199.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 18:37:11 +0000
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

The pull request you sent on Sat, 12 Aug 2023 20:26:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae545c3283dc673f7e748065efa46ba95f678ef2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
