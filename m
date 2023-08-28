Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D974578BAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjH1WQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjH1WP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A4189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708F663C14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8675C433CA;
        Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693260953;
        bh=ZPtH8yRn3sEB+kE6s3HbuvBab36xpRWBdffkPyO7dQo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LJ82xzdT8JsTRsLH6k2+kGfKVj5aNdCLvq+FqAnJ3y9L5UTGOJttUqZRmXh6CzqaH
         evk7bN3c4g8Ef9Ff6xk5md09g5nBgJjyp6oyjrTjNOp0e4wd9zFeX0NeQoUl4jOAIe
         s4Q6AcswZBpnFpw4fzxHyWcDJ8Hl1SqjuWwpFiqQbmxM4nC9OikQo3yotoaYveoJ7m
         GuGsbMDexnY3Ht7wnjs6vFd2C040BHRmgxyXV0Vvk0Dpm0TUFMn+dcd1oHHVZfvXMK
         QJfUs8s92cV/QPsUQBbkRNocX9klljdGo3WJIVQNMjf+uSZqoxfHFlNJy6IX6ZDL9w
         Efr+56eYhs2Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5592E26D49;
        Mon, 28 Aug 2023 22:15:53 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169322654758.420889.12581588922728486948.tglx@xen13.tec.linutronix.de>
References: <169322654636.420889.373907562030292433.tglx@xen13.tec.linutronix.de> <169322654758.420889.12581588922728486948.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169322654758.420889.12581588922728486948.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-08-28
X-PR-Tracked-Commit-Id: 02362c9a99b69aa956f015fa93025221b887684b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd3f0fe5010c2d85801a9c005b9c673908adf36f
Message-Id: <169326095380.8741.7565950133813190134.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 22:15:53 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 15:01:11 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd3f0fe5010c2d85801a9c005b9c673908adf36f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
