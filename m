Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4D7B8D95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbjJDTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjJDTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:45:13 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E7D9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:45:09 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id nydyqJ0ZqnGhUo7nwq4t8M; Wed, 04 Oct 2023 19:45:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id o7nvqQtCJ2fRco7nvqHe0b; Wed, 04 Oct 2023 19:45:08 +0000
X-Authority-Analysis: v=2.4 cv=BcnLb5h2 c=1 sm=1 tr=0 ts=651dc0c4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=gDw6DpxkxgdD51dURPUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=anYsrMBVpJk91YyTJNycNRtxZORGmKUYN5KZZKzlb0o=; b=Kap34x0o9igNLIQhVI90uQhneJ
        Sg2O9YfHoeuLC0SvUZQXEvWFfs9iHUnHa5+fvByNoJHS4Ncu9dcLwfcApr+JTi/ddpBQDrk9JKsmD
        X9YpSAIEh5SEtRWMFHM3ZPcUKem1aBFs3oJzJp/gc8mR4tt6vfscGpIEwdSk6lsHv+0NJUg0PxVR9
        Yw6xiLHzNBQoKUXpYPEv/cE84AyizKwtceGiyTqXd6f6oZs/7zuJfwSYqAbVp0CzkS7pTtsBylR5z
        7A/PZhbkPClxffo3ASexlioRZECxa9S0NZv+Jcv6LHtwMdIZehxKt75mQoIauDbbkyD1diOJkPygj
        VJ6kt+7w==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:53198 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qo7nv-002Qsv-0B;
        Wed, 04 Oct 2023 14:45:07 -0500
Message-ID: <0cae6f7e-845f-f76b-1594-46df17cf20be@embeddedor.com>
Date:   Wed, 4 Oct 2023 21:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231004193441.work.109-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231004193441.work.109-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qo7nv-002Qsv-0B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:53198
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH/phRpjUsp//MId+4Ak6nKW02oJI97XkWTPdXQ2Kp4BnpyrxJLo/wQzaV3Lb8lMq/vcJIu+Vk7qV+aEvrvf077qnYflmvg3NjWj4YGM4jvpWraId7Gl
 pXec3nnYSWAjoFp+VnFhGIWACyUXjElD+V2jcopn90ylokoYgmf1XXVXRm6/fUS8q40V7zujZL/mvasS3dVYHLfFy9X58pfDOd91rQ3V6OUMa0RUUzX7oO9k
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/23 21:34, Kees Cook wrote:
> Make sure a few other paths are correctly sent to the ASoC maintainers.
> 
> Link: https://lore.kernel.org/lkml/63dd3676.170a0220.1f1b2.3244@mx.google.com/
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f18ed0fbd42..585a13b9b52a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20116,6 +20116,8 @@ F:	Documentation/devicetree/bindings/sound/
>   F:	Documentation/sound/soc/
>   F:	include/dt-bindings/sound/
>   F:	include/sound/soc*
> +F:	include/sound/sof/
> +F:	include/uapi/sound/asoc.h
>   F:	sound/soc/
>   
>   SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
