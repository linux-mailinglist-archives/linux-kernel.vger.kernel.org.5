Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD32801FCD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjLBXwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjLBXwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:52:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9514107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:52:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 927A2C433C7;
        Sat,  2 Dec 2023 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701561164;
        bh=J1C8bWiwa1AsioJ91/bEJjDNytv+lkcsQxOrNx33I2o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lveCnwYcVvm4DDlmZ0oGDxPg7DE94WxLmUUQfEDDYdLToHLMZmsrrFbJDGTQuj9TF
         vwIkjzTOtYsvsMj/ED/VaJr8WcSXIr4j2YqyA2hQNH0dNh8xWIfcTw2eTe5sO+FFwy
         Zb8wvQcm3CuVLh3MS1xLto70bL6n2vGwjgHTcchJAS9vvlrPZp3H4EqXBekpiRpLkd
         M05YcCm5GMaUMXUCwM3+2HAyC9zYwZaryyUPa+fFvd/c/AAzHh4xGJvOjlEq7QuZMD
         As9XpTUTPm5TshsyaSG97Pr5gD+USTPgMeB79PEt6LND+5LwyJIG3KcG5KcWfIaVeT
         bJKWgV5LVvBCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80895DFAA84;
        Sat,  2 Dec 2023 23:52:44 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87jzpw9p2g.fsf@mail.lhotse>
References: <87jzpw9p2g.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87jzpw9p2g.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-3
X-PR-Tracked-Commit-Id: dc158d23b33df9033bcc8e7117e8591dd2f9d125
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b8af6552cb7c9bf1194e871f8d733a19b113230
Message-Id: <170156116452.30388.428583211197102420.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 23:52:44 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        tpearson@raptorengineering.com, daniel@mariadb.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 03 Dec 2023 10:12:23 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b8af6552cb7c9bf1194e871f8d733a19b113230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
