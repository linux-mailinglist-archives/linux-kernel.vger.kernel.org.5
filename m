Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5C7E4E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKHBGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbjKHBG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:06:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6841181;
        Tue,  7 Nov 2023 17:06:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61CBCC433CA;
        Wed,  8 Nov 2023 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699405585;
        bh=9hjr6cnCj92Yx7oXhkGdP6aRiZJT7ItLYkBqFPcQPyc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KU+XZzHt0AhSK2l4CqQ/CJFEl4Q/Ve/wxqdd0BeYkMXKHqFQZFfq2XSa7CpVm0xsJ
         q5OIEQmT8eV8VgdK9gu0HygVzdc/zdsNboogdDt+ovvk1+3KB0fFYzFnF/2aHZ6Rks
         phLv1XedNuqToYHLju1eSWI3awLkOt82hqD9m0DvlcfG4MnIqUafVUUtr4IafpMh5r
         57+A9TR7pEZrjnutoxztFTGfG13tyo8Ox1SmpQhkHmmni3Lu/vHlfdJYK+BPuGGuAe
         iYTahHofTBK7o45+8PCVaTA7tNvwe7yKJ3ZwiYAoQHgshBrNydIxAz474xBBHj3ob+
         n67WjjF4O1X4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4ED79C395FC;
        Wed,  8 Nov 2023 01:06:25 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231107033821.2563960-1-andersson@kernel.org>
References: <20231107033821.2563960-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231107033821.2563960-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.7
X-PR-Tracked-Commit-Id: 3d8a18697ad834436d088d65cc66165947cfe600
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8dd631fcabe2656c8d3751ad4836131d51fb63b
Message-Id: <169940558531.17903.15713318507226366426.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 01:06:25 +0000
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Tanmay Shah <tanmay.shah@amd.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Rob Herring <robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  6 Nov 2023 19:38:20 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8dd631fcabe2656c8d3751ad4836131d51fb63b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
