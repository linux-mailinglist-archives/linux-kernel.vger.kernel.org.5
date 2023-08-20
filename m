Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0386781CC0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHTHBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 03:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHTHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 03:00:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A1BA279;
        Sat, 19 Aug 2023 23:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D1D60C6E;
        Sun, 20 Aug 2023 06:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2334AC433C7;
        Sun, 20 Aug 2023 06:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692513377;
        bh=qc6iOGY6OR9VqtaPWSNBRnQ4XvYdtQ/ohSNk6q+2Apk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=khPTGqJxSBeM5/fTXHcvzi7wF8ecRSmKPULH55PqCPWuOAtoqsJ+hXSh9cPKN9bgT
         uHRGuUS69kIs9qunrvzYbreSmf4xh7wf95utvtaXBt0+fOAGNRaGAnN1UFz5kvAVdF
         3yzHORf+anYp5ZU5xrOJ5j1mBjb3/Vkn4AQbsU03dm03XsJ15YR4TaGWPnMCQlNzOt
         CYWeJUVToYd9LQbrCPyLQeCpy6NJuMQXcgdTxseR0PfPGJ6+2qHp2uZ7EqUd2pspMz
         QN21Uj0wjRMkVKzEw7IPl196QVUVxtr2JooBmqYGI/FYR69vBD+l+Bw1IUM0/8roca
         RlKMBjIA8QsHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00D20E93B34;
        Sun, 20 Aug 2023 06:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZOEjxOkOhH7LseG9@kroah.com>
References: <ZOEjxOkOhH7LseG9@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZOEjxOkOhH7LseG9@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc7
X-PR-Tracked-Commit-Id: 04c7f60ca477ffbf7b7910320482335050f0d23a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b320441c04c9bea76cbee1196ae55c20288fd7a6
Message-Id: <169251337670.7930.9227295201466060364.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Aug 2023 06:36:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Aug 2023 22:19:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b320441c04c9bea76cbee1196ae55c20288fd7a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
