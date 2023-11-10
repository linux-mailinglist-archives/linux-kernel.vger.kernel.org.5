Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F47E8640
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKJXJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjKJXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:09:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A4AC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:09:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6DE6C433C7;
        Fri, 10 Nov 2023 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699657755;
        bh=A3dPl7sC2yMREeU0TjeOfJHa7WpR5SD38E5IBjbzRqg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xr6OikodRoSzX04XeqkZqMomqosSjPL1zO88PB2g87haNN+Z1m3JoqwYfInsO69O6
         /hq+s6u0sM7Gm3gO0ut84/gwkutQ5+d9n6e0o9s1rveUbWzNvzsx9dYTHdPVXltq/O
         2RoyA/bo7JckNmEyTKfPGheCkSbvKEWwGiRFYKGDA4iJaZYwjGWQx/Sv6aO/4RUkVD
         Zlz0Wqc6HtJDfHZk9Lsf/TFtxjH5N21rfPVX/g0Ve6d0S5kwE+VwzVayHz8s4k0WEy
         d2/5EDj8/yXwAEUGibt3hojPCEWUt1boWDPZfG2Kd6/7jOEOPgwEA6HVFd7wavTWgo
         tM1G1NnfQo1WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6097C4166E;
        Fri, 10 Nov 2023 23:09:15 +0000 (UTC)
Subject: Re: [PULL] drm fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZU6XKgI7FZsIJWoq@phenom.ffwll.local>
References: <ZU6XKgI7FZsIJWoq@phenom.ffwll.local>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <ZU6XKgI7FZsIJWoq@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-11-10
X-PR-Tracked-Commit-Id: 03df0fc007ca4713fa1e716329af556f981807e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0d12d769299e1e08338988c7745009e0db2a4a0
Message-Id: <169965775586.1420.12718189167614144876.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 23:09:15 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 21:48:42 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-11-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0d12d769299e1e08338988c7745009e0db2a4a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
