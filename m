Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC6768799
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjG3Tns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjG3Tn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65281702;
        Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F0E60D36;
        Sun, 30 Jul 2023 19:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A09B0C43391;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746206;
        bh=4q4lnzt7Q0DjSYopZav5iFdCPaxRgMxSPvC/6QrRzaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=loTtookROa1S9UcV3ww+YrTUtUdfe5srH+CSuJr/3llc4yAFvDk3rERLJHtW9Bg96
         f8hJIjwtvjKnjUYG1i6esHPObV7R4nWRlPeR/yPuGt6D4ySCIkWyg0+5c4t0DRlOZn
         ahXWHabzYgUX8Ic7zQS0ZFecRgJik9ZeuopayUH+IcIlvSkdm38KqBF37+QPy05qRS
         EeM5CIiKyr6eHTFDa7yzSBkdaMxkiMlNNccy6DCHGMuC3xbyNpssFMAs3sau2wKZC2
         BcmHGHsLtPPm91+8uK1oGJEByoYDeDTNz+IsqUVVKkAvue9P1M4NUSz7LFSSgvlNeZ
         bIP7q5uUorKAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F2FAC39562;
        Sun, 30 Jul 2023 19:43:26 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMZEgcrNeJRvKlY-@kroah.com>
References: <ZMZEgcrNeJRvKlY-@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMZEgcrNeJRvKlY-@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc4
X-PR-Tracked-Commit-Id: 748c5ea8b8796ae8ee80b8d3a3d940570b588d59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6d34ced01bc3aaad616b9446bbaa96cd04617c4
Message-Id: <169074620658.25913.902732364931866569.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 13:07:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6d34ced01bc3aaad616b9446bbaa96cd04617c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
