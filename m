Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A775E229
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGWNyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGWNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DFB1B7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB1E60D29
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECB7C433C7;
        Sun, 23 Jul 2023 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690120445;
        bh=8UmRKeIIXsCLYTpLQTebDRdHxayrX1JSrie8+aA5LIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VkQRlJ4dbLqj6y2N4nbkUbHycLhOOxNp85p5uuuUFouil4ollPE1/sIvAeOPlNAxf
         c8p0kufk/qUOA8cSeqYkEqKLusLFPExidlJDH8N7YPitIN3NHKu8WAmbBK2qP6VUnZ
         A6Coj9LrX67+AX6n0w1P8S131e9d2+fvM9UwHljKBX/Md6ejcTAhLXxfu7KPGAWFoY
         McFeGRPGWZYVNg7FU4drMYcttHZb57FGWwOat5XevuGLN5aLdRNeZ974C4Ojo+ppng
         fVdx+4oDcChoU+DfNFkdkbp+Wrt0qA5z23uAcfpnXYD3fdhcoXyNG+gnx7TCF3rzAD
         gNIRdldZQNlhg==
Message-ID: <a75290b3-a224-b431-971f-1240e09b52e4@kernel.org>
Date:   Sun, 23 Jul 2023 22:54:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drivers: extcon: space required after that ','
Content-Language: en-US
To:     hanyu001@208suo.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <tencent_5D4E47E7BC2D92FC229E6245684D90B2ED06@qq.com>
 <25d422c1ac26f0c59ef10a8a2afe057b@208suo.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <25d422c1ac26f0c59ef10a8a2afe057b@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 7. 17. 18:03, hanyu001@208suo.com wrote:
> This patch fixes the checkpatch.pl error:
> 
> ./drivers/extcon/extcon.c:321: ERROR: space required after that ',' (ctx:VxV)
> 
> Signed-off-by: maqimei <2433033762@qq.com>

'maqimei' is your name? 

I recommend that you can check the guide of 'submitting-patches'[1].
[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Please update your name.

> ---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 6f7a60d..4ef4422 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -318,7 +318,7 @@ static bool is_extcon_property_supported(unsigned int id, unsigned int prop)
>  }
> 
>  static int is_extcon_property_capability(struct extcon_dev *edev,
> -                unsigned int id, int index,unsigned int prop)
> +                unsigned int id, int index, unsigned int prop)
>  {
>      struct extcon_cable *cable;
>      int type, ret;

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

