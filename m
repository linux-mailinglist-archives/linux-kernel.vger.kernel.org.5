Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43E2768796
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjG3Tnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjG3Tn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F3C10D3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8C160D2B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C6D7C433C7;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=g9gdrixpqlNSTbPETv89wbLvgcp0InT6aFppuMELvfA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F/JYREye+pNLzybjbvlBKVcxaffGaUBQfmnPNQAumQWYZCfK9V5lBQkhr4MdGlVSg
         XlXod5cCTky2aNLOopWVJ9QgMDhd2ngVfnKRgt5mM85wM9OMfCSyIUEvo4ipv0hmgL
         Jv193s2dwF4DfolJHJKWnTH3sNX5UtdD60+b3aXnW200/QLHMCQ+3WjV0lX3ei74rn
         QuH+cJ3nc4nWfnQq+4L0NvypMwRZgne1yQoxWQF+3akVdFWdltfyRFzujiC/HrCeP1
         WjOyQrE0xhyxFe3V5r1TPq8PgcJSZBcPBil5cHbvew+0lcZxh62qpxedwvUZMFHL4f
         0SBljsGRk2enQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7873BE1CF31;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMZEFScpcIdjLiFy@kroah.com>
References: <ZMZEFScpcIdjLiFy@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMZEFScpcIdjLiFy@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc4
X-PR-Tracked-Commit-Id: f8ea95021022826a010f56cf19451c21f4c9c155
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf270e7b751478a0834acdc6068edc58fead82cd
Message-Id: <169074620648.25913.8671681019810192600.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 13:05:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf270e7b751478a0834acdc6068edc58fead82cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
