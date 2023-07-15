Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCF7549F3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGOP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145492D7B;
        Sat, 15 Jul 2023 08:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A724260BC5;
        Sat, 15 Jul 2023 15:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14744C433CB;
        Sat, 15 Jul 2023 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689436655;
        bh=RWJwEhnf9ue0Z+WjssyNBHzxXS5l1v9lxxuTPPH+4Y4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QXWDWAmMz4KGHGg0K/gKMR316/TumTdW2hhoWLFR1Lit0/i838bJWpL5FK072GfSy
         AopyzVgTwBenha5kWuEbgsugyer8rLhV4rLC/0k3IS64Te1LdGuykRgYZ3a0zNcD0z
         RAnZzcUE3WWigMKNiR149Z/stFRz7FWAkwrxLeSXod8EhYibAKRz7YX6dSu3igAg6G
         0g10+j+y0bXo7GXV7M4UJ0kBmyjGCxBDidIf97yiLKL0NW55TxbW4QcovJAURq+Gg2
         UErn9UzPDZz1X9/jyXm2aBCG/fsACGcje0Es2QhUzdVxbz1R0hekB7vgDEEd5VziEx
         1sYHwxf7jsbvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFE29E4508D;
        Sat, 15 Jul 2023 15:57:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230715115326.333B8C433C8@smtp.kernel.org>
References: <20230715115326.333B8C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230715115326.333B8C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc1
X-PR-Tracked-Commit-Id: 54ccc8758ef4d29de9e8fdb711c852abbdd4103a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 831fe284d8275987596b7d640518dddba5735f61
Message-Id: <168943665497.17130.8459550455688557328.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 15:57:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jul 2023 12:53:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/831fe284d8275987596b7d640518dddba5735f61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
