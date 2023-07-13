Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B180751E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjGMKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjGMKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B895EE77;
        Thu, 13 Jul 2023 03:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5298C60B61;
        Thu, 13 Jul 2023 10:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598BCC433C7;
        Thu, 13 Jul 2023 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689243125;
        bh=/5oVE1fJ7Rx2kQ67M6w6B7PP2FoE9gDbLowtvOYnBOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1pL+jJTbYn8cptPQcOTkhQBa1MoOO/BIrg/NT3tDhdSO30upwPdUD2295WN6UzLW
         kvS7VSx0tDvy3TgUXjIzqUQWXgBi/FIrm4sd3EXKyVBhnyiZ4SkjcB5KDaJqWz6mEu
         tGUz2ioKF7fnZkzivfafmHuyyQsuIBABINjISl5SnONlNdZuNyfGh77fHVcuwq/5/P
         3v28e++CCy7l7B9ThIUjI4avlcviaSfZMrMio0hVd/z/so1zKorgpLjO1Cxpj+mkny
         5OF7RWKxNl//IVzdxbSlVItge1N6Bd+W+diDJ5c4srCKnfzrAQ7ATgrQEqTnRPJ7/9
         TyC3EkM2/sPBg==
Date:   Thu, 13 Jul 2023 11:12:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     baomingtong001@208suo.com
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: cht-wcove: Remove unneeded semicolon
Message-ID: <20230713101200.GL10768@google.com>
References: <e66d4beb79da0bfa18269c390f1ed5ef@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e66d4beb79da0bfa18269c390f1ed5ef@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023, baomingtong001@208suo.com wrote:

> ./drivers/leds/leds-cht-wcove.c:193:2-3: Unneeded semicolon
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  drivers/leds/leds-cht-wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed I'm afraid:

https://lore.kernel.org/all/20230531024020.106641-1-jiapeng.chong@linux.alibaba.com/

> diff --git a/drivers/leds/leds-cht-wcove.c b/drivers/leds/leds-cht-wcove.c
> index 0cfebee98910..e35a25990048 100644
> --- a/drivers/leds/leds-cht-wcove.c
> +++ b/drivers/leds/leds-cht-wcove.c
> @@ -190,7 +190,7 @@ static unsigned long cht_wc_leds_get_period(int ctrl)
>  		return 1000;
>  	case CHT_WC_LED_F_2_HZ:
>  		return 1000 / 2;
> -	};
> +	}
> 
>  	return 0;
>  }
> -- 
> 2.40.1
> 

-- 
Lee Jones [李琼斯]
