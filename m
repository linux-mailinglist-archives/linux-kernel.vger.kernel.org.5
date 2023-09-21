Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056817AA26B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjIUVQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjIUVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:15:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06BA65A3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:00:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E79BC433C7;
        Thu, 21 Sep 2023 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695319205;
        bh=ur67oKgiQq9nYWouwkNWSlSc2yj+Rpv/Pc0kH5IxwGk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MPS49xVVj0cTQnbPkgTbJ3lZMyIPyEYpDRqlCM0DNNjpbUgC1tbUpWleySUsCBYAK
         +PUKPfEUY/YirIqCfXT3172A/YjlLW2JEXQ2ipiLrYybjteI+otfAy2GKNFRK7M0Vj
         GwJpRoFqx2nNg1zNiu6sQnT15+aNSHPa4vK3yFLGBQxDw89c7NMtP4hxD++BSD3Z11
         urL+0ukCiPZZo8fDn4fajJNKTjjCERNmeBHmLq/QQ+097Y04DKwNyfattnvW6lbdOt
         Ads9r4QtOCG+1U6XoYAbmG9dRaDLy+OKs7llfI1luffVBLJtM4yykD5jrZgaiepKx4
         MA0izKFH49usg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FF59E11F7E;
        Thu, 21 Sep 2023 18:00:05 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a5tfzjuv.wl-tiwai@suse.de>
References: <87a5tfzjuv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a5tfzjuv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc3
X-PR-Tracked-Commit-Id: 0eb0e272e4bba794d7bf679780bf8336799e7cc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2af5acbaa74c91266457fa1494685729d6f9e540
Message-Id: <169531920499.32421.16325900060838942053.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 18:00:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Sep 2023 16:22:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2af5acbaa74c91266457fa1494685729d6f9e540

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
