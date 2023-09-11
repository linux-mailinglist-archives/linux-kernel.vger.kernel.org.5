Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C785479A29C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjIKEtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjIKEtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE81115;
        Sun, 10 Sep 2023 21:49:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D888C433CC;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694407740;
        bh=4iGN1mNqjhTv2/45qd5GAIWS2WXD3KccY9OqIJAh7lI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FwMGtnw6Lqjn3s+1QST4ObHA1pKHhE3vdVtkAjvmU2sBou2VFeHaL8JsSBsrMuXj+
         E0+JUeHxqds9zH/DMmSzbOmbfk2GmT+QK3rMvc/P0109nxXY9AV0HqQgNaNznFyiH0
         aw41EJNKpozRJrIcLxMzaSzZYmXbYlLh9aKAN9eSl3kCS1hPcdf/96/rnfr0oysDfU
         bOG5pOsz9/lk4apbE1BKgypWLqPVhjn2TPS9lfLAaw97pGSzrhWNBJcObIFWLV2bUl
         h/JsNocgEvwTqyy6l555xZU2MhH6vsOp2yWaqSboTdesP+OjYR2QFJIuT2VpWcJENi
         Vj/F+zxaU060g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28E0BE21EC0;
        Mon, 11 Sep 2023 04:49:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: usb: connector: disallow additional
 properties
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169440774016.22573.10427035970076911833.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Sep 2023 04:49:00 +0000
References: <20230725102325.76336-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725102325.76336-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, bleung@chromium.org, groeck@chromium.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        waynec@nvidia.com, devicetree@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
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

This patch was applied to chrome-platform/linux.git (for-next)
by Rob Herring <robh@kernel.org>:

On Tue, 25 Jul 2023 12:23:25 +0200 you wrote:
> USB connector bindings is complete, thus no additional properties should
> be allowed.  Add missing 'reg' property and change additionalProperties
> to false, so the schema will check for anything not unexpected.  This
> also allows to drop the 'reg' from other bindings referencing the
> usb-connector.yaml and make it required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: usb: connector: disallow additional properties
    https://git.kernel.org/chrome-platform/c/e251a4e28a27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


