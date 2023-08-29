Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BA678BC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjH2Bro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjH2BrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6449188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E95A6192A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A19E9C433C9;
        Tue, 29 Aug 2023 01:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693273623;
        bh=mKf794YVQMiy9EgDrDrUkjjyqF8tyizJNAaCgTjm+vU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DmDNotGnEIT/UI+Am51OwJPqG7VqPXL9H3gGv6PAUxJYwtZ+PlvCd//aUzrDv+8/z
         CLYXtkTQhqslvywg+1txEdzJony73mWzEwGOmDHi5tpgkJJBFRsUBlmJBtmpJixVN3
         RaHz9jVpxrSPDbHSutSULsHQQEHyWU4GeBbgZyOVomA7EGp02o6imDBLHGCHqN5XyD
         mdBQSd508nimU9l/TduB9ydR2A+ORZwKLjeMeckG7/bkQU0cw4lCUGgpAF2Q59oNNs
         oPZWvY+0BcyDyerq82iRIWwOiyZacu0IcQMV689fFpKk0fixZr8ZMKHGIJujMTarVs
         cZ0CcsUPVQ/Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CD59E301F2;
        Tue, 29 Aug 2023 01:47:03 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform-firmware changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOwaiFUu3BI+G8JA@google.com>
References: <ZOwaiFUu3BI+G8JA@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZOwaiFUu3BI+G8JA@google.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.6
X-PR-Tracked-Commit-Id: 0979e7e3cfd7b479c34dc0f7217beb0c30f8028a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2927d2261b539834d0bd483088c116106b440de6
Message-Id: <169327362357.21367.17204662814389782609.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 01:47:03 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, briannorris@chromium.org,
        jwerner@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:54:48 +0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-firmware-for-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2927d2261b539834d0bd483088c116106b440de6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
