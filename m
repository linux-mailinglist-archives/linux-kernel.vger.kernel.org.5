Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AFA757620
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGRICb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGRICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:02:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB721FD6;
        Tue, 18 Jul 2023 01:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D77F614A3;
        Tue, 18 Jul 2023 08:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55606C433C9;
        Tue, 18 Jul 2023 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689667217;
        bh=VO2jH8lq8taVP1DYJhkjKHmKZeUs79kd9zAM6eUj1VM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jFBVCfxqYkp6qCZHpNS4tOUgJ2OiyVnHOa4U3/8Lmi4P7KkoNaVJIKYQuJ5MJENwg
         rp931Bc1sz5AxmXZuubfogoVSDTsUgfW9WtFGMZqhTS0QY8ybYas+Wbmc49IpGx9qC
         FCqSY3xP6SZ5GwC/v5hR3oLznBvYg3ccyN7c95PFKk6Wyq8CQt2cPTagGhBenUfMlb
         H9gl07XcxPqqjumiiKH4IXxuHKRK4R1HJqOzWaBYf8krczKrcb3Jfvm36RKKOpZs0R
         SdkTnmFy9z4gxrwCed3iP0upDhdEMlpzQMYclcDJrVV+yeX6v+0Qe9rKtrtlbnFsu2
         sc02S/EzlROHw==
Message-ID: <c43fbdfb-520a-14fb-6dba-4d8b5ef1716a@kernel.org>
Date:   Tue, 18 Jul 2023 17:00:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ata: pata_parport: epat.c Added missing spaces
To:     hanyu001@208suo.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_DAE8C1D6AAA3633E096977B14E5133F42705@qq.com>
 <5a75c59282fbe38bc4637c95c66f9151@208suo.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5a75c59282fbe38bc4637c95c66f9151@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 16:57, hanyu001@208suo.com wrote:
> Added spaces needed in the proper places to address:

wifi ? I do not think so. Please fix the patch title.

> 
> ./drivers/ata/pata_parport/epat.c:283: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/ata/pata_parport/epat.c:283: ERROR: space required after that 
> ';' (ctx:VxV)
> ./drivers/ata/pata_parport/epat.c:283: ERROR: spaces required around 
> that '<' (ctx:VxV)
> ./drivers/ata/pata_parport/epat.c:283: ERROR: space required after that 
> ';' (ctx:VxV)
> 
> Signed-off-by: Yu Han <hanyu001@208suo.com>
> ---
>   drivers/ata/pata_parport/epat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_parport/epat.c 
> b/drivers/ata/pata_parport/epat.c
> index 016bd96..efc18e2 100644
> --- a/drivers/ata/pata_parport/epat.c
> +++ b/drivers/ata/pata_parport/epat.c
> @@ -280,7 +280,7 @@ static int epat_test_proto(struct pi_adapter *pi)
>       epat_disconnect(pi);
> 
>       epat_connect(pi);
> -    for (j=0;j<2;j++) {
> +    for (j = 0; j < 2; j++) {
>           WRi(6, 0xa0 + j * 0x10);
>           for (k = 0; k < 256; k++) {
>               WRi(2, k ^ 0xaa);

-- 
Damien Le Moal
Western Digital Research

