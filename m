Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192BB7E6016
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjKHVpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKHVpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:45:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB902585
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:45:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68D6BC433C8;
        Wed,  8 Nov 2023 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699479910;
        bh=ogs20+9YwoXvsdGziktpDf3CVAmo3y6a3BjMo7EJKLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mT0PkV8u6DBie+MZSCDD/3+Tf6Jr5Jq5UJk5xJSM3xWzVNaRlAzNmx/ienUAszbtj
         hE7p/49RutVfdbIB6MloSB1YixGAZHqTzuHkhVJCSi4jUyODOn0fYRYbwp0eUr502N
         aXEn21c25SnY67v+FSuYKhcUofJkFuhl7wl57mxnbxKDXmcEjKnQo6Yj7Oo1Jq0LNM
         ixgyZNDjFtrx7OzcOcUGWDiKeCKaRt4GwhD9dZd53D6fQiIg6u1Yeu3z+6aSGHeTck
         v+J4e1vHyki+2qxiY4HRuZa5NaUXWVBZZXX0w2wHd4QtsTpQ5uj0yLrMxDRMl7B9ZB
         btgo+qdpxtkyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F35CC3274D;
        Wed,  8 Nov 2023 21:45:10 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd-rB+hXUVbCgnRebSsRMH8AK0XzOGJRLqAPX9GFa_9_Kg@mail.gmail.com>
References: <CAKYAXd-rB+hXUVbCgnRebSsRMH8AK0XzOGJRLqAPX9GFa_9_Kg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd-rB+hXUVbCgnRebSsRMH8AK0XzOGJRLqAPX9GFa_9_Kg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.7-rc1-part2
X-PR-Tracked-Commit-Id: 1373ca10ec04afba9199de1fab01fde91338a78b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67c0afb6424fee94238d9a32b97c407d0c97155e
Message-Id: <169947991031.4309.14376787408300740216.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 21:45:10 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Nov 2023 23:20:37 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.7-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67c0afb6424fee94238d9a32b97c407d0c97155e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
