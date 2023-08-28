Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9578BA48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjH1Vae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjH1Vac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE42FC;
        Mon, 28 Aug 2023 14:30:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40CF96187F;
        Mon, 28 Aug 2023 21:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A14DFC433CA;
        Mon, 28 Aug 2023 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693258228;
        bh=4mdroGjnxpZE8Scj2CwPQ8Rax4tOaAYzjd0Qf2HyADQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ow2UCMI60GVvUCHf/CU4vSKKdXCQs9wWzZcColox6YPA4S1Yk639c2bSASKDTluZO
         8rVwARLtRQ8YY6jjDChECQqypUSSr0ROKzfdyhsDdAPHBkuKm824JZA1Gy3NnxIrTs
         E9LuYBPeHmoT2aKpPTuO5dl2AACEHm9pYRdt/TKCIQr+p++WhRzGxFeV1VCRrV71of
         ImcEDRlnWbI3/dEfyYzQINr49Pqa5AyPY6p1i+b0y19z5xBKPpYyXUEePSY0RKb3yT
         EKOxpr0GiDn9LAWoDSWLv7B2WE7P9TQ3gIjtx1aSdrZjFsdsk/iZW+3slIKoNn9D3x
         hwhWwT3ByTNnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86BE3C3274C;
        Mon, 28 Aug 2023 21:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btusb: add shutdown function for QCA6174
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169325822854.15582.16525727470056383392.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 21:30:28 +0000
References: <20230807064626.980-1-quic_rjliao@quicinc.com>
In-Reply-To: <20230807064626.980-1-quic_rjliao@quicinc.com>
To:     Rocky Liao <quic_rjliao@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 7 Aug 2023 14:46:26 +0800 you wrote:
> We should send hci reset command before bt turn off, which can reset bt
> firmware status.
> 
> Signed-off-by: Rocky Liao <quic_rjliao@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v1] Bluetooth: btusb: add shutdown function for QCA6174
    https://git.kernel.org/bluetooth/bluetooth-next/c/75d095daab9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


