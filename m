Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9077CE322
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJRQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJRQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7507FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:44:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68297C433C8;
        Wed, 18 Oct 2023 16:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697647472;
        bh=3seqjKkqfGCbts4NbvZhJmMDKesbX5b7hhjr3W2eUoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UhwP0j4wzmn2UZ9X0HN7Q6WF779hZQ9PGyEXv35XDiekdvN0uQ6PHy6qePFvnpA5z
         M2nGmGxEcvlwDOJA3PCgLQBGk58oQ2FCjhcLYzGacsOVA7wZ2eoImvfA4QDvt37/EF
         bMFfrY/ImlDLMmr4YMol03TG3Fijns0m5GPm47+nbjZrTPu7qomiJKKF9xpoxSE5kD
         gzwFD47h25kh7UM/kf0fOYfnxhWnBpzP/8HI1HTUvX3K01/8oND6tE6xbA8tUKOd/S
         zbor5+eCgI8BPz95rUBL3rYKKvn69EecSy9wUOYNvogVYpL6X4XLN/mc2h5PQZM8/g
         GI3x1VNzh7fyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CB3EC04DD9;
        Wed, 18 Oct 2023 16:44:32 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231018142303.D0134C433C7@smtp.kernel.org>
References: <20231018142303.D0134C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231018142303.D0134C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.6-rc6
X-PR-Tracked-Commit-Id: c6df843348d6b71ea986266c12831cb60c2cf325
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1e80380f1c25aec736ce1a2e46fac9f9631b71a
Message-Id: <169764747230.17503.3676523413221259584.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Oct 2023 16:44:32 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Oct 2023 15:22:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1e80380f1c25aec736ce1a2e46fac9f9631b71a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
