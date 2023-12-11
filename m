Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFF80CAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjLKNTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:19:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62240C3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:19:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB4AC433C8;
        Mon, 11 Dec 2023 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702300778;
        bh=14b8MaU/hnBaYQlH8lI1a2ICpqFlCvxCCLO/vs+uke4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CMU126IqISHpe+SzvvYDAcxghaGz2CDphwzr1Tac6jVTZBK5HfZw8Dz85qvRyNyga
         Ke/D7HhAZOau2OkzBpsKX/0gR9QnKKOZjOFO9rnsuzLGmui/92fYFvZ1BB90NOpVrj
         y4e/2N+2t1GhEnJuxUPio5eENx/+L5rEyF3GmJIGBq4AvVYhYsQHYuo1SrzzkxebHJ
         2XT5yba3fNNxm4fAs5QnQfzc1xTiKocFJXIFrvEUfCptyw2WK8VqnM8wbg7XpZZd8e
         m4BgkXKi9IzZXsIg9ji5VjlEHxSgCe7KJfKI1dErIxBOJM4PL8+SdC5KNSX+4s6qJF
         21o7/86+3i+PA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        van Spriel <arend@broadcom.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: wireless: brcm,bcm4329-fmac:
 allow local-mac-address
References: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
Date:   Mon, 11 Dec 2023 15:19:32 +0200
In-Reply-To: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Sat, 9 Dec 2023 17:05:05 +0100")
Message-ID: <87a5qgq3kr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Some boards come with local-mac-address property.  Allow it, and
> mac-address as well, to fix dtbs_check warnings like:
>
>   apple/t8103-j456.dtb: network@0,0: Unevaluated properties are not allowed ('local-mac-address' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)

Wireless patches go to wireless-next, not net-next. But no need to
resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
