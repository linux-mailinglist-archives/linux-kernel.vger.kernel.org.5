Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201E7EFB3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjKQWQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjKQWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:16:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E882B8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:16:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8B43C433C7;
        Fri, 17 Nov 2023 22:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259363;
        bh=vHQWHkR2s5hvcml5B0eCa2ti7wRd/Ge3XgHQk01EksM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lM3m1fxA/ZMOWetH1nzJHlF4THJkh9XVJrIq24tbyZNrC8wSoAwjIQiHGS8tALWdM
         wR9ZSx83dc/sZBIeoHsCdLRE9zrWQ7nXEn9FrPDCW1lTBdqCetD3c4MXmLBfwV9h36
         nOmTnIqgPUJNYMW1MfPfqbixX2a31Rpt322MyHCcAgG8dJ59lKZuwCSJzBFQzLl5uG
         Wh46A7duClwu2aOProLpwtD4yhhbFMv8A1Bz8WfMBNDgDD1OA6d6JylsgmV15OzvLE
         bRozchRu1yc3M0BxulEHrgGrLwZEaHrYgp9b7d2J/J+MqINrwG5x8pJDmf8S4pv41M
         19h+vpfGVIKag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97AFBC4316B;
        Fri, 17 Nov 2023 22:16:03 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for -rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZVecnXhAAVeIMvSv@phenom.ffwll.local>
References: <ZVecnXhAAVeIMvSv@phenom.ffwll.local>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZVecnXhAAVeIMvSv@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-11-17
X-PR-Tracked-Commit-Id: 86d8f905f24d223e15587365f07849635458c5d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e63fe2d35ee095b483adf936747dbc7d85f3de38
Message-Id: <170025936361.27809.12057052611328562731.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Nov 2023 22:16:03 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Nov 2023 18:02:21 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-11-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e63fe2d35ee095b483adf936747dbc7d85f3de38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
