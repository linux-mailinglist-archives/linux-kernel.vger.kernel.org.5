Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38187D24D5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjJVROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjJVROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:14:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF9B0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 10:14:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 816D1C433C9;
        Sun, 22 Oct 2023 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994856;
        bh=aT4zb1A0lxY9wWToRPnRECKcdK7oSFlIlh5wZPpQJmc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rKZcOZ8sYAr/xxrH7yicn+cyldh2sdMQt9IUrsma+xM6A8uupyarOGK+7FLydhXQ0
         zqQyETlKDH0hkADc4y/nHPTBEfRyEGWhE8E14fV53LZXbNvW/USY/GLpN1ckCB5gfT
         ACJpeMLfBh4qiBIlDPuL9PUokUYBJ3cVBl28dx+sTH75DVgfiPB4SxrxI+hZ08ld24
         /5tx6l57c8rvI3hlALMzZ98f9K1WV/dUZNTqKJm8M9L7+RZCkopkaas3cg3vzXU3m2
         CuDZBJ8qHDsVjOmFz082w+Ux/Vw+WZUzrgINczrORXzz4eC+pgfjxxcPZSBEteQi6u
         9yYF1qCZTWsOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65E26C595CB;
        Sun, 22 Oct 2023 17:14:16 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTVWUesRwVaLKW+O@matsya>
References: <ZTVWUesRwVaLKW+O@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTVWUesRwVaLKW+O@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.6
X-PR-Tracked-Commit-Id: 089667aaaa6aa33715d22b21a72216b43af3e896
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe3cfe869d5e0453754cf2b4c75110276b5e8527
Message-Id: <169799485641.21820.8303703390627862905.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Oct 2023 17:14:16 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Oct 2023 22:35:21 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe3cfe869d5e0453754cf2b4c75110276b5e8527

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
