Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349B78E3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjHaAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbjHaAKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8CCD2;
        Wed, 30 Aug 2023 17:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90EBF634A4;
        Thu, 31 Aug 2023 00:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADE0C433C9;
        Thu, 31 Aug 2023 00:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693440604;
        bh=JTBtiFXM2UjlzF6V4VI9/ysc0+YMhYvcy0J9FsGtr2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Iql69bfaavu+lZhe0w8P0dYT3vuFrrdsowGN9MOd0VnSFnxKMxpMwB38vghFKipvS
         976IMoiYqRLrSGYMqbeGZNpkMtK+5TaQTj8vNCbRzpNwXf0h4U9Aes9p4ytoorIZW8
         UUgpq/vad/BQTVdw7PtfELv0eWY6x0NfpG4WSgmfmWKxqEbPIzEaYXOwa1UAXdrlfl
         yX/AOgRExfLZpRONUd8WHzpahG7fYoUGnaDEDnYgfc/h/N7mxYFi8p7YMGcfPgBn9c
         NThDxFo+a8citcnMzAwd2/FNLoW4khSAL7Q/+7n8xp9DMSgFRmeK75zogHeMY/1J33
         nPL6DoNVEEKyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8798C64457;
        Thu, 31 Aug 2023 00:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230829223410.GA2804587-robh@kernel.org>
References: <20230829223410.GA2804587-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829223410.GA2804587-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.6
X-PR-Tracked-Commit-Id: 75cc186739805a5e8abe133be04692b36e7a5257
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f447694c23a432b2e9cfe67fb2651f8f6655bfd
Message-Id: <169344060386.21437.7401343121635445894.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 00:10:03 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 17:34:10 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f447694c23a432b2e9cfe67fb2651f8f6655bfd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
