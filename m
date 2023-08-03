Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299B76F476
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjHCVKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjHCVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF532D42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4994E61EA8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 21:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A41A7C433C7;
        Thu,  3 Aug 2023 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691097006;
        bh=y7cFenNYvER0tZ2Ou9IwkALoVOmVrKbFjA08+583F14=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=awBFchzD6PhvjtchRJtA0hgBUZU2CnhikgfjgnrTn8ymtL3vZhH+rZr2IxGHU8vJN
         4GyGdaHmJH3GczIVAZYxN+pndYI7HkbdxT8cAhwXB7hBT5DpmFxr6AlHa33PJzpF1Z
         dnBBT2LWhbJ48JtE0Ctz9WM8BOgKUsiSIcdge6M7buwwGQEdpdPPgx3FASaLyr1Fe9
         2hDJ9W2QHZI0I/XUlzitjjtjeL1nHBD9OKqfhwfsfTxuLX7m3/6lpmt+Fldtrb7GUo
         9wWLuXMfGdgAmt2d+uNmfROQSkI0KA6HK/1Q7tx2O86317VBu8tTP4VbddHmzeITji
         cR0yJtnbY/QIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C83BC3274D;
        Thu,  3 Aug 2023 21:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230803204953.2556070-1-kuba@kernel.org>
References: <20230803204953.2556070-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230803204953.2556070-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc5
X-PR-Tracked-Commit-Id: 0765c5f293357ee43eca72e27c3547f9d99ac355
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 999f6631866e9ea81add935b9c6ebaab0579d259
Message-Id: <169109700655.24731.14940731857907752521.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Aug 2023 21:10:06 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  3 Aug 2023 13:49:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/999f6631866e9ea81add935b9c6ebaab0579d259

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
