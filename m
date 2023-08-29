Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88578CBCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbjH2SIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbjH2SII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4EB7;
        Tue, 29 Aug 2023 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6079C60FC8;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33785C433CB;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332486;
        bh=pGOmvWwkYpF5bV4Nd2TKkRKzv33Z6bVWhMPRgRUGaMM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lvSXLHrgkaj/yPrO4Sk6+LEpRfc+MXN+YdVov2BbjjpBry4kzLC/B3LwY2EUF1rIO
         GIF3Qki/mnjpRiOe0oWh7SZBKf8JY5lbnCl1tgI8GHfCW4ausb/b2w9qBb598wNwwF
         Qi0pSc5wpzAwNAwc83iRYe9o4MlwksXNhUghHJg8JnvpKmC9ckaJKZKIv1EVRZyc1s
         8dZRwr3ic5l4fERNXVEvLWUzeRIIgAVM++c9TwqSLHbAzx3NQ1RQApo+KksQs3txAs
         rDaFc0Hn4siBqnTAEjti6Tbi6VotNAITb3RDoR1ipknhtZtdBICOnp4Rs9ZCcLMK4q
         FlaPSsOc6sZCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21EE1C595D2;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3f23f4016225109af97b67053a757218.broonie@kernel.org>
References: <3f23f4016225109af97b67053a757218.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3f23f4016225109af97b67053a757218.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.6
X-PR-Tracked-Commit-Id: 60ea3db33fbddf559e18567ca8897f6bb9f25290
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b6bf5b1f8e3d17d7566027cdc5a8262991eb5bc
Message-Id: <169333248613.16601.9944423193853594402.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:18:15 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b6bf5b1f8e3d17d7566027cdc5a8262991eb5bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
