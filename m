Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC427D8F03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjJ0G47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJ0G46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:56:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C2B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:56:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 379B9C433C7;
        Fri, 27 Oct 2023 06:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698389816;
        bh=0gosqyGzFdtDcW5z3eCx+auM0NLPCI4r/8Um4p07iw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O2VlZ9BF2dldfSVV6GD8aQ/XN/TR1Oe+EjTcvxJRZiyNHH0t4ao4KTFIftllj+3wz
         1/fmBHf+LT3yoMXomYBez1QHG7pD2IMqGEY/pZEsTHXzm6g46+3IBU083TIoC2LgR3
         Ty1E+PNQG9N4UJ8KZZqmG8klRb7o7FFT9eqM2WSGjfjCzx8RlkfKVyCcUB6WvslkRn
         2u2x+IfWBm+alH3QivxZT+ddXIA+Puix6HgP92ATyrEU8ycEntp8Ww7zixHTO33oqz
         q1TYeiQ1hy8ocXEeB72bp7erGZWOWBx6rf990WUOjQqSMexkT7quDh2wdyIZkkqlx9
         RaUay61ypFACw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2297AE4CC0F;
        Fri, 27 Oct 2023 06:56:56 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.6 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyx-mqoKY77QsHSD1kEnn1dbg9yERCNn76wVY1Jw0+z_w@mail.gmail.com>
References: <CAPM=9tyx-mqoKY77QsHSD1kEnn1dbg9yERCNn76wVY1Jw0+z_w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyx-mqoKY77QsHSD1kEnn1dbg9yERCNn76wVY1Jw0+z_w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-27
X-PR-Tracked-Commit-Id: 44117828ed5c129a8146585e81262c0025daa50f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750b95887e567848ac2c851dae47922cac6db946
Message-Id: <169838981613.1621.4050256394293077454.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Oct 2023 06:56:56 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:15:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-10-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750b95887e567848ac2c851dae47922cac6db946

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
