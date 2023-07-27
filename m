Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D5765C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjG0Ttk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjG0Ttc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D23AA0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC5E61F34
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FDD6C433CB;
        Thu, 27 Jul 2023 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690487363;
        bh=Wbgis932cyiG44DGHcBWLc2Vm6VDTEzHGBJM88sapvE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fMNdF/bKaGu3Ypryes20U1w/ZTaf90YaZRIBNjqkgT6Ub47LE58lbpfNeCZJCQZ1i
         1TMzDSiY9LvHdqRM1okyr+MTvMGz6f9r7BVySSRlmB1YgiD9EapAuQH8a0AVhrDX1d
         p9avSXXpZ6QMXctLtmmXlUylMv4BLW2i2Gdg7r527uxvIb902rw0VzB88ddwsUeQPW
         1UyXvsqSfI31v85MKimOI77nZVDbPsU3x21Uo6Sr/3PnnaoFgnoMEY/20APhDvdM3b
         CsBqT0eoDUbuLSkVyWxHR8a1FSW2WTO60dEkSQcd57KivNnYI8MDywAi54WEfOA0XZ
         OMQOi6dDuQREw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BE19C40C5E;
        Thu, 27 Jul 2023 19:49:23 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMJXZoBpjdKbGwxa@matsya>
References: <ZMJXZoBpjdKbGwxa@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMJXZoBpjdKbGwxa@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.5
X-PR-Tracked-Commit-Id: 13c088cf3657d70893d75cf116be937f1509cc0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53c8621b9e6c3fa2607cb36db76780f6e327f57d
Message-Id: <169048736303.11614.15426494648462493791.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jul 2023 19:49:23 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jul 2023 17:09:18 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53c8621b9e6c3fa2607cb36db76780f6e327f57d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
