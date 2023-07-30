Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F776879B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjG3Tnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjG3Tn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8146CE44;
        Sun, 30 Jul 2023 12:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714FD60D37;
        Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF236C43395;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=oNkkLwA2dNWTA88gl2+U89c8ZkRTX6JkHxpGiOGwd9E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ooTngQwxHKlMgbVqUbIvLqrj0JtlAdoA6b4kRQeu3ivdC2quJIt0z+t49mTyX7fZA
         xyOQ5ODLDPir23lVrUqSUnzY4LXHUL7O7xLFwR8Ngz4lHB+3oO4kSk+GUQVU00InPe
         j5+v0R15LK+rsrldwelYmCjabYAjbGM8zDw2IrKFJzYXFcXODql71VNUnozIGBzoxF
         4HNpffmZhICI4NpkYTlAnxsxMvx5Kgryte34peLtoqbserG/BiyzmbYVd1XxTQTrcg
         LzgrEWsyW7s6/g2mhWZ2P/mREb6uBSGPFO+GPkLtNsnIXK7rZx8RZvJnATT0JG7Phu
         IhB+vyN1/BwQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C89AC595D0;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMZEoJr2cPzC-Pss@kroah.com>
References: <ZMZEoJr2cPzC-Pss@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMZEoJr2cPzC-Pss@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc4
X-PR-Tracked-Commit-Id: 7f2327666a9080e428166964e37548b0168cd5e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88f66f13ea51029280d3f91feafb6d66296c95d0
Message-Id: <169074620663.25913.6025370919549229764.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 13:08:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88f66f13ea51029280d3f91feafb6d66296c95d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
