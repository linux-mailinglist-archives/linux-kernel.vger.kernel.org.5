Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30D7CD153
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbjJRAbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJRAba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:31:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC33BA;
        Tue, 17 Oct 2023 17:31:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B594C433C7;
        Wed, 18 Oct 2023 00:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697589089;
        bh=4FoHz9Z8aWCHUm7je8sI/1euzWMFjdMPTTsb8ApHUC0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cEsAVliye6CP6RpXi1pLqCfZFEHxeaN/7q35bbntzuU3FRRkzAjd9YoMAzHZymQVy
         2z/rw5qa2CY5zHbnCfhrvV57vIrz9fZv1qhQECQ0f9/Yw66hw94HU1MeMWHXcOgmh1
         vYDIagzjEDT9GLvxxcBZfMq8SXY+j9tkBVpA9HlmUyYcKe5mzB5tc6tZ62VCQEdsP/
         lH+nd7+b8gFQ4RAecgPzn48FGbI9hLZnH4xtgKVmhD7X1bBkiecMPcTLaIw27gZNHX
         hHiJ8/XpEDVjupUdcbxaJAyNuj5HbCNt4057Udi/saXKo/EmNOX7m6/bHBgquSUoQq
         d/QuwpW/qohmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07BE3E4E9BC;
        Wed, 18 Oct 2023 00:31:29 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZS7i38pKFD0/Msus@ls3530>
References: <ZS7i38pKFD0/Msus@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZS7i38pKFD0/Msus@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.6-rc7
X-PR-Tracked-Commit-Id: e8e4a470b677511f9d1ad4f3cef32adc1d9a60ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06dc10eae55b5ceabfef287a7e5f16ceea204aa0
Message-Id: <169758908902.4553.16741062330186147068.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Oct 2023 00:31:29 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Oct 2023 21:39:11 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06dc10eae55b5ceabfef287a7e5f16ceea204aa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
