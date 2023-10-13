Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA57C7D32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjJMFu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJMFu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:50:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19998B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 22:50:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA28BC433C7;
        Fri, 13 Oct 2023 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697176254;
        bh=OISlfEAwEbvJoELnfX5DkuXhX7txLnKPZdwnb/+v7+M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r8bgPv+npN8k9huYXof5H5aEzWJ+/RWkd5KGbrZVv62EKzPeYfuK6Oyn2xwoTI+OK
         kPPJmKc+dpWS0tk+K1PkXmQ+vfv/OzluqUrgFOH7e6bcEtNDWropDU+nqFU+lIBWCQ
         h7RCa9H0GJi2xzWsHcsfDCaw3xsfsRz2JcLbXpIPuXTY2G+2KFHUpIF5CMbvZy/6Ky
         m2STJFOxkc9XkoRBELBXA8jCkO++DkNGaFawK1nZ3DOVByds3Rrjy7NQ3jF5Rz0kJ8
         ZXrGjygoGfU/qavsBOxKwxwgryipo86duLEdYMXYRByaJcADtC+Tiwn+8qpvBRNAcP
         cyDk5YqFKcM2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A806EC595C3;
        Fri, 13 Oct 2023 05:50:54 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyejWiiT5gzqGxCTkp5P6Xk1c9=Gbart2LS1K_YgCis+w@mail.gmail.com>
References: <CAPM=9tyejWiiT5gzqGxCTkp5P6Xk1c9=Gbart2LS1K_YgCis+w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyejWiiT5gzqGxCTkp5P6Xk1c9=Gbart2LS1K_YgCis+w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-13
X-PR-Tracked-Commit-Id: 30873697b83743eda54d66ea9a3ea83554f8a535
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10a6e5feccb877c3c75ad11d27942ad52c24815f
Message-Id: <169717625467.1627.8568251109952249019.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 05:50:54 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 14:24:48 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10a6e5feccb877c3c75ad11d27942ad52c24815f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
