Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F3977A0F3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHLQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHLQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1110DE;
        Sat, 12 Aug 2023 09:08:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 173AF61ADA;
        Sat, 12 Aug 2023 16:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D017C433C7;
        Sat, 12 Aug 2023 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691856496;
        bh=9zOmrBxumPSg0T9VWmqZqGSvPJzJdkaUsqjCFM1NNzM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ApJX/N2fq3SCHOxR0szBRLzjiDlaM1ukTfPUOvdKfnihsBbTZs0Z4meRGa22nH1qQ
         ny6yZ46L2HY2evTK3CvWwMnT/VC3ArQIFbqaM0WupXo09O2WIw7NHZ5m7Adkwz0yTA
         DfAPYNcxae3WLLxIymZZobM1HtI4JWSDFeORFFJMV4Wjy5duydUpBTS2upLsocGj9n
         cdpyXpcPnojkxrz4vcxmL39jZctY2nIhl/dJY51iwxtg0ebk43SiYEK2F4ZRsjm7wa
         6f0zQKY2bpPjkQE3/fgFSExWw6ViSYdM6Kba80/FbobNkrrvLRxnorlgliNA8Ea5Gs
         hI+CIDOWNfZYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A6F6C3274B;
        Sat, 12 Aug 2023 16:08:16 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver fixes for 6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNdcIir55QE1o2mO@kroah.com>
References: <ZNdcIir55QE1o2mO@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNdcIir55QE1o2mO@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc6
X-PR-Tracked-Commit-Id: f48585c468f51ac038c2cfaafcd4437bc3746bce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 469a2f504188003d76718f99a4f5755c4d369b74
Message-Id: <169185649642.27778.13108638173727750026.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 16:08:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 12:17:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/469a2f504188003d76718f99a4f5755c4d369b74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
