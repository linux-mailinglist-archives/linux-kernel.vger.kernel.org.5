Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A280B670
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjLIVLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjLIVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:11:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5957610C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 13:11:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05892C433C8;
        Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702156277;
        bh=9RriohQhNJHinYnpvdMkrnVOugL/9G+gUWkXP/62jhI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dLoWn9JZ1wIjStBj8Vrl1nCp2RNHCO/1nwI6jNirT+TLmpftIVa63JjnQvR2M0lqP
         XR7D08y1cJh9fLk9mZUJ0xBsBkeAHdJ9XYMCbk+H1qZmpyG9NHWxhzOf9ItxRgl1Dk
         +OFxr11HZ575YqBhu1w0ZyER8+exqOkDZUn5VxDYhDIPeFrypZtE4hVPsIWPyM76p8
         46t6I9O3foF0K10ntZESBdeey76+caIMM4LDZUe2H3grfPn3b94dmYM0/+IxosInw1
         G8PhzWKMG0lNUqIMaylRvbrsbBBePdjvZPycXZvwY5Arfb/EteMdo2BfaVHh/NLB6Q
         u0M78RG3W0ulw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA46FC41677;
        Sat,  9 Dec 2023 21:11:16 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXRxQRNFYbjEevvb@kroah.com>
References: <ZXRxQRNFYbjEevvb@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXRxQRNFYbjEevvb@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc5
X-PR-Tracked-Commit-Id: b7c1e53751cb3990153084f31c41f25fde3b629c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca20f1622b0cb21853c41d2c264fafa88ebba7c0
Message-Id: <170215627695.20711.1789545439475398991.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Dec 2023 21:11:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Dec 2023 14:53:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca20f1622b0cb21853c41d2c264fafa88ebba7c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
