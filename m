Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173A78F37D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbjHaTmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjHaTmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:42:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B3E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 643F562E96
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 19:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBAF4C433C9;
        Thu, 31 Aug 2023 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693510938;
        bh=DeqlcwFqYeDr6NRkGppQjP1591vz/ICIhWu0ByhfOUg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jRrE2XwbPCJRNVbV33ClKN6I5elDfTYSjZbahwJZ2VlywPxQxf/TLHQwBOHooPCNR
         FOC7UVpHpJwD0SpqPSU1P96jmn3WfABM8xG/5LedhC9d37GtEf0WFjdtrEpU//WhjI
         1ic4NH874ndV4xWzNtiozmREiT/o4PXGAcIR9dq05FUjPiYTxa5UBRRvnJtjxSOD4D
         POvHiaC3Bhha/Mu+OUjY92zDovxBolppdNkOawHEoHrS6gT6tQckDUopmmuDUn2U5M
         1xaNEfKqUbG6YKpqVktONMh5344yqOR4jZq3GVT2E5yRW2QFOR65OwUmt8XOMtRdD7
         F0t5sbceMCKeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD9CDE270FB;
        Thu, 31 Aug 2023 19:42:18 +0000 (UTC)
Subject: Re: [GIT PULL] x86/shstk for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230830234752.19858-1-dave.hansen@linux.intel.com>
References: <20230830234752.19858-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230830234752.19858-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_shstk_for_6.6-rc1
X-PR-Tracked-Commit-Id: 1fe428d3692fb10a0e8d85fafe719b154e43ad4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df57721f9a63e8a1fb9b9b2e70de4aa4c7e0cd2e
Message-Id: <169351093869.17020.11759987259056660659.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 19:42:18 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Aug 2023 16:47:52 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_shstk_for_6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df57721f9a63e8a1fb9b9b2e70de4aa4c7e0cd2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
