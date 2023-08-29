Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4678CBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbjH2SIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbjH2SII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448B19A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318CC659F8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02377C433C8;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332486;
        bh=PfyQfJfRV4BCGp8vuQF9sFBHXhqjmZkMODSC6mosxto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m3UerboworaU37mGTlnXuqD+aa52VUULmdk/Xe6gk9Uv2FVJakVsPuamQToruB4gi
         lFtndbnDM4AC2EclZriVHxTISYjGb7bN6M9sUlmpk0lyn7WZPoz2tW09USsqxihX2s
         meGJ9pNJ3uTNcbt46z2CxihXRxCoTBSANnwelsbbBIp/Bz9+VlAwS+ZUwdTwSezGB4
         c2CXpStnY9v62N9uHcKFVt/3mPFEMPqTog/zQKyqhIbBY7MWuJErpep2HxKcmcLR8R
         rcOCGB0Veot+krTdYpUPVnZ48I9ign3+F/UHnug7YOkg56mKtCKec1QafGcwmKbU1/
         WgyOBK9RLnjlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4B14C3959E;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <19ec033cd2489b6d03dc83c30de493e9.broonie@kernel.org>
References: <19ec033cd2489b6d03dc83c30de493e9.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <19ec033cd2489b6d03dc83c30de493e9.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.6
X-PR-Tracked-Commit-Id: b96c22476ff4bc3459933f87ba52cbb7910ffc6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65234f96f2570a6e4bb9649fff4f7c17b1e43508
Message-Id: <169333248593.16601.9176560367033397560.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 11:17:45 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65234f96f2570a6e4bb9649fff4f7c17b1e43508

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
