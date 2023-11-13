Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA987E95A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjKMDmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMDmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:42:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE101735
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:42:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AB5BC4339A;
        Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699846957;
        bh=Q3dq8DWnMulOXuMjQiCpfSy9K1thZhja7kCVRzQH/SE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gV2mwSx7+d9q+b8byiM2msq1fQ2ScwKmbKR/chG1biZ5R+gXbVW+kbEvMJ9HFWzHE
         qt14N+sBNq1k5eVaGsw/gdZad/sJyXvZlFjwwCIfzmUrtOrteUVDKD9MQYYQIi3NYf
         uJ9AAwhxrhmpuwoqF0EqWHZOeMTqWUbuNpfIa5nB/nbaRSJVFRb4bNSVnDIRv2wjli
         gFJNCC78bgJvz0FUPTKejPHb3x3Np3YBkr3+WF8r3q2ypOE4HonbxpjdWtErKAXgl1
         VuNhLgwuZz+iDtTAVQGH7SVFcsLEyafwZWuD4NxSBB0gu0TET69vlMw0LR8Nt+paOI
         XEMU9s5Q8Em6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DCF7C4166E;
        Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] media: cros-ec-cec: Add Constitution to the match table
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984695718.27851.18210928534967877237.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:42:37 +0000
References: <20230911081921.3515928-1-sadolfsson@google.com>
In-Reply-To: <20230911081921.3515928-1-sadolfsson@google.com>
To:     Stefan Adolfsson <sadolfsson@chromium.org>
Cc:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org, bleung@chromium.org,
        groeck@chromium.org, rekanorman@chromium.org,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Hans Verkuil <hverkuil-cisco@xs4all.nl>:

On Mon, 11 Sep 2023 10:19:21 +0200 you wrote:
> From: Stefan Adolfsson <sadolfsson@chromium.org>
> 
> Constitution has two HDMI ports which support CEC:
>     Port B is EC port 0
>     Port A is EC port 1
> 
> This patch depends on "media: cros-ec-cec: Add Dibbi to the match
> table".
> 
> [...]

Here is the summary with links:
  - [v2] media: cros-ec-cec: Add Constitution to the match table
    https://git.kernel.org/chrome-platform/c/5bc2de5f517d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


