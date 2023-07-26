Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB2763EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGZSnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjGZSm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6691FEC;
        Wed, 26 Jul 2023 11:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4821761C43;
        Wed, 26 Jul 2023 18:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC1F1C433C7;
        Wed, 26 Jul 2023 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690396974;
        bh=fPJqAiXBh26QKoB9iCHp5l441C4hOZXs7UUi0PSEtg8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G8AD770uxbGY3OPwNQEVzWnM3NqGInuYVBF44nncpSzgvDfmMWXYSGE5tyekHcAAm
         mZ87rVmF2jqmea1Mi//KQMThR75txOd1eGG90QVfOgiiVmnS3XrOGY3ZEB581Dyi93
         VpLKpWKDRC9H4pCFgaME+qWBN9yLbbYWeytI1sb/66JV6JP5klnqFEQIFp7I7cSeZ3
         I5Vd6ITFQ7ap8MNf0ZPY8vckZ/zGCwKXQ00YncBte3aijKVcr1T8phcQuax0qvL7hT
         97h0jeVhTUVXRpms8Sxjb9kCRPQaEuv7xltaN8cTCdurbFXpSWVp4ZCb8YhAUfpOD4
         i+fAhbGjQ+OQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94300C59A4C;
        Wed, 26 Jul 2023 18:42:54 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.5-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ac0f0e92-ea4b-4d47-dfd5-cfe8e0b95f55@redhat.com>
References: <ac0f0e92-ea4b-4d47-dfd5-cfe8e0b95f55@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ac0f0e92-ea4b-4d47-dfd5-cfe8e0b95f55@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-3
X-PR-Tracked-Commit-Id: c21733754cd6ecbca346f2adf9b17d4cfa50504f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
Message-Id: <169039697460.1355.15284262975101914748.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Jul 2023 18:42:54 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jul 2023 15:46:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a8db05b571ad5b8d5c8774a004c0424260a90bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
