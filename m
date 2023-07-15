Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0647549F4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGOP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGOP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E002D51
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3306F60BC1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 15:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92BC8C433CA;
        Sat, 15 Jul 2023 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689436654;
        bh=9GCInhzUEM737c7XpNb1vLsZaaCGfa+dUUjXMDJI4HU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nZwAwcjvtPm8fVzXOXvGJ/x4r3kspJs99d6EYDva0FCdZ5lh3GmZ6oR8CRCf/HZ2s
         JsD/L9S2/fTPtjyX4DYGQ3oH1v9b+Yovdkhnla1T7t8J/yadgTN+MM/OXvJHGBijRn
         aOJi9DSdwtNnQ2H7xiZ/pMyFsr3g7R3BLJgbHpzqx9QlkLCXe7p70xhMh5NSFrghk2
         gnncQoS1PvKaTVzCaCZWBcVLOZlKIFS/az9MnNYqGBPJ3VT4gSMGjOcEMNv77Y1Ta/
         N8HGPGVUBzPNAbV+kEUV4AGIpCAFL4htr46PomtAopNgkhXmjALMVMOU7FFwKlpzmx
         M0k2Ghpgmqvcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73138E50D71;
        Sat, 15 Jul 2023 15:57:34 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230715115312.95AF1C433C8@smtp.kernel.org>
References: <20230715115312.95AF1C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230715115312.95AF1C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.5-rc1
X-PR-Tracked-Commit-Id: 963b54df82b6d6206d7def273390bf3f7af558e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 393ea78172cdc68800285cb43855c9531abc26a1
Message-Id: <168943665446.17130.15116281362313699797.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 15:57:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jul 2023 12:53:04 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/393ea78172cdc68800285cb43855c9531abc26a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
