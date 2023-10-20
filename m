Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44817D16F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjJTU1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:27:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D81A4;
        Fri, 20 Oct 2023 13:27:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70FBC433C7;
        Fri, 20 Oct 2023 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697833628;
        bh=KnUZm/R2IyuO65TDWeBweRiGTQ+zEVOGuGEFW68zwrE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=khE/qLJSYMlExwS2rezUDw9GG+qjU2bV1Gn2FXXDLPZEYFS4nvf2D0v/STPgo0a3y
         f8e40i5ULbq8Gish0hpOyi8En926gb6yb3KTkmqucLToiAdrNJxpbMK8JgcJMifUSK
         A2/mbJXTNaHOlXyo9ChGe9/UxQxeFrPrIrPuiNuqF126Yuw6q6ftJ73GUOYTJGIdPV
         Ylc3tGte5WaI20dYnkrg9Z9xgbl1tGX7G4UeizJwSfTbewPCkVeq8AbP2oXJNVnYd+
         wlPEQwzHWT6gRNphi9wAqmoN3ScOfrWfndZ985hlU9rfVs3aMqRNx91uJd4gSmcY8l
         gmurLB0Lvyo6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6DC3C595CE;
        Fri, 20 Oct 2023 20:27:08 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231020115657.153077-1-ulf.hansson@linaro.org>
References: <20231020115657.153077-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231020115657.153077-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6-rc3
X-PR-Tracked-Commit-Id: 84ee19bffc9306128cd0f1c650e89767079efeff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7da6c042ca0da545682713f3452eecaa18221af4
Message-Id: <169783362867.7501.5420166695389782199.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 20:27:08 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 13:56:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7da6c042ca0da545682713f3452eecaa18221af4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
