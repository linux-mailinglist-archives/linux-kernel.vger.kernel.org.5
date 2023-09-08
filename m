Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D07980BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjIHCzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 22:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbjIHCzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 22:55:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF81BD8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 19:55:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEC50C433C8;
        Fri,  8 Sep 2023 02:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694141735;
        bh=2x4EIX8a2elX+igj7sK4WgjaaYP5CdkNUDpmldy92AE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cu5GcRy5TpOawF51dz8ECEISbkbK3XdEJf2KUL/Zc9wHU00FuM7SosIqPxlFb5V1t
         XTDLDSF2ralvm5nYyHb7X1mOXZydhIzNdg6NxpMDIDkZIxiTyzQqV5+/2sN8KH+U4i
         tjHj5K6DoZXdKNxVnSEGTr2RfARF0dIBzi6pf4kPD3EH+BXZqtmVIvuQHvF+PluRZW
         ozyTVC5cGgoeKp2HyOjMt0kyayEi69wnKZ61CCU1p7b+czdb4UP6ukXHJhORs64Cr9
         /dBNglRMh6XzclbbpvPTTmrNb2biAhW4VzBGFCsSF4wDPcQGL48I9GRJLvD/4HxX3v
         n06fE7uytcy7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B80CC4166F;
        Fri,  8 Sep 2023 02:55:35 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx-wOoVEc96nkOh=E5rDhsn-QM+QJF5oeYQK-yi2Cy8uQ@mail.gmail.com>
References: <CAPM=9tx-wOoVEc96nkOh=E5rDhsn-QM+QJF5oeYQK-yi2Cy8uQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx-wOoVEc96nkOh=E5rDhsn-QM+QJF5oeYQK-yi2Cy8uQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-09-08
X-PR-Tracked-Commit-Id: 43ffcd6fa1635f479ad73145dfbba59edc2b3b28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a48fa7efaf1161c1c898931fe4c7f0070964233a
Message-Id: <169414173562.17056.8974388469030565712.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 02:55:35 +0000
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

The pull request you sent on Fri, 8 Sep 2023 12:45:13 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-09-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a48fa7efaf1161c1c898931fe4c7f0070964233a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
