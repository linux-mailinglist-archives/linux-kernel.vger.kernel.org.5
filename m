Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA495789883
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjHZRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjHZRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 13:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB05103
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 10:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF4262781
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 17:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 958E9C433C9;
        Sat, 26 Aug 2023 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693072039;
        bh=uhBmf79peKEIXRxB4pt/6Q6UBVaKw810XlsvSb863y0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Phf5x652phHJMTUHxonAkU9cXD/cpARLGm5Jsy55zp1AMvuDrI/2j0AUyzyQf6WdD
         rezVCqrgb+Y8jIth3suPeGmnoFQgkJoZeH/H2GaPGrV+0O7IoWPmSJZDFLAspAunJh
         JHY/u7M0fT+ThjdqZZE3TCOqOP9ovnaCiAM6CHoD3VLfRmSJTcFJ58dEVcFOFXuFSn
         4s2dAyFqYqnClJsKjG2dH8P26CwyF7Mplvow4/i7wBWUbFLAAdbDc0HcLgR5ZFN38B
         4pqz/AZh5hHwRlRzDQfCwRTpE04wrmjzH7D/jkR45SC1XQtE7zii8mytdxcpPYGyOB
         Csu7Ec0av8MDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B9C5C595C5;
        Sat, 26 Aug 2023 17:47:19 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169307056577.365848.9161706896082150847.tglx@xen13>
References: <169307056577.365848.9161706896082150847.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169307056577.365848.9161706896082150847.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-08-26
X-PR-Tracked-Commit-Id: 9f5deb551655a4cff04b21ecffdcdab75112da3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b35375f19fe87b5d8822ce01f917095d575ee28
Message-Id: <169307203949.18628.15800413691041446091.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Aug 2023 17:47:19 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Aug 2023 19:23:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-08-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b35375f19fe87b5d8822ce01f917095d575ee28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
